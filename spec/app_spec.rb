require 'spec_helper'

describe 'GET /' do
	subject {last_response.status}

  before do
    get '/'
  end

  context 'responds successfully' do
    it {is_expected.to eq(200)}
  end
end

describe "POST /deposit" do  
  let(:body) { { 'money': money, 'rate': rate,'date': date,
              'term': term,'period': period,'capitalization': capitalization}.to_json }
	

  context 'when call with valid parameters' do
    subject{last_response.body}

    before do
      post '/deposit', body, {'CONTENT_TYPE' => 'application/json'}
    end
    context 'when call with term(Month) and capitalization(None)' do
      let(:money){'200'}
      let(:rate){'12'}
      let(:date){'2019-08-01'}
      let(:term){'Month'}
      let(:period){'12'}
      let(:capitalization){'None'}
      
      it 'then gets right json' do
        is_expected.to eq({ :result => 206.02 }.to_json)
      end
    end

    context 'when call with term(Month) and capitalization(Monthly)' do
      let(:money){'200'}
      let(:rate){'12'}
      let(:date){'2019-08-01'}
      let(:term){'Month'}
      let(:period){'12'}
      let(:capitalization){'Monthly'}
      
      it 'then gets right json' do
        is_expected.to eq({ :result => 225.0 }.to_json)
      end
    end

    context 'when call with term(Month) and capitalization(Quarterly)' do
      let(:money){'200'}
      let(:rate){'12'}
      let(:date){'2019-08-01'}
      let(:term){'Month'}
      let(:period){'12'}
      let(:capitalization){'Quarterly'}
      
      it 'then gets right json' do
        is_expected.to eq({ :result => 224.62 }.to_json)
      end
    end

    context 'when call with term(Month) and capitalization(Annually)' do
      let(:money){'200'}
      let(:rate){'12'}
      let(:date){'2019-08-01'}
      let(:term){'Month'}
      let(:period){'12'}
      let(:capitalization){'Annually'}
      
      it 'then gets right json' do
        is_expected.to eq({ :result => 223.67 }.to_json)
      end
    end
    context 'when call with term(Year) and capitalization(None)' do
      let(:money){'200'}
      let(:rate){'12'}
      let(:date){'2019-08-01'}
      let(:term){'Year'}
      let(:period){'12'}
      let(:capitalization){'None'}
      
      it 'then gets right json' do
        is_expected.to eq({ :result => 272.05 }.to_json)
      end
    end

    context 'when call with term(Year) and capitalization(Monthly)' do
      let(:money){'200'}
      let(:rate){'12'}
      let(:date){'2019-08-01'}
      let(:term){'Year'}
      let(:period){'12'}
      let(:capitalization){'Monthly'}
      
      it 'then gets right json' do
        is_expected.to eq({ :result => 821.91 }.to_json)
      end
    end

    context 'when call with term(Year) and capitalization(Quarterly)' do
      let(:money){'200'}
      let(:rate){'12'}
      let(:date){'2019-08-01'}
      let(:term){'Year'}
      let(:period){'12'}
      let(:capitalization){'Quarterly'}
      
      it 'then gets right json' do
        is_expected.to eq({ :result => 805.36 }.to_json)
      end
    end

    context 'when call with term(Year) and capitalization(Annually)' do
      let(:money){'200'}
      let(:rate){'12'}
      let(:date){'2019-08-01'}
      let(:term){'Year'}
      let(:period){'12'}
      let(:capitalization){'Annually'}
      
      it 'then gets right json' do
        is_expected.to eq({ :result => 765.58 }.to_json)
      end
    end
  end
  context 'when call with invalid parameters' do
    subject{last_response.body}

    before do
      post '/deposit', body, {'CONTENT_TYPE' => 'application/json'}
    end

    context 'when call with wrong amount of money' do
      let(:money){'-200'}
      let(:rate){'12'}
      let(:date){'2019-08-01'}
      let(:term){'Year'}
      let(:period){'12'}
      let(:capitalization){'Annually'}

      it 'then gets json with error message' do
        is_expected.to eq({ :result => "Wrong parameters" }.to_json)
      end
    end

    context 'when call with wrong rate' do
      let(:money){'200'}
      let(:rate){'122'}
      let(:date){'2019-08-01'}
      let(:term){'Year'}
      let(:period){'12'}
      let(:capitalization){'Annually'}

      it 'then gets json with error message' do
        is_expected.to eq({ :result => "Wrong parameters" }.to_json)
      end
    end

    context 'when call with wrong date' do
      let(:money){'200'}
      let(:rate){'12'}
      let(:date){'2019-13-01'}
      let(:term){'Year'}
      let(:period){'12'}
      let(:capitalization){'Annually'}

      it 'then gets json with error message' do
        is_expected.to eq({ :result => "Wrong parameters" }.to_json)
      end
    end

    context 'when call with wrong term' do
      let(:money){'200'}
      let(:rate){'12'}
      let(:date){'2019-08-01'}
      let(:term){'sdfsd'}
      let(:period){'12'}
      let(:capitalization){'Annually'}

      it 'then gets json with error message' do
        is_expected.to eq({ :result => "Wrong parameters" }.to_json)
      end
    end

    context 'when call with wrong period' do
      let(:money){'200'}
      let(:rate){'12'}
      let(:date){'2019-08-01'}
      let(:term){'Year'}
      let(:period){'-12'}
      let(:capitalization){'Annually'}

      it 'then gets json with error message' do
        is_expected.to eq({ :result => "Wrong parameters" }.to_json)
      end
    end

    context 'when call with wrong capitalization' do
      let(:money){'200'}
      let(:rate){'12'}
      let(:date){'2019-08-01'}
      let(:term){'Year'}
      let(:period){'12'}
      let(:capitalization){'jksdfnjd'}

      it 'then gets json with error message' do
        is_expected.to eq({ :result => "Wrong parameters" }.to_json)
      end
    end
  end
end
