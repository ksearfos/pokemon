require 'yaml/store'

module Persistence
  FILE = "#{File.dirname(__FILE__)}/pokemon.yml"

  def self.yaml_store
    @yaml_store ||= YAML::Store.new(FILE)
  end

  def self.save(family)
    yaml_store.transaction do |store|
      store[family.name] = family.to_h
    end
  end

  def self.load(family_name)
    data = yaml_store.transaction do |store|
      store[family_name.downcase]
    end

    Family.build(data) if data
  end

  def self.load_all
    families.map { |family| Family.build(family) }
  end

  def self.families
    yaml_store.transaction do |store|
      store.roots.map { |root| store[root] }
    end
  end
end
