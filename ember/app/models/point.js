import DS from "ember-data";

var Point = DS.Model.extend({
  user: DS.belongsTo('user'),
  provider: DS.attr('string'),
  activity: DS.belongsTo('activity')
});

export default Point;
