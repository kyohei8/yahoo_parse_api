# encoding: utf-8
require 'spec_helper'

describe 'YahooParseApi Spec' do

  describe 'correctly case' do
    before(:all) do
      tokens = YAML.load_file(File.join(File.dirname(__FILE__), './application.yml'))["test"]
      YahooParseApi::Config.app_id = ENV['APPID'] ? ENV['APPID'] : tokens['app_id']
      @yp = YahooParseApi::Parse.new
    end

    it 'should get instance' do
      expect(@yp).not_to be_nil
    end

    it 'should correctly parse. (case GET)' do
      res = @yp.parse('庭には二羽ニワトリがいる。', {
        results: 'ma,uniq',
        response: 'surface,reading,pos,baseform,feature',
        filter: '9|1'
      })
      expect(res).not_to be_nil
      # travisで拾えるかな？
      mr = res['ResultSet']['ma_result']
      expect(mr['total_count']).to eq('8')
      expect(mr['filtered_count']).to eq('3')
      ma_word_0 = mr['word_list']['word'][0]
      expect(ma_word_0['surface']).to eq('庭')
      expect(ma_word_0['reading']).to eq('にわ')
      expect(ma_word_0['pos']).to eq('名詞')
      expect(ma_word_0['baseform']).to eq('庭')
      expect(ma_word_0['feature']).to eq('名詞,名詞,*,庭,にわ,庭')

      ur = res['ResultSet']['uniq_result']
      expect(ur['total_count']).to eq('8')
      expect(ur['filtered_count']).to eq('3')
      uniq_word_0 = ur['word_list']['word'][0]
      expect(uniq_word_0['count']).to eq('1')
      expect(uniq_word_0['surface']).to eq('ニワトリ')
      expect(uniq_word_0['reading']).to be_nil
      expect(uniq_word_0['pos']).to eq('名詞')
      expect(uniq_word_0['baseform']).to eq('ニワトリ')
      expect(uniq_word_0['feature']).to eq('名詞,*,*,ニワトリ,,ニワトリ')
    end

    it 'should correctly parse. (case POST)' do
      res = @yp.parse('庭には二羽ニワトリがいる。', {
        results: 'ma,uniq',
        response: 'surface,reading,pos,baseform,feature',
        filter: 9
      }, :POST)

      expect(res).not_to be_nil
      # travisで拾えるかな？
      mr = res['ResultSet']['ma_result']
      expect(mr['total_count']).to eq('8')
      expect(mr['filtered_count']).to eq('3')
      ma_word_0 = mr['word_list']['word'][0]
      expect(ma_word_0['surface']).to eq('庭')
      expect(ma_word_0['reading']).to eq('にわ')
      expect(ma_word_0['pos']).to eq('名詞')
      expect(ma_word_0['baseform']).to eq('庭')
      expect(ma_word_0['feature']).to eq('名詞,名詞,*,庭,にわ,庭')

      ur = res['ResultSet']['uniq_result']
      expect(ur['total_count']).to eq('8')
      expect(ur['filtered_count']).to eq('3')
      uniq_word_0 = ur['word_list']['word'][0]
      expect(uniq_word_0['count']).to eq('1')
      expect(uniq_word_0['surface']).to eq('ニワトリ')
      expect(uniq_word_0['reading']).to be_nil
      expect(uniq_word_0['pos']).to eq('名詞')
      expect(uniq_word_0['baseform']).to eq('ニワトリ')
      expect(uniq_word_0['feature']).to eq('名詞,*,*,ニワトリ,,ニワトリ')

    end

    it 'should correctly parse. pattern:results=ma' do
      res = @yp.parse('庭には二羽ニワトリがいる。', {
        results: 'ma'
      })
      expect(res).not_to be_nil
      expect(res['ResultSet']['ma_result']).not_to be_nil
      expect(res['ResultSet']['uniq_result']).to be_nil
    end

    it 'should correctly parse. pattern:results=uniq' do
      res = @yp.parse('庭には二羽ニワトリがいる。', {
        results: 'uniq'
      })
      expect(res).not_to be_nil
      expect(res['ResultSet']['ma_result']).to be_nil
      expect(res['ResultSet']['uniq_result']).not_to be_nil
    end

    it 'should correctly parse. with uniq_by_baseform' do
      res = @yp.parse('庭には二羽ニワトリがいる。', {
        results: 'uniq',
        uniq_by_baseform: 'true'
      })
      expect(res).not_to be_nil
      expect(res['ResultSet']['ma_result']).to be_nil
      expect(res['ResultSet']['uniq_result']).not_to be_nil
    end


    # NG cases

    it 'appid is nil' do
      YahooParseApi::Config.app_id = nil
      expect {
        YahooParseApi::Parse.new
      }.to raise_error(YahooParseApi::YahooParseApiError, 'please set app key before use')
    end

    it 'invalid arguments' do
      expect {
        @yp.parse('庭には二羽ニワトリがいる。', {}, :NG)
      }.to raise_error(YahooParseApi::YahooParseApiError, 'invalid request method')
    end

    it 'Error:413, Request Entity Too Large' do
      large_file = File.dirname(__FILE__) + '/LargeData.txt'
      c = File.read(large_file, encding: Encoding::UTF_8)
      expect {
        @yp.parse(c, {}, :POST)
      }.to raise_error(YahooParseApi::YahooParseApiError, 'Request Entity Too Large')
    end
  end

end
