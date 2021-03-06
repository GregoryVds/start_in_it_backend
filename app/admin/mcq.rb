ActiveAdmin.register Mcq do
  menu priority: 5, label: "MCQ Exercises"
  permit_params :type, Exercise::ADMIN_PERMITTED_PARAMS, BinaryAnswer::ADMIN_PERMITTED_PARAMS, HelpLink::ADMIN_PERMITTED_PARAMS

  index do
    selectable_column
    id_column
    column :type
    column :exercise
    actions
  end

  show do
    render 'admin/exercises/show', object: mcq

    attributes_table do
      row :type
    end

    render 'admin/help_links/index', object: mcq
    render 'admin/binary_answers/index', object: mcq

    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    inputs 'Base information' do
      input :type, as: :select, collection: Mcq::TYPES

      f.object.build_exercise if f.object.exercise.blank?
      f.semantic_fields_for :exercise do |exercise|
        exercise.inputs do
          exercise.input :track
          exercise.input :title
          exercise.input :difficulty, as: :select, collection: (1..5)
          exercise.input :duration
          exercise.input :short_description
          exercise.input :description
        end
      end
    end

    inputs 'Help links' do
      f.has_many :help_links do |help|
        help.input :description
        help.input :url
        help.input :_destroy, as: :boolean
      end
    end

    inputs 'Answers' do
      f.has_many :binary_answers do |answers|
        answers.input :description
        answers.input :value
        answers.input :_destroy, as: :boolean
      end
    end

    f.actions
  end
end
