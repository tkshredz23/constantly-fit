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
    console.log(this.store);
    //var workouts = this.store.findAll('workout');
    var workouts = this.store.findQuery('workout', params);

    return workouts;
  }
});

export default WorkoutsRoute;
