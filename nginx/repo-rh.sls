# A lookup table for NGINX GPG keys & RPM URLs for various RedHat releases
{% if grains['os'] == 'CentOS' %}
  {% if grains['osmajorrelease'][0] == '5' %}
    {% set pkg = {
      'rpm': 'http://nginx.org/packages/centos/5/noarch/RPMS/nginx-release-centos-5-0.el5.ngx.noarch.rpm',
      'name': 'nginx-release-centos',
    } %}
  {% elif grains['osmajorrelease'][0] == '6' %}
    {% set pkg = {
      'rpm': 'http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm',
      'name': 'nginx-release-centos',
    } %}
  {% elif grains['osmajorrelease'][0] == '7' %}
    {% set pkg = {
      'rpm': 'http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm',
      'name': 'nginx-release-centos',
    } %}
  {% endif %}
{% elif grains['os_family'] == 'RedHat' %}
  {% if grains['osmajorrelease'][0] == '5' %}
    {% set pkg = {
      'rpm': 'http://nginx.org/packages/rhel/5/noarch/RPMS/nginx-release-rhel-5-0.el5.ngx.noarch.rpm',
      'name': 'nginx-release-redhat',
    } %}
  {% elif grains['osmajorrelease'][0] == '6' %}
    {% set pkg = {
      'rpm': 'http://nginx.org/packages/rhel/6/noarch/RPMS/nginx-release-rhel-6-0.el6.ngx.noarch.rpm',
      'name': 'nginx-release-redhat',
    } %}
  {% elif grains['osmajorrelease'][0] == '7' %}
    {% set pkg = {
      'rpm': 'http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm',
      'name': 'nginx-release-redhat',
    } %}
  {% endif %}
{% endif %}

# Completely ignore non-RHEL based systems
{% if grains['os_family'] == 'RedHat' %}
install_repo_rpm:
  pkg:
    - installed
    - sources:
      - {{ salt['pillar.get']('nginx:name', pkg.name) }}: {{ salt['pillar.get']('nginx:rpm', pkg.rpm) }}
{% endif %}
