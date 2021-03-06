ActiveAdmin.register FillTheBlank do
  menu priority: 7, label: "FillTheBlank Exercises"
  permit_params :inputs, Exercise::ADMIN_PERMITTED_PARAMS, Question::ADMIN_PERMITTED_PARAMS, HelpLink::ADMIN_PERMITTED_PARAMS

  index do
    selectable_column
    id_column
    column :exercise
    actions
  end

  show do
    render 'admin/exercises/show', object: fill_the_blank
    render 'admin/help_links/index', object: fill_the_blank
    render 'admin/questions/index', object: fill_the_blank
    active_admin_comments
  end

  form do |f|
    f.semantic_errors

    inputs 'Base information' do
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

    inputs 'Questions' do
      f.has_many :questions do |question|
        question.input :question
        question.has_many :text_answers do |answer|
          answer.input :answer
          answer.input :_destroy, as: :boolean
        end
        question.input :_destroy, as: :boolean
      end
    end

    f.actions
  end

end
