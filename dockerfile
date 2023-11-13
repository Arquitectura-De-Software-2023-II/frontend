FROM flutter:3.13.9

RUN mkdir /front
WORKDIR /front
COPY pubspec.yaml /front
RUN flutter pub get
COPY . /front/

CMD ["sh", "-c", "flutter create . && flutter build web --web-renderer canvaskit --release &&flutter run -d web"]