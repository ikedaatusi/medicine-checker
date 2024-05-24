class CalendarsController < ApplicationController
    def index
        @q = Drug.ransack(params[:q])
        @drugs = @q.result(distinct: true).includes(:take_times).order(created_at: :desc).page(params[:page])
    end
    def show
        @day = params[:date] ? Date.parse(params[:date]) : Date.today
        @drug = Drug.find(params[:id])
    end
end