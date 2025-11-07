monitoring.worker:
  file.serialize:
    - name: /etc/prometheus/targets/worker.json
    - serializer: json
    - dataset:
        - targets:
            - worker:9100
          labels:
            job: worker
    - mode: "0640"
    - user: root
    - group: root
