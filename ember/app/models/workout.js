import DS from "ember-data";

var Workout = DS.Model.extend({
  //user: DS.belongsTo('user'),
  type: DS.attr('string'),
  activity: DS.belongsTo('activity')
});

export default Workout;
