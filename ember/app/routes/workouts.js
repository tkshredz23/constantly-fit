import Ember from "ember";

var WorkoutsRoute = Ember.Route.extend({
  queryParams: {
    type: {
      refreshModel: true
    },
    order: {
      refreshModel: true
    },
    provider: {
      refreshModel: true
    }
  },
  model: function(params) {
    console.log(params);
    var workouts = this.store.findQuery('workout', params);

    return workouts;
  }
});

export default WorkoutsRoute;
