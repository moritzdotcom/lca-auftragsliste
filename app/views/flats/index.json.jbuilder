json.array! @flats do |flat|
  json.id flat.id
  json.location flat.location
  if flat.current_tenant
    json.tenant_id flat.current_tenant.id
    json.tenant_name flat.current_tenant.name
  end
end
