import Ember from "ember";

var UserRoute = Ember.Route.extend({
  model: function(params) {
    return this.store.find('user', params.id);
  }
});

export default UserRoute;
