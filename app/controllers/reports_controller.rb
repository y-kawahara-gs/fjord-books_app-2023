# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[edit update destroy]

  def index
    @reports = Report.includes(:user).order(id: :desc).page(params[:page])
  end

  def show
    @report = Report.find(params[:id])
    @mentions = @report.mentioned_reports.order(id: :desc)
  end

  # GET /reports/new
  def new
    @report = current_user.reports.new
  end

  def edit; end

  def create
    ActiveRecord::Base.transaction do
      @report = current_user.reports.new(report_params)

      @report.save!
      set_mention!
    rescue ActiveRecord::RecordInvalid
      render :new, status: :unprocessable_entity
    end
    redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
  end

  def update
    ActiveRecord::Base.transaction do
      @report.update!(report_params)
      @report.active_mentions.destroy_all
      set_mention!
    rescue ActiveRecord::RecordInvalid
      render :edit, status: :unprocessable_entity
    end
    redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
  end

  def destroy
    @report.destroy

    redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def set_report
    @report = current_user.reports.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content)
  end

  def set_mention!
    urls = URI.extract(@report.content, ['http'])
    urls.map do |url|
      next unless url.match?(%r{http://127.0.0.1:3000/reports/})

      target_id = URI.parse(url).path.split('/').last
      next if @report.id == target_id.to_i || Report.exists?(target_id) == nil
      mentioned_report = Report.find_by(id: target_id)
      @report.active_mentions.create!(mentioned: mentioned_report)
    end
  end
end
