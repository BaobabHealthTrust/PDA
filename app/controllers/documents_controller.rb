class DocumentsController < ApplicationController
  #before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
	  if request.post?
        search_term = build_term(params) 
        score = CONFIG[:score]	
        potential_duplicates = ThinkingSphinx::Search::BatchInquirer.new
        potential_duplicates.append_query('SELECT * FROM `document_core` WHERE MATCH(\'"' + "#{search_term}" + '"/' + "#{score}" +'\')')
        potential_duplicates = potential_duplicates.results
        @documents = []
        potential_duplicates.first.to_a.each{|i| @documents << Document.find(i['sphinx_internal_id'])}
        return @documents.to_json
   else
      
    if params[:term].blank?
			@documents = Document.searchk(params[:term], params[:page])
		else
			potential_duplicates = ThinkingSphinx::Search::BatchInquirer.new
			potential_duplicates.append_query('SELECT * FROM `document_core` WHERE MATCH(\'"' + "#{params[:term]}" + '"/' + "#{params[:score]}" +'\')')
			potential_duplicates = potential_duplicates.results
			@documents = []
			potential_duplicates.first.to_a.each{|i| @documents << Document.find(i['sphinx_internal_id'])}
		end
       
   end  
		
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)
    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:id, :group_id, :date_added, :group_id2, :title, :content, :couchdb_id)
    end

    def build_term(params)
      term = ""
      terms = params[:_json].first
      terms.each do |key,value|
        term += value + " "
      end

      return term.squish 
    end
end
