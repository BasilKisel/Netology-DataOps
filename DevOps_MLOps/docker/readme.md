# $ docker image build -t netology-ml:netology-ml .

```
$ docker image build -t netology-ml:netology-ml .
#1 [internal] load build definition from Dockerfile
#1 sha256:44da33d3d21f364dc1e3433bbf66e098328354c3a54b00035ab14f70d0e200f8
#1 transferring dockerfile: 257B done
#1 DONE 0.0s

#2 [internal] load .dockerignore
#2 sha256:7beb67c494bccd00069019a3fa38dc9b1fcb471bea770f0dc288d2a53b91ce37
#2 transferring context: 2B done
#2 DONE 0.0s

#3 [internal] load metadata for docker.io/continuumio/miniconda3:latest
#3 sha256:70c01be2623751a8f6df5d5b392c0445964bc863c94f2ca91c3dab835106ad61
#3 ...

#4 [auth] continuumio/miniconda3:pull token for registry-1.docker.io
#4 sha256:c5aac1458ffca54d4f7e6655daf3ceab57574fe2d55ffc7c90248ac052f82357
#4 DONE 0.0s

#3 [internal] load metadata for docker.io/continuumio/miniconda3:latest
#3 sha256:70c01be2623751a8f6df5d5b392c0445964bc863c94f2ca91c3dab835106ad61
#3 DONE 4.9s

#9 [internal] load build context
#9 sha256:8ec0b4fef10006231b347dfa57cbb1b3c2db0f3c6027152e8360d199c05d13d2
#9 transferring context: 83B done
#9 DONE 0.1s

#5 [1/4] FROM docker.io/continuumio/miniconda3:latest@sha256:977263e8d1e476972fddab1c75fe050dd3cd17626390e874448bd92721fd659b
#5 sha256:ca66aa33db3e896fbfd37993b68cfd5c015c5c048b71ab9b544813abe93b9f28
#5 resolve docker.io/continuumio/miniconda3:latest@sha256:977263e8d1e476972fddab1c75fe050dd3cd17626390e874448bd92721fd659b 0.0s done
#5 sha256:42c077c10790d51b6f75c4eb895cbd4da37558f7215b39cbf64c46b288f89bda 0B / 31.38MB 0.1s
#5 sha256:1a23c9d790a34c5bb13dbaf42e0ea2a555e089aefed7fdfa980654f773b39b39 0B / 50.06MB 0.1s
#5 sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 0B / 60.29MB 0.1s
#5 sha256:977263e8d1e476972fddab1c75fe050dd3cd17626390e874448bd92721fd659b 1.36kB / 1.36kB done
#5 sha256:58b1c7df8d69655ffec017ede784a075e3c2e9feff0fc50ef65300fc75aa45ae 953B / 953B done
#5 sha256:ce7d119281a1f4685ce6ca66b355c88baa44522ac6a54aee86be96d14ab6dfda 4.36kB / 4.36kB done
#5 sha256:42c077c10790d51b6f75c4eb895cbd4da37558f7215b39cbf64c46b288f89bda 2.10MB / 31.38MB 1.6s
#5 sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 3.15MB / 60.29MB 2.3s
#5 sha256:42c077c10790d51b6f75c4eb895cbd4da37558f7215b39cbf64c46b288f89bda 4.19MB / 31.38MB 2.8s
#5 sha256:1a23c9d790a34c5bb13dbaf42e0ea2a555e089aefed7fdfa980654f773b39b39 3.15MB / 50.06MB 3.6s
#5 sha256:42c077c10790d51b6f75c4eb895cbd4da37558f7215b39cbf64c46b288f89bda 6.29MB / 31.38MB 4.1s
#5 sha256:42c077c10790d51b6f75c4eb895cbd4da37558f7215b39cbf64c46b288f89bda 8.39MB / 31.38MB 5.2s
#5 sha256:1a23c9d790a34c5bb13dbaf42e0ea2a555e089aefed7fdfa980654f773b39b39 6.29MB / 50.06MB 5.8s
#5 sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 6.29MB / 60.29MB 6.3s
#5 sha256:42c077c10790d51b6f75c4eb895cbd4da37558f7215b39cbf64c46b288f89bda 10.49MB / 31.38MB 6.5s
#5 sha256:42c077c10790d51b6f75c4eb895cbd4da37558f7215b39cbf64c46b288f89bda 12.58MB / 31.38MB 7.7s
#5 sha256:1a23c9d790a34c5bb13dbaf42e0ea2a555e089aefed7fdfa980654f773b39b39 9.44MB / 50.06MB 7.8s
#5 sha256:42c077c10790d51b6f75c4eb895cbd4da37558f7215b39cbf64c46b288f89bda 14.68MB / 31.38MB 9.1s
#5 sha256:1a23c9d790a34c5bb13dbaf42e0ea2a555e089aefed7fdfa980654f773b39b39 12.58MB / 50.06MB 9.8s
#5 sha256:42c077c10790d51b6f75c4eb895cbd4da37558f7215b39cbf64c46b288f89bda 16.34MB / 31.38MB 10.4s
#5 sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 9.44MB / 60.29MB 10.7s
#5 sha256:1a23c9d790a34c5bb13dbaf42e0ea2a555e089aefed7fdfa980654f773b39b39 15.73MB / 50.06MB 12.0s
#5 sha256:42c077c10790d51b6f75c4eb895cbd4da37558f7215b39cbf64c46b288f89bda 18.87MB / 31.38MB 12.3s
#5 sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 12.58MB / 60.29MB 12.5s
#5 sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 15.73MB / 60.29MB 13.8s
#5 sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 18.87MB / 60.29MB 15.0s
#5 sha256:42c077c10790d51b6f75c4eb895cbd4da37558f7215b39cbf64c46b288f89bda 20.97MB / 31.38MB 16.1s
#5 sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 22.02MB / 60.29MB 16.1s
#5 sha256:1a23c9d790a34c5bb13dbaf42e0ea2a555e089aefed7fdfa980654f773b39b39 18.87MB / 50.06MB 16.6s
#5 sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 25.17MB / 60.29MB 17.2s
#5 sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 28.31MB / 60.29MB 18.3s
#5 sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 31.46MB / 60.29MB 19.2s
#5 sha256:42c077c10790d51b6f75c4eb895cbd4da37558f7215b39cbf64c46b288f89bda 23.07MB / 31.38MB 20.3s
#5 sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 34.60MB / 60.29MB 20.5s
#5 sha256:1a23c9d790a34c5bb13dbaf42e0ea2a555e089aefed7fdfa980654f773b39b39 22.02MB / 50.06MB 21.3s
#5 sha256:42c077c10790d51b6f75c4eb895cbd4da37558f7215b39cbf64c46b288f89bda 25.17MB / 31.38MB 22.2s
#5 sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 37.75MB / 60.29MB 23.9s
#5 sha256:42c077c10790d51b6f75c4eb895cbd4da37558f7215b39cbf64c46b288f89bda 27.26MB / 31.38MB 25.3s
#5 sha256:1a23c9d790a34c5bb13dbaf42e0ea2a555e089aefed7fdfa980654f773b39b39 25.17MB / 50.06MB 25.3s
#5 sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 40.89MB / 60.29MB 25.9s
#5 sha256:42c077c10790d51b6f75c4eb895cbd4da37558f7215b39cbf64c46b288f89bda 29.36MB / 31.38MB 27.3s
#5 sha256:1a23c9d790a34c5bb13dbaf42e0ea2a555e089aefed7fdfa980654f773b39b39 28.31MB / 50.06MB 27.7s
#5 sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 44.04MB / 60.29MB 28.2s
#5 sha256:42c077c10790d51b6f75c4eb895cbd4da37558f7215b39cbf64c46b288f89bda 31.38MB / 31.38MB 28.9s done
#5 extracting sha256:42c077c10790d51b6f75c4eb895cbd4da37558f7215b39cbf64c46b288f89bda
#5 sha256:1a23c9d790a34c5bb13dbaf42e0ea2a555e089aefed7fdfa980654f773b39b39 31.46MB / 50.06MB 29.6s
#5 sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 47.19MB / 60.29MB 30.2s
#5 sha256:1a23c9d790a34c5bb13dbaf42e0ea2a555e089aefed7fdfa980654f773b39b39 34.60MB / 50.06MB 31.4s
#5 sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 50.33MB / 60.29MB 31.6s
#5 extracting sha256:42c077c10790d51b6f75c4eb895cbd4da37558f7215b39cbf64c46b288f89bda 2.8s done
#5 sha256:1a23c9d790a34c5bb13dbaf42e0ea2a555e089aefed7fdfa980654f773b39b39 37.75MB / 50.06MB 32.9s
#5 sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 53.48MB / 60.29MB 33.4s
#5 sha256:1a23c9d790a34c5bb13dbaf42e0ea2a555e089aefed7fdfa980654f773b39b39 40.89MB / 50.06MB 34.4s
#5 sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 56.62MB / 60.29MB 35.2s
#5 sha256:1a23c9d790a34c5bb13dbaf42e0ea2a555e089aefed7fdfa980654f773b39b39 44.04MB / 50.06MB 35.8s
#5 sha256:1a23c9d790a34c5bb13dbaf42e0ea2a555e089aefed7fdfa980654f773b39b39 47.19MB / 50.06MB 37.0s
#5 sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 59.77MB / 60.29MB 37.3s
#5 sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 60.29MB / 60.29MB 37.5s done
#5 sha256:1a23c9d790a34c5bb13dbaf42e0ea2a555e089aefed7fdfa980654f773b39b39 50.06MB / 50.06MB 38.0s done
#5 extracting sha256:1a23c9d790a34c5bb13dbaf42e0ea2a555e089aefed7fdfa980654f773b39b39
#5 extracting sha256:1a23c9d790a34c5bb13dbaf42e0ea2a555e089aefed7fdfa980654f773b39b39 2.8s done
#5 extracting sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09
#5 extracting sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 3.4s done
#5 DONE 44.6s

#6 [2/4] COPY app/1.sh /1.sh
#6 sha256:9574b442d6515837b7abf981cdddd851469d74befa598b07dafd1b638db58f8a
#6 DONE 0.9s

#7 [3/4] RUN /bin/bash -c 'chmod ug+x /1.sh'
#7 sha256:3a39949b51fed022bb365f194ae8b0574278b89016c45de0990e6bf7d589edf3
#7 DONE 0.4s

#8 [4/4] RUN /bin/bash -c 'conda install -y -c conda-forge mlflow && conda install -y -c anaconda boto3 pymysql'
#8 sha256:b74db726c4b5dda78f19242cbd7d44ee28622a8ad6501c01f8d3ff9bb7f865d5
#8 1.074 Collecting package metadata (current_repodata.json): ...working... done
#8 25.85 Solving environment: ...working... done
#8 40.75
#8 40.75
#8 40.75 ==> WARNING: A newer version of conda exists. <==
#8 40.75   current version: 4.12.0
#8 40.75   latest version: 4.13.0
#8 40.75
#8 40.75 Please update conda by running
#8 40.75
#8 40.75     $ conda update -n base -c defaults conda
#8 40.75
#8 40.75
#8 40.77
#8 40.77 ## Package Plan ##
#8 40.77
#8 40.77   environment location: /opt/conda
#8 40.77
#8 40.77   added / updated specs:
#8 40.77     - mlflow
#8 40.77
#8 40.77
#8 40.77 The following packages will be downloaded:
#8 40.77
#8 40.77     package                    |            build
#8 40.77     ---------------------------|-----------------
#8 40.77     alembic-1.8.0              |     pyhd8ed1ab_0         137 KB  conda-forge
#8 40.77     appdirs-1.4.4              |     pyh9f0ad1d_0          13 KB  conda-forge
#8 40.77     asn1crypto-1.5.1           |     pyhd8ed1ab_0          79 KB  conda-forge
#8 40.77     blas-1.0                   |              mkl           6 KB
#8 40.77     blinker-1.4                |             py_1          13 KB  conda-forge
#8 40.77     bottleneck-1.3.4           |   py39hce1f21e_0         126 KB
#8 40.77     ca-certificates-2022.6.15  |       ha878542_0         149 KB  conda-forge
#8 40.77     certifi-2022.6.15          |   py39hf3d152e_0         155 KB  conda-forge
#8 40.77     click-8.1.3                |   py39hf3d152e_0         146 KB  conda-forge
#8 40.77     cloudpickle-2.1.0          |     pyhd8ed1ab_0          25 KB  conda-forge
#8 40.77     conda-4.13.0               |   py39hf3d152e_1         998 KB  conda-forge
#8 40.77     configparser-5.2.0         |     pyhd8ed1ab_0          21 KB  conda-forge
#8 40.77     databricks-cli-0.17.0      |     pyhd8ed1ab_0          75 KB  conda-forge
#8 40.77     docker-py-5.0.3            |   py39hf3d152e_2         188 KB  conda-forge
#8 40.77     docker-pycreds-0.4.0       |             py_0          11 KB  conda-forge
#8 40.77     entrypoints-0.4            |     pyhd8ed1ab_0           9 KB  conda-forge
#8 40.77     flask-2.1.2                |     pyhd8ed1ab_1          70 KB  conda-forge
#8 40.77     gitdb-4.0.9                |     pyhd8ed1ab_0          46 KB  conda-forge
#8 40.77     gitpython-3.1.27           |     pyhd8ed1ab_0         123 KB  conda-forge
#8 40.77     gorilla-0.4.0              |     pyhd8ed1ab_0          13 KB  conda-forge
#8 40.77     greenlet-1.1.1             |   py39h295c915_0          82 KB
#8 40.77     gunicorn-20.1.0            |   py39hf3d152e_2         119 KB  conda-forge
#8 40.77     importlib-metadata-4.11.4  |   py39hf3d152e_0          33 KB  conda-forge
#8 40.77     importlib_resources-5.8.0  |     pyhd8ed1ab_0          22 KB  conda-forge
#8 40.77     intel-openmp-2021.4.0      |    h06a4308_3561         4.2 MB
#8 40.77     itsdangerous-2.1.2         |     pyhd8ed1ab_0          16 KB  conda-forge
#8 40.77     jinja2-3.1.2               |     pyhd8ed1ab_1          99 KB  conda-forge
#8 40.77     libprotobuf-3.15.8         |       h780b84a_0         2.5 MB  conda-forge
#8 40.77     mako-1.2.1                 |     pyhd8ed1ab_0          61 KB  conda-forge
#8 40.77     markupsafe-2.0.1           |   py39h3811e60_0          22 KB  conda-forge
#8 40.77     mkl-2021.4.0               |     h06a4308_640       142.6 MB
#8 40.77     mkl-service-2.4.0          |   py39h3811e60_0          61 KB  conda-forge
#8 40.77     mkl_fft-1.3.1              |   py39hd3c417c_0         182 KB
#8 40.77     mkl_random-1.2.2           |   py39hde0f152_0         379 KB  conda-forge
#8 40.77     mlflow-1.2.0               |             py_1         3.4 MB  conda-forge
#8 40.77     numexpr-2.8.1              |   py39h6abb31d_0         124 KB
#8 40.77     numpy-1.22.3               |   py39he7a7128_0          10 KB
#8 40.77     numpy-base-1.22.3          |   py39hf524024_0         5.4 MB
#8 40.77     oauthlib-3.2.0             |     pyhd8ed1ab_0          90 KB  conda-forge
#8 40.77     packaging-21.3             |     pyhd8ed1ab_0          36 KB  conda-forge
#8 40.77     pandas-1.4.2               |   py39h295c915_0         9.9 MB
#8 40.77     protobuf-3.15.8            |   py39he80948d_0         336 KB  conda-forge
#8 40.77     pyjwt-2.4.0                |     pyhd8ed1ab_0          19 KB  conda-forge
#8 40.77     pyparsing-3.0.9            |     pyhd8ed1ab_0          79 KB  conda-forge
#8 40.77     python-dateutil-2.8.2      |     pyhd8ed1ab_0         240 KB  conda-forge
#8 40.77     python_abi-3.9             |           2_cp39           4 KB  conda-forge
#8 40.77     pytz-2022.1                |     pyhd8ed1ab_0         242 KB  conda-forge
#8 40.77     pyyaml-5.4.1               |   py39h3811e60_0         193 KB  conda-forge
#8 40.77     querystring_parser-1.2.4   |             py_0          10 KB  conda-forge
#8 40.77     simplejson-3.17.6          |   py39h7f8727e_0         104 KB
#8 40.77     smmap-3.0.5                |     pyh44b312d_0          22 KB  conda-forge
#8 40.77     sqlalchemy-1.4.13          |   py39h3811e60_0         2.2 MB  conda-forge
#8 40.77     sqlparse-0.4.2             |     pyhd8ed1ab_0          34 KB  conda-forge
#8 40.77     tabulate-0.8.10            |     pyhd8ed1ab_0          29 KB  conda-forge
#8 40.77     typing_extensions-4.3.0    |     pyha770c72_0          28 KB  conda-forge
#8 40.77     websocket-client-1.3.3     |     pyhd8ed1ab_0          41 KB  conda-forge
#8 40.77     werkzeug-2.1.2             |     pyhd8ed1ab_1         237 KB  conda-forge
#8 40.77     zipp-3.8.0                 |     pyhd8ed1ab_0          12 KB  conda-forge
#8 40.77     ------------------------------------------------------------
#8 40.77                                            Total:       175.5 MB
#8 40.77
#8 40.77 The following NEW packages will be INSTALLED:
#8 40.77
#8 40.77   alembic            conda-forge/noarch::alembic-1.8.0-pyhd8ed1ab_0
#8 40.77   appdirs            conda-forge/noarch::appdirs-1.4.4-pyh9f0ad1d_0
#8 40.77   asn1crypto         conda-forge/noarch::asn1crypto-1.5.1-pyhd8ed1ab_0
#8 40.77   blas               pkgs/main/linux-64::blas-1.0-mkl
#8 40.77   blinker            conda-forge/noarch::blinker-1.4-py_1
#8 40.77   bottleneck         pkgs/main/linux-64::bottleneck-1.3.4-py39hce1f21e_0
#8 40.77   click              conda-forge/linux-64::click-8.1.3-py39hf3d152e_0
#8 40.77   cloudpickle        conda-forge/noarch::cloudpickle-2.1.0-pyhd8ed1ab_0
#8 40.77   configparser       conda-forge/noarch::configparser-5.2.0-pyhd8ed1ab_0
#8 40.77   databricks-cli     conda-forge/noarch::databricks-cli-0.17.0-pyhd8ed1ab_0
#8 40.77   docker-py          conda-forge/linux-64::docker-py-5.0.3-py39hf3d152e_2
#8 40.77   docker-pycreds     conda-forge/noarch::docker-pycreds-0.4.0-py_0
#8 40.77   entrypoints        conda-forge/noarch::entrypoints-0.4-pyhd8ed1ab_0
#8 40.77   flask              conda-forge/noarch::flask-2.1.2-pyhd8ed1ab_1
#8 40.77   gitdb              conda-forge/noarch::gitdb-4.0.9-pyhd8ed1ab_0
#8 40.77   gitpython          conda-forge/noarch::gitpython-3.1.27-pyhd8ed1ab_0
#8 40.77   gorilla            conda-forge/noarch::gorilla-0.4.0-pyhd8ed1ab_0
#8 40.77   greenlet           pkgs/main/linux-64::greenlet-1.1.1-py39h295c915_0
#8 40.77   gunicorn           conda-forge/linux-64::gunicorn-20.1.0-py39hf3d152e_2
#8 40.77   importlib-metadata conda-forge/linux-64::importlib-metadata-4.11.4-py39hf3d152e_0
#8 40.77   importlib_resourc~ conda-forge/noarch::importlib_resources-5.8.0-pyhd8ed1ab_0
#8 40.77   intel-openmp       pkgs/main/linux-64::intel-openmp-2021.4.0-h06a4308_3561
#8 40.77   itsdangerous       conda-forge/noarch::itsdangerous-2.1.2-pyhd8ed1ab_0
#8 40.77   jinja2             conda-forge/noarch::jinja2-3.1.2-pyhd8ed1ab_1
#8 40.77   libprotobuf        conda-forge/linux-64::libprotobuf-3.15.8-h780b84a_0
#8 40.77   mako               conda-forge/noarch::mako-1.2.1-pyhd8ed1ab_0
#8 40.77   markupsafe         conda-forge/linux-64::markupsafe-2.0.1-py39h3811e60_0
#8 40.77   mkl                pkgs/main/linux-64::mkl-2021.4.0-h06a4308_640
#8 40.77   mkl-service        conda-forge/linux-64::mkl-service-2.4.0-py39h3811e60_0
#8 40.77   mkl_fft            pkgs/main/linux-64::mkl_fft-1.3.1-py39hd3c417c_0
#8 40.77   mkl_random         conda-forge/linux-64::mkl_random-1.2.2-py39hde0f152_0
#8 40.77   mlflow             conda-forge/noarch::mlflow-1.2.0-py_1
#8 40.77   numexpr            pkgs/main/linux-64::numexpr-2.8.1-py39h6abb31d_0
#8 40.77   numpy              pkgs/main/linux-64::numpy-1.22.3-py39he7a7128_0
#8 40.77   numpy-base         pkgs/main/linux-64::numpy-base-1.22.3-py39hf524024_0
#8 40.77   oauthlib           conda-forge/noarch::oauthlib-3.2.0-pyhd8ed1ab_0
#8 40.77   packaging          conda-forge/noarch::packaging-21.3-pyhd8ed1ab_0
#8 40.77   pandas             pkgs/main/linux-64::pandas-1.4.2-py39h295c915_0
#8 40.77   protobuf           conda-forge/linux-64::protobuf-3.15.8-py39he80948d_0
#8 40.77   pyjwt              conda-forge/noarch::pyjwt-2.4.0-pyhd8ed1ab_0
#8 40.77   pyparsing          conda-forge/noarch::pyparsing-3.0.9-pyhd8ed1ab_0
#8 40.77   python-dateutil    conda-forge/noarch::python-dateutil-2.8.2-pyhd8ed1ab_0
#8 40.77   python_abi         conda-forge/linux-64::python_abi-3.9-2_cp39
#8 40.77   pytz               conda-forge/noarch::pytz-2022.1-pyhd8ed1ab_0
#8 40.77   pyyaml             conda-forge/linux-64::pyyaml-5.4.1-py39h3811e60_0
#8 40.77   querystring_parser conda-forge/noarch::querystring_parser-1.2.4-py_0
#8 40.77   simplejson         pkgs/main/linux-64::simplejson-3.17.6-py39h7f8727e_0
#8 40.77   smmap              conda-forge/noarch::smmap-3.0.5-pyh44b312d_0
#8 40.77   sqlalchemy         conda-forge/linux-64::sqlalchemy-1.4.13-py39h3811e60_0
#8 40.77   sqlparse           conda-forge/noarch::sqlparse-0.4.2-pyhd8ed1ab_0
#8 40.77   tabulate           conda-forge/noarch::tabulate-0.8.10-pyhd8ed1ab_0
#8 40.77   typing_extensions  conda-forge/noarch::typing_extensions-4.3.0-pyha770c72_0
#8 40.77   websocket-client   conda-forge/noarch::websocket-client-1.3.3-pyhd8ed1ab_0
#8 40.77   werkzeug           conda-forge/noarch::werkzeug-2.1.2-pyhd8ed1ab_1
#8 40.77   zipp               conda-forge/noarch::zipp-3.8.0-pyhd8ed1ab_0
#8 40.77
#8 40.77 The following packages will be UPDATED:
#8 40.77
#8 40.77   ca-certificates    pkgs/main::ca-certificates-2022.3.29-~ --> conda-forge::ca-certificates-2022.6.15-ha878542_0
#8 40.77   certifi            pkgs/main::certifi-2021.10.8-py39h06a~ --> conda-forge::certifi-2022.6.15-py39hf3d152e_0
#8 40.77   conda              pkgs/main::conda-4.12.0-py39h06a4308_0 --> conda-forge::conda-4.13.0-py39hf3d152e_1
#8 40.77
#8 40.77
#8 40.77
#8 40.77 Downloading and Extracting Packages
simplejson-3.17.6    | 104 KB    | ########## | 100%
click-8.1.3          | 146 KB    | ########## | 100%
pyyaml-5.4.1         | 193 KB    | ########## | 100%
gitpython-3.1.27     | 123 KB    | ########## | 100%
zipp-3.8.0           | 12 KB     | ########## | 100%
gitdb-4.0.9          | 46 KB     | ########## | 100%
markupsafe-2.0.1     | 22 KB     | ########## | 100%
mkl-service-2.4.0    | 61 KB     | ########## | 100%
smmap-3.0.5          | 22 KB     | ########## | 100%
ca-certificates-2022 | 149 KB    | ########## | 100%
jinja2-3.1.2         | 99 KB     | ########## | 100%
docker-pycreds-0.4.0 | 11 KB     | ########## | 100%
gorilla-0.4.0        | 13 KB     | ########## | 100%
blinker-1.4          | 13 KB     | ########## | 100%
flask-2.1.2          | 70 KB     | ########## | 100%
docker-py-5.0.3      | 188 KB    | ########## | 100%
greenlet-1.1.1       | 82 KB     | ########## | 100%
tabulate-0.8.10      | 29 KB     | ########## | 100%
gunicorn-20.1.0      | 119 KB    | ########## | 100%
libprotobuf-3.15.8   | 2.5 MB    | ########## | 100%
querystring_parser-1 | 10 KB     | ########## | 100%
numpy-1.22.3         | 10 KB     | ########## | 100%
protobuf-3.15.8      | 336 KB    | ########## | 100%
cloudpickle-2.1.0    | 25 KB     | ########## | 100%
sqlalchemy-1.4.13    | 2.2 MB    | ########## | 100%
importlib_resources- | 22 KB     | ########## | 100%
itsdangerous-2.1.2   | 16 KB     | ########## | 100%
mkl_fft-1.3.1        | 182 KB    | ########## | 100%
configparser-5.2.0   | 21 KB     | ########## | 100%
mkl_random-1.2.2     | 379 KB    | ########## | 100%
bottleneck-1.3.4     | 126 KB    | ########## | 100%
databricks-cli-0.17. | 75 KB     | ########## | 100%
blas-1.0             | 6 KB      | ########## | 100%
intel-openmp-2021.4. | 4.2 MB    | ########## | 100%
websocket-client-1.3 | 41 KB     | ########## | 100%
appdirs-1.4.4        | 13 KB     | ########## | 100%
pyparsing-3.0.9      | 79 KB     | ########## | 100%
conda-4.13.0         | 998 KB    | ########## | 100%
python-dateutil-2.8. | 240 KB    | ########## | 100%
python_abi-3.9       | 4 KB      | ########## | 100%
numexpr-2.8.1        | 124 KB    | ########## | 100%
entrypoints-0.4      | 9 KB      | ########## | 100%
pyjwt-2.4.0          | 19 KB     | ########## | 100%
mlflow-1.2.0         | 3.4 MB    | ########## | 100%
pytz-2022.1          | 242 KB    | ########## | 100%
typing_extensions-4. | 28 KB     | ########## | 100%
pandas-1.4.2         | 9.9 MB    | ########## | 100%
numpy-base-1.22.3    | 5.4 MB    | ########## | 100%
alembic-1.8.0        | 137 KB    | ########## | 100%
sqlparse-0.4.2       | 34 KB     | ########## | 100%
oauthlib-3.2.0       | 90 KB     | ########## | 100%
werkzeug-2.1.2       | 237 KB    | ########## | 100%
mkl-2021.4.0         | 142.6 MB  | ########## | 100%
asn1crypto-1.5.1     | 79 KB     | ########## | 100%
importlib-metadata-4 | 33 KB     | ########## | 100%
mako-1.2.1           | 61 KB     | ########## | 100%
certifi-2022.6.15    | 155 KB    | ########## | 100%
packaging-21.3       | 36 KB     | ########## | 100%
#8 115.5 Preparing transaction: ...working... done
#8 115.9 Verifying transaction: ...working... done
#8 116.7 Executing transaction: ...working... done
#8 123.6 Collecting package metadata (current_repodata.json): ...working... done
#8 126.5 Solving environment: ...working... done
#8 130.1
#8 130.1 ## Package Plan ##
#8 130.1
#8 130.1   environment location: /opt/conda
#8 130.1
#8 130.1   added / updated specs:
#8 130.1     - boto3
#8 130.1     - pymysql
#8 130.1
#8 130.1
#8 130.1 The following packages will be downloaded:
#8 130.1
#8 130.1     package                    |            build
#8 130.1     ---------------------------|-----------------
#8 130.1     boto3-1.24.2               |   py39h06a4308_0         127 KB  anaconda
#8 130.1     botocore-1.27.2            |   py39h06a4308_0         5.7 MB  anaconda
#8 130.1     ca-certificates-2022.4.26  |       h06a4308_0         132 KB  anaconda
#8 130.1     certifi-2022.6.15          |   py39h06a4308_0         156 KB  anaconda
#8 130.1     conda-4.13.0               |   py39h06a4308_0         995 KB  anaconda
#8 130.1     jmespath-0.10.0            |     pyhd3eb1b0_0          21 KB  anaconda
#8 130.1     openssl-1.1.1o             |       h7f8727e_0         3.8 MB  anaconda
#8 130.1     pymysql-1.0.2              |   py39h06a4308_1          78 KB  anaconda
#8 130.1     s3transfer-0.6.0           |   py39h06a4308_0         101 KB  anaconda
#8 130.1     ------------------------------------------------------------
#8 130.1                                            Total:        11.0 MB
#8 130.1
#8 130.1 The following NEW packages will be INSTALLED:
#8 130.1
#8 130.1   boto3              anaconda/linux-64::boto3-1.24.2-py39h06a4308_0
#8 130.1   botocore           anaconda/linux-64::botocore-1.27.2-py39h06a4308_0
#8 130.1   jmespath           anaconda/noarch::jmespath-0.10.0-pyhd3eb1b0_0
#8 130.1   pymysql            anaconda/linux-64::pymysql-1.0.2-py39h06a4308_1
#8 130.1   s3transfer         anaconda/linux-64::s3transfer-0.6.0-py39h06a4308_0
#8 130.1
#8 130.1 The following packages will be UPDATED:
#8 130.1
#8 130.1   openssl              pkgs/main::openssl-1.1.1n-h7f8727e_0 --> anaconda::openssl-1.1.1o-h7f8727e_0
#8 130.1
#8 130.1 The following packages will be SUPERSEDED by a higher-priority channel:
#8 130.1
#8 130.1   ca-certificates    conda-forge::ca-certificates-2022.6.1~ --> anaconda::ca-certificates-2022.4.26-h06a4308_0
#8 130.1   certifi            conda-forge::certifi-2022.6.15-py39hf~ --> anaconda::certifi-2022.6.15-py39h06a4308_0
#8 130.1   conda              conda-forge::conda-4.13.0-py39hf3d152~ --> anaconda::conda-4.13.0-py39h06a4308_0
#8 130.1
#8 130.1
#8 130.1
#8 130.1 Downloading and Extracting Packages
s3transfer-0.6.0     | 101 KB    | ########## | 100%
boto3-1.24.2         | 127 KB    | ########## | 100%
certifi-2022.6.15    | 156 KB    | ########## | 100%
conda-4.13.0         | 995 KB    | ########## | 100%
openssl-1.1.1o       | 3.8 MB    | ########## | 100%
pymysql-1.0.2        | 78 KB     | ########## | 100%
botocore-1.27.2      | 5.7 MB    | ########## | 100%
ca-certificates-2022 | 132 KB    | ########## | 100%
jmespath-0.10.0      | 21 KB     | ########## | 100%
#8 137.9 Preparing transaction: ...working... done
#8 138.1 Verifying transaction: ...working... done
#8 138.6 Executing transaction: ...working... done
#8 DONE 142.2s

#10 exporting to image
#10 sha256:e8c613e07b0b7ff33893b694f7759a10d42e180f2b4dc349fb57dc6b71dcab00
#10 exporting layers
#10 exporting layers 8.1s done
#10 writing image sha256:63a33b70f430aaae901ed47d1a4f6bab8ba8e78d0f1933b20c9d49135d9b0fe8 done
#10 naming to docker.io/library/netology-ml:netology-ml done
#10 DONE 8.1s
```

# $ docker run -i netology-ml:netology-ml

```
Hello Netology
```