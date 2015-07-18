PingPong.Models.Championship = Backbone.Model.extend({
  
 url: function() {         
    return "/championships/"+this.get("id");
  },

  gameId: function(){
    return _.last(this.get("games")).id
  },

  roundId: function(){
    console.log(_.last(this.get("games")))
    return _.last(_.last(this.get("games")).rounds).id
  },
});