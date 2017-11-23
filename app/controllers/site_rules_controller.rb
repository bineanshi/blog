class SiteRulesController < ApplicationController
  before_action :set_site_rule, only: [:show, :edit, :update, :destroy]

  # GET /site_rules
  # GET /site_rules.json
  def index
    @query = SiteRule.ransack(params[:q])
    @site_rules = @query.result.page(params[:page]).per(10)
  end

  # GET /site_rules/1
  # GET /site_rules/1.json
  def show
  end

  # GET /site_rules/new
  def new
    @site_rule = SiteRule.new
  end

  # GET /site_rules/1/edit
  def edit
  end

  # POST /site_rules
  # POST /site_rules.json
  def create
    @site_rule = SiteRule.new(site_rule_params)
    respond_to do |format|
      params[:images].map{|key,value| params[:images].delete(key) if value.blank?}
      params[:links].map{|key,value| params[:links].delete(key) if value.blank?}
      params[:rule_value].map{|key_root,value_root| value_root.map{|key,value| value_root.delete(key) if value.blank?}; params[:rule_value].delete(key_root) if value_root.blank?}
      @site_rule.rule_value = params[:rule_value]
      @site_rule.links = params[:links]
      @site_rule.images = params[:images]
      if @site_rule.save
        format.html { redirect_to @site_rule, notice: 'Site rule was successfully created.' }
        format.json { render :show, status: :created, location: @site_rule }
      else
        format.html { render :new }
        format.json { render json: @site_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /site_rules/1
  # PATCH/PUT /site_rules/1.json
  def update
    respond_to do |format|
      params[:images].map{|key,value| params[:images].delete(key) if value.blank?}
      params[:links].map{|key,value| params[:links].delete(key) if value.blank?}
      params[:rule_value].map{|key_root,value_root| value_root.map{|key,value| value_root.delete(key) if value.blank?}; params[:rule_value].delete(key_root) if value_root.blank?}
      @site_rule.rule_value = params[:rule_value]
      @site_rule.links = params[:links]
      @site_rule.images = params[:images]
      if @site_rule.update(site_rule_params)
        format.html { redirect_to @site_rule, notice: 'Site rule was successfully updated.' }
        format.json { render :show, status: :ok, location: @site_rule }
      else
        format.html { render :edit }
        format.json { render json: @site_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_rules/1
  # DELETE /site_rules/1.json
  def destroy
    @site_rule.destroy
    respond_to do |format|
      format.html { redirect_to site_rules_url, notice: 'Site rule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def test_rule
    @site = Site.find_by(id: params[:site_id])
    params[:hash].values[0].map{|key,value| params[:hash].values[0].delete(key) if value.blank?}
    result = Snatch.send("get_#{params[:hash].values[0].keys.join('_')}#{ '_content' if params[:hash].keys[0].to_s == 'content'}",nil,params[:hash].values[0],params[:key],@site)
    render :html => result.to_s.html_safe
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site_rule
      @site_rule = SiteRule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_rule_params
      params.require(:site_rule).permit(:site_id, :site_name, :rule_name)
    end
end
