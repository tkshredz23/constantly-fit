import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
           this.route('about');
           this.route('users', { path: "/leaderboard" });
           this.resource('user', { path: '/users/:id' });
});

Router.reopen({
                  //location: 'auto'
                  });

export default Router;
