module HomeHelper
  def resource_tag_class(tag)
    case tag
    when 'script'
      'bg-primary'
    when 'audio'
      'bg-secondary'
    when 'translation'
      'bg-success'
    when 'tafsir'
      'bg-info'
    when 'mutashabihat'
      'bg-warning'
    when 'similar-ayah'
      'bg-info'
    when 'surah-info'
      'bg-light'
    when 'mushaf-layout'
      'bg-dark'
    when 'ayah-theme'
      'bg-primary'
    when 'ayah-topics'
      'bg-primary'
    when 'transliteration'
      'bg-success'
    when 'morphology'
      'bg-success'
    when 'With Footnotes'
      'bg-info'
    else
      'bg-success'
    end
  end
  def inline_stylesheet_source(name)
    asset_name = "#{name}.css"

    if Rails.env.development? || Rails.env.test?
      Rails.application.assets[asset_name].to_s
    else
      asset_path = ActionController::Base.helpers.asset_path(asset_name)
      File.read("#{Rails.root}/public#{asset_path}")
    end
  end

  def whodunnit(version)
    GlobalID::Locator.locate(version.whodunnit).name
  rescue Exception => e

  end

  def content_tag_if(add_tag, tag_name, content)
    if add_tag
      content_tag tag_name, content
    else
      content
    end
  end

  def diff_text(text1, text2)
    Diffy::SplitDiff.new(text1, text2, format: :html).right.html_safe
  end
end
