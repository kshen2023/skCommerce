Ransack.configure do |config|
  config.add_predicate 'with_tags',
    arel_predicate: 'in',
    formatter: proc { |v| v.map(&:to_i) },
    validator: proc { |v| v.present? },
    type: :integer
end
