class Post < ActiveRecord::Base
  before_save :compile_markdown
  before_save :generate_slug, if: -> { slug.blank? }

  scope :published, -> { where(published: true).where.not(published_at: nil, slug: nil) }
  scope :recent, ->(limit) { order("#{table_name}.published_at desc, #{table_name}.created_at desc").limit(limit) }
  scope :by_publication_date, -> { published.order(published_at: :desc) }

  def path_params
    {
      year: published_at.year.to_s,
      month: published_at.month.to_s.rjust(2, "0"),
      slug: slug
    }
  end

  private
  def compile_markdown
    compiler = MarkdownWithPygmentsCompiler.new
    self.processed_body = compiler.compile(body)
  end

  def generate_slug
    self.slug = SlugGenerator.new.generate(title)
  end

end
