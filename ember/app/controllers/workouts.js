import Ember from "ember";

var WorkoutsController = Ember.ArrayController.extend({
  queryParams: ['type', 'order', 'provider'],
  type: null,
  order: null,
  provider: null,

  filteredWorkouts: function(){
    var type = this.get('type');
    var order = this.get('order');
    var provider = this.get('provider');
    var workouts = this.get('model');

    console.log(workouts);

    if (type) {
      return workouts.filterBy('type', type);
    } else if (provider){
      return workouts.filterBy('provider', provider);
    } else if (order) {
      return workouts.filterBy('order', order);
    } else {
      return workouts;
    }
  }.property('type', 'model')
});

export default WorkoutsController;
