class MedicinesController < ApplicationController
  before_action :set_medicine, only: [:edit, :update]

  def index
    @medicines = policy_scope(Medicine).all
  end

  def new
    @medicine = Medicine.new
    authorize @medicine
  end

  def create
    @medicine = Medicine.new(medicine_params)
    @medicine.user = current_user
    authorize @medicine
    if @medicine.save
      redirect_to medicines_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @medicine.update
      redirect_to medicines_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def set_medicine
    @medicine = Medicine.find(params[:id])
    authorize @medicine
  end

  def medicine_params
    params.require(:medicine).permit(:name, :description, :dosage, :dosage_remaining, :unit, :start_date, :end_date, :frequency)
  end
end