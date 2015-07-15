PingPong.Views.Championship = Backbone.View.extend({
  
  template: '#championship-template',

  initialize: function(){
    _.bindAll(this, 'render');
  },

  render: function(){    
    $(this.el).html(Mustache.to_html($(this.template).html(), this.model.toJSON()));
    return this;
  },

  events: {
    "click #play-button" : "play"
  },

  play: function(e){
    
  }

});