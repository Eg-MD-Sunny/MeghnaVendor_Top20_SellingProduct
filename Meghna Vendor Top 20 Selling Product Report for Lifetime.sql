select top 20 pv.Id [PVID],
		pv.Name [Product],
		Count(tr.salePrice) [SaleQty],
		Sum(tr.salePrice) [Amount]


from ThingRequest tr
join Shipment s on s.Id = tr.ShipmentId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 


where s.ReconciledOn is not null
and s.ShipmentStatus not in (1,9,10)
and IsReturned=0
and IsCancelled=0
and HasFailedBeforeDispatch=0
and IsMissingAfterDispatch=0
and pv.DistributionNetworkId = 1

and pv.id in (
	select  pv.Id [PVID]
	from ProductVariant pv 
	join ProductVariantVendorMapping pvcm on pv.Id = pvcm.ProductVariantId 
	join vendor v on v.Id = pvcm.VendorId 
	where v.Id = 10

)

Group by pv.Id,
		 pv.Name 

Order By 3 desc