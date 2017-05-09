    /*var DashboardView = Backbone.View.extend({
      // el - stands for element. Every view has a element associate in with HTML
      //      content will be rendered.
      el: '#wrapper',
      
      // It's the first function called when this view it's instantiated.
      initialize: function(){
        this.render();
      },
      // $el - it's a cached jQuery object (el), in which you can use jQuery functions
      //       to push content. Like the Hello World in this case.
      render: function(){
        this.$el.html(JST["templates/dashboard"]({model : this.model}));
        var navbar = new NavbarView();
        this.$('navbarContainer').append(this.navbar.render().el);
        //$('user_dashboard').$('navbarContainer').html(JST["templates/navbar"]({model : this.model}));
      }
    });*/
    
var UserControlsView = Backbone.View.extend({
    dashboard:null,
    el: '#wrapper',
    
    initialize: function(options) {
        //var controls = this,
          //  model = this.model;
            //this.dashboard = options.dashboard;
        this.render();
    },
    render: function() {
        //var settings = this.model.toJSON(),
	this.$el.html(JST["templates/dashboard"]({model : this.model}));	
        this.$el.find('.users_dashboard').find('.navbarContainer').html(JST['templates/navbar']({model : this.model}))
        //el.find('.dashboardContainer').html(JST['backbone/templates/users/deploy_contents']({settings:settings}))
        this.$el.find('.dashboardContainer').html(JST['templates/dashboard_contents']({model : this.model}))
        //el.find('.consoleLogContainer').html(JST['backbone/templates/users/console_log']({settings:settings}))
    },
    events: {
        "click .navbarContainer a" : "selectMenuItem",
        "click .btn-primary" : "propertyNew",
        "click .submit-btn" : "propertyCreate",
        "click .cancel-btn" : "propertyCancel",
        "click .btn-danger" : "propertyDelete",
        "click .btn-success" : "export"
    },
    selectMenuItem:function(event) {
			
        var menuName = $(event.target).attr('id');
        el = this.$el;
       switch (menuName) {
          case 'deployment':
               el.find('#page-wrapper').remove();
               el.find('.dashboardContainer').html(JST['templates/deploy_contents']({model: this.model}))
               break;
          case 'dashboard':
               el.find('#page-wrapper').remove();
               el.find('.dashboardContainer').html(JST['templates/dashboard_contents']({model: this.model}))
               break;
          case 'properties':
			   el.find('#page-wrapper').remove();
			   el.find('.dashboardContainer').html(JST['templates/properties_contents']({model: this.model}))
			   var properties = new PropertiesCollection();
			   properties.fetch({
				   success: function(PropertiesCollection) {
					   console.log(JSON.stringify(properties));
					   console.log(properties.toJSON())
					   //var template = _.template($('#properties-template').html(), {PropertiesCollection: PropertiesCollection.models});
					   //el.find('.dashboardContainer').find('.table-responsive').html(template);
					   var html =  _.template(
						"<table class='table' id='myTable'><thead><tr><th>#</th><th>Varable</th><th>Value</th></tr></thead><tbody><% _.each(properties, function(item) { %><tr><td><%= item.get('id') %></td><td><%= item.get('varable') %></td><td><%= item.get('value') %></td></tr><% }); %></tbody></table>"
						);
						el.find('.dashboardContainer').find('.table-responsive').html(html(properties));
				   }
			   });
			   break;
		   }
    },
    propertyNew:function(event) {
		console.log("new");
		el.find('.dashboardContainer').find('.col-lg-5').remove();
		el.find('.dashboardContainer').find('.btn-primary').remove();
		el.find('.dashboardContainer').find('.btn-success').remove();
		el.find('.dashboardContainer').find('#table').html(JST['templates/new_property']({model: this.model}))
	},
	propertyCreate:function(event) {
		console.log("create");
		var x = document.getElementById('var').value;
		var y = document.getElementById('val').value;
		console.log(x);
		console.log(y);
		var newProperty = new PropertiesModel({ varable: x, value: y });
		newProperty.save();
		el.find('#page-wrapper').remove();
		el.find('.dashboardContainer').html(JST['templates/properties_contents']({model: this.model}))
	},
	propertyCancel:function(event) {
		el.find('#page-wrapper').remove();
		el.find('.dashboardContainer').html(JST['templates/properties_contents']({model: this.model}))
	},
	propertyDelete:function(event) {
		console.log("delete")
		//console.log(document.getElementById("myTable").rows[1].cells[0].innerHTML);
		//var model = new PropertiesModel({ id: 8 });
		//model.destroy();
	},
	export:function(event) {
		console.log('export')
		"use strict";
		var YAML = require('json2yaml')
			, json
			, data
			, yml
			;
		 
		  json = '{ "foo": "bar" }';
		  data = JSON.parse(json);
		  yml = YAML.stringify(data);
		 
		  console.log(yml);
		}
})
var usercontrol =new UserControlsView();

/*var Router = Backbone.Router.extend({
	routes: {
	'': 'home'
	}
});
var router = new Router();
router.on('route:home' , function(){
	usercontrol.render();
});
Backbone.history.start();*/
