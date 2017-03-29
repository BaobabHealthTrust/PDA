class Document < ApplicationRecord

after_create :new_index

def self.searchk(term, current_page)

  if term
    page(current_page).where('content LIKE ?', "%#{term}%").order('id DESC')
  else
    page(current_page).order('id DESC') 
  end
end

def self.searchk(term, page)

  if term
    where('content LIKE ?', "%#{term}%").paginate(page: page, per_page: 1000).order('id DESC')
  else
    paginate(page: page, per_page: 1000).order('id DESC') 
  end
end

def new_index
    %x[rake ts:index]
end  

end
