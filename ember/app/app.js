import Ember from 'ember';
import DS from 'ember-data';
import Resolver from 'ember/resolver';
import loadInitializers from 'ember/load-initializers';
import config from './config/environment';

Ember.MODEL_FACTORY_INJECTIONS = true;

var App = Ember.Application.extend({
  modulePrefix: config.modulePrefix,
  podModulePrefix: config.podModulePrefix,
  Resolver: Resolver
});

App.ApplicationAdapter = DS.FixtureAdapter;

App.ApplicationAdapter = DS.RESTAdapter.extend({
                                                    host: 'http://localhost:3000',
                                                    namespace: 'api/v1'
                                                    });

App.ApplicationController = Ember.Controller.extend({});
App.ApplicationRoute = Ember.Route.extend({});
App.UsersRoute = Ember.Route.extend({
                                         model: function() {
                                         return this.store.findAll('user');
                                         }
                                         });

App.UserRoute = Ember.Route.extend({
                                        model: function(params) {
                                        return this.store.find('user', params.user_id);
                                        }
                                        });

App.UsersController = Ember.ArrayController.extend({});

App.UserSerializer = DS.ActiveModelSerializer.extend(DS.EmbeddedRecordsMixin, {
                                                          attrs: {
                                                          activities: { embedded: 'always' }
                                                          }
                                                          });

// Models
App.User = DS.Model.extend({
                                email: DS.attr('string'),
                                avatar: DS.attr('string'),
                                firstName: DS.attr('string'),
                                lastName: DS.attr('string'),
                                activities: DS.hasMany('activity')
                                });

App.Activity = DS.Model.extend({
                                    account: DS.attr(),
                                    distance: DS.attr('number'),
                                    duration: DS.attr('number'),
                                    steps: DS.attr('number'),
                                    points: DS.attr('number'),
                                    calories: DS.attr('number')    
                                    });

loadInitializers(App, config.modulePrefix);

export default App;
