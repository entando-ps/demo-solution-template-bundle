#demo-template-bundle installation process

----- READ CAREFULLY ----

1) BEFORE installing demo-template-bundle:

 - project-namespace-server-deployment yaml must be edited adding:

 - name: JACMS_IMAGERESOURCE_ALLOWEDEXTENSIONS <br>
   value: 'jpg,jpeg,png,svg,svg+xml,gif'

If you want to enable the Admin Console add this env var:
  - name: APPBUILDER_INTEGRATION_ENABLED <br>
  -  value: false
  
2) After installing demo-template-bundle:

- Be sure to have access to server-namePort DB
- Modify scripts accordingly to DB type and settings
- Execute inserts on update.sql files directly to server-namePort DB
- Reload configuration from AppBuilder
# Demo-solution-template-bundle
# Demo-solution-template-bundle
