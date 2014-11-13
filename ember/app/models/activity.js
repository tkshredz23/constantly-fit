import DS from "ember-data";

var Activity = DS.Model.extend({
  distance: DS.attr('number'),
  duration: DS.attr('string'),
  steps: DS.attr('number'),
  points: DS.attr('number'),
  calories: DS.attr('number'),
  count: DS.attr('number'),
  user: DS.belongsTo('user')
});

export default Activity;
