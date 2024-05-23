version: '3.3'
networks:
  iopex_network:
    external: true
services:
  nlp_api:
    image: belgin121/kafka_text_classification:3.3 #3.1
    #build: .
    ports:
      - "8051:80"
    environment:
       - APP_URL=http://10.10.50.36:8051
       - SENTIMENT_ANALYSIS_URL=http://10.10.50.36:8060/sentiment_analysis
       - FAST_API_MODEL_TRAINING=http://10.10.50.36:8052/
       - KAFKA_SERVER_URL=10.10.50.36:9092
    networks:
      - 'iopex_network'
    depends_on:
      - text_classification_api_db
    restart: on-failure:5
    volumes:
      - "./logger:/var/opt/logger"
      - "./media:/var/opt/media"
  text_classification_api_db:
    image: postgres:12
    networks:
      - 'iopex_network'
    restart: on-failure:5
    volumes:
      - ./data:/var/lib/postgresql/data
    environment:
      POSTGRES_DB: text_classification
      POSTGRES_PASSWORD: iopex@123









        File "/usr/local/lib/python3.8/dist-packages/psycopg2/__init__.py", line 126, in connect
kafka_nlp-nlp_api-1                     |     conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
kafka_nlp-nlp_api-1                     | django.db.utils.OperationalError: could not connect to server: No such file or directory
kafka_nlp-nlp_api-1                     | 	Is the server running locally and accepting
kafka_nlp-nlp_api-1                     | 	connections on Unix domain socket "/var/run/postgresql/.s.PGSQL.5432"?
kafka_nlp-nlp_api-1                     | 
