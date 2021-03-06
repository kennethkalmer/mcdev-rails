require 'spec_helper'

describe "home/_speaking.html.slim" do
  context "when there are upcoming presentations" do
    it "renders the upcoming presentations" do
      presentation = build(:presentation, :future)
      presenter = HomePresenter.new([], [], [presentation], [])
      assign(:presenter, presenter)
      render
      expect(rendered).to have_content "Upcoming"
      expect(rendered).to have_content presentation.title
    end
  end

  context "when there are no upcoming presentations" do
    it "doesn't render the upcoming title" do
      presenter = HomePresenter.new([], [], [], [])
      assign(:presenter, presenter)
      render
      expect(rendered).not_to have_content "Upcoming"
    end

    it "renders the 'no upcoming presentations' text" do
      presenter = HomePresenter.new([], [], [], [])
      assign(:presenter, presenter)
      render
      expect(rendered).to have_content "I have no upcoming speaking engagements."
    end
  end

  context "when there are past presentations" do
    it "renders the past presentations" do
      presentation = build(:presentation, :past)
      presenter = HomePresenter.new([], [], [], [presentation])
      assign(:presenter, presenter)
      render
      expect(rendered).to have_content "Past"
      expect(rendered).to have_content presentation.title
    end
  end

  context "when there are no past presentations" do
    it "doesn't render the past title" do
      presenter = HomePresenter.new([], [], [], [])
      assign(:presenter, presenter)
      render
      expect(rendered).not_to have_content "Past"
    end
  end
end
