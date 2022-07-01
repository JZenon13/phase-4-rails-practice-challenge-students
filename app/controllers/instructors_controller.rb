class InstructorsController < ApplicationController

    def index
        instructor = Instructor.all 
        render json: instructor 
    end

    def create
        instructor = Instructor.create(instructor_params)
        if instructor.valid?
        render json: instructor, status: :created
        else
        render json: {error: "could not create instructor"}, status: :unprocessable_entity
        end
    end

    def show
        if
        instructor = find_instructor
        render json: instructor
        else
        render json: {error: "could not find instructor"}, status: :not_found
        end
    end

    def update
        if
        instructor = find_instructor
        instructor.update!(instructor_params)
        render json: instructor 
        else
            render json: {error: "instructor not updated"}, status: :unprocessable_entity
        end
    end

    def destroy
        if
        instructor = find_instructor
        instructor.destroy
        head :no_content
        else 
        render json: {error: "instructor not found"}, status: :unprocessable_entity
    end

private

    def find_instructor
        instructor = Instructor.find_by!(id: params[:id])
    end

    def instructor_params
        params.permit(:name, :major, :age)
    end
end
