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
    //var workouts = this.store.findAll('workout');
    var workouts = this.store.findQuery('workout', params);

    return workouts;
  },
  actions: {
    error: function(reason, transition){
      console.log('ERROR Handling code');
      console.log("reason:" + reason);
      console.log("transition:" + transition);
    }
  }
});

export default WorkoutsRoute;
