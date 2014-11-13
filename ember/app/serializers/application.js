import DS from "ember-data";

var ApplicationSerializer = DS.RESTSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs: {
    workouts: { embedded: 'always' },
    points: { embedded: 'always' },
    activity: { embedded: 'always' },
    user: { embedded: 'always' }
  }
});

export default ApplicationSerializer;
