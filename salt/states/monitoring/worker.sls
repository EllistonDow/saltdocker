monitoring.worker:
  file.managed:
    - name: /etc/prometheus/targets/worker.json
    - contents: |
        [{"targets": ["worker:9100"], "labels": {"job": "worker"}}]
    - mode: 640
    - user: root
    - group: root
