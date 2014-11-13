import Ember from "ember";

var UsersRoute = Ember.Route.extend({
  model: function() {
    var users = this.store.findAll('user');

    return users;
  }
});

export default UsersRoute;
