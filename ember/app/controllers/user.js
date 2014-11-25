import Ember from "ember";

var UserController = Ember.ObjectController.extend({
  name: function(){
    return this.get('first_name') + ' ' + this.get('last_name');
  }.property(),
});

export default UserController;
