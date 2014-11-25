import Ember from "ember";

var PointController = Ember.ObjectController.extend({
  yada: function(){
    alert('you here');
    return 'nothing';
  }.property()
});

export default PointController;
