.headers on
.mode column
SELECT(SELECT count (*) FROM media_parts INNER JOIN media_items ON media_parts.media_item_id = media_items.id INNER JOIN metadata_items ON media_items.metadata_item_id=metadata_items.id WHERE metadata_items.metadata_type IN (1,4) AND media_parts.file NOT LIKE '' AND (media_parts.extra_data like '%&mi:indexes=sd%' OR media_parts.extra_data like '%&mi%3Aindexes=sd%')) AS 'Completed Indexes',
(SELECT count (*) FROM media_parts INNER JOIN media_items ON media_parts.media_item_id = media_items.id INNER JOIN metadata_items ON media_items.metadata_item_id=metadata_items.id WHERE metadata_items.metadata_type IN (1,4) AND media_parts.file NOT LIKE '' AND media_parts.extra_data NOT LIKE '%&mi:indexes=sd%' AND media_parts.extra_data NOT LIKE '%&mi%3Aindexes=sd%' ) AS 'Remaining Indexes',
(SELECT count (*) FROM media_parts INNER JOIN media_items ON media_parts.media_item_id = media_items.id INNER JOIN metadata_items ON media_items.metadata_item_id=metadata_items.id WHERE metadata_items.metadata_type IN (1,4) AND media_parts.file NOT LIKE '') AS 'Total Items';