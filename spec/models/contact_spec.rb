require 'rails_helper'

describe Contact do
  describe 'filter last name by letter' do
    before do
      @smith = create(
        :contact,
        lastname: 'Smith'
      )
      @jones = create(
        :contact,
        lastname: 'Jones'
      )
      @johnson = create(
        :contact,
        lastname: 'Johnson'
      )
    end

    context 'with matching letters' do
      it 'returns a sorted array of results that match' do
        expect(Contact.by_letter('J')).to eq [@johnson, @jones]
      end
    end

    context 'with non-matching letter' do
      it 'omits results that do not match' do
        expect(Contact.by_letter('J')).not_to include @smith
      end
    end
  end
  it 'is valid with a firstname, lastname and email' do
    contact = build(:contact)
    expect(contact).to be_valid
  end

  it 'is invalid without a firstname' do
    contact = build(:contact, firstname: nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end

  it 'is invalid without a lastname' do
    contact = build(:contact, lastname: nil)
    contact.valid?
    expect(contact.errors[:lastname]).to include("can't be blank")
  end

  it 'is invalid without an email address' do
    contact = build(:contact, email:nil)
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end

  it 'is invalid with a duplicate email address' do
    email = 'aaron@example.com'
    create(:contact, email: email)
    contact = build(:contact, email: email)
    contact.valid?
    expect(contact.errors[:email]).to include('has already been taken')
  end

  it "returns a contact's full name as a string" do
    contact = build(
      :contact,
      firstname: 'Jane',
      lastname: 'Smith'
    )
    expect(contact.name).to eq 'Jane Smith'
  end

  it 'has a valid factory' do
    expect(build(:contact)).to be_valid
  end

  it 'has three phone numbers' do
    expect(create(:contact).phones.count).to eq 3
  end
end
