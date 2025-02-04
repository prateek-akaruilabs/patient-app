class PatientsController < ApplicationController

    def search
        if params[:query].present?
            @patients = Patient.where('name =? OR email=?', params[:query], params[:query])
        else
            @patients = Patient.all
        end
        @patients = @patients.paginate(page: params[:page], per_page: 2)
        render :index
    end

    def index
        if params[:type].present? && params[:type] == 'upcoming'
            @patients = Patient.where('next_appointment_date >=? AND next_appointment_date <=?', Time.now, Time.now + 72.hours)
        else
            @patients = Patient.all
        end
        @patients = @patients.paginate(page: params[:page], per_page: 2)
        p @patients
    end

    def new
        @patient = Patient.new
    end

    def create
        @patient = Patient.new(patient_params)
        if @patient.save
            flash[:success] = 'Patient record has been created successfully.'
            redirect_to patients_path
        else
            flash[:danger] = 'Patient record cannot be saved. Please check the errors below.'
            render :new
        end
    end

    def edit
        @patient = Patient.find_by(id: params[:id])
    end

    def update
        @patient = Patient.find_by(id: params[:id])
        if @patient.update(patient_params)
            flash[:success] = 'Patient details have been updated successfully.'
            redirect_to patients_path
        else
            flash[:danger] = 'Patient details cannot be updated.'
            render :edit
        end
    end

    private

    def patient_params
        params.require(:patient).permit(:name, :email, :dob, :next_appointment_date)
    end
end
