var PropertiesCollection = Backbone.Collection.extend({
	model: PropertiesModel,
	url: '/properties',
	parse: function (response) {
		return response;
	}
});
