class StudentsController < ApplicationController

    def index
        student = Student.all 
        render json: student, include: :instructor status: :ok
    end

    def create
        student = Student.create!(student_params)
        if student.valid?
        render json: student, status: :created
        else
        render json: {error: "could not create student"}, status: :unprocessable_entity
        end
    end

    def show
        if
        student = find_student
        render json: student, include: :instructor status: :ok
        else
        render json: {error: "could not find student"}, status: :not_found
        end
    end

    def update
        if
        student = find_student
        student.update!(student_params)
        render json: student 
        else
            render json: {error: "student not updated"}, status: :unprocessable_entity
        end
    end

    def destroy
        if
        student = find_student
        student.destroy
        head :no_content
        else 
        render json: {error: "student not deleted"}, status: :unprocessable_entity
    end

private

    def find_student
        student = Student.find(params[:id])
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end
end
