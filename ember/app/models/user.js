import DS from "ember-data";

var User = DS.Model.extend({
  user_id: DS.attr(),
  email: DS.attr('string'),
  avatar: DS.attr('string'),
  first_name: DS.attr('string'),
  last_name: DS.attr('string'),
  workouts: DS.hasMany('workout', {async: true}),
  points: DS.hasMany('point', {async: true}),
  activity: DS.belongsTo('activity'),
  created_at: DS.attr()
});

export default User;
