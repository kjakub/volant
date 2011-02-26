require 'test_helper'


# TODO - move import tests to different file
class WorkcampTest < ActiveSupport::TestCase
  context "Workcamp" do
    setup do
      @wc = Factory.create(:workcamp, :begin => 1.day.from_now, :end => 10.days.from_now)
    end

    should "workcamp term" do
      @wc.begin = @wc.end = nil
      assert_equal '? - ?', @wc.term
      @wc.begin = Date.new(2002, 3, 27)
      @wc.end = Date.new(2002, 3, 28)
      assert_equal '27.03.2002 - 28.03.2002', @wc.term
    end

    should "validation based on schema rules" do
      wc = workcamps(:kytlice)
      assert_validates_presence_of wc, :name, :code, :places, :country
    end

    should "workcamps with intentions deletion" do
      wc = workcamps(:xaverov)
      agri = workcamp_intentions(:agri)
      assert wc.intentions.include?(agri)

      assert_nothing_raised do
        wc.destroy
        WorkcampIntention.find(agri.id)
      end
    end

    should "workcamp intention addition" do
      Workcamp.find(:all).each do |wc|

        wc.intentions << WorkcampIntention.find(:first)
        assert_nothing_raised {  wc.save! }
      end
    end

    should "conversion to XML" do
      assert_not_nil Workcamp.first.to_xml
    end

    should "csv export" do
      assert_not_nil Workcamp.first.to_csv
    end    
  end
end