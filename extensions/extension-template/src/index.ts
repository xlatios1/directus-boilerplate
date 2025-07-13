import { defineHook } from '@directus/extensions-sdk'

export default defineHook(({ filter }) => {
	filter('items.create', async (payload: any, meta, context) => {
		return payload
	})
})
