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
    
      $.ajax({
      url: "/championships/"+this.model.get("id")+"/games/"+this.model.gameId()+"/rounds/"+this.model.roundId()+"/play",
      type: "PUT",
      data: {value: $("#value").val()},
      success: function(data){
        alert("Round played.")
      },
      error: function(data){
        res = $.parseJSON(data["responseText"]);
        var errors = ""
        _.each(res["errors"], function (error, field) {         
          errors = errors + " " + _.str.humanize(field+ " "+error) 
        });   
        alert(errors);
      },
      dataType: "json"    
    });
    
  },

});