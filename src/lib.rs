use actix_web::{App, HttpRequest, HttpResponse, HttpServer, Responder, web};
use actix_web::dev::Server;
use std::net::TcpListener;

async fn health_check(req: HttpRequest) -> HttpResponse {
    HttpResponse::Ok().finish()
}

pub fn run(listener: TcpListener) -> Result<Server, std::io::Error> {
    let server=HttpServer::new(|| {
        App::new()
            .route("/health_check",web::get().to(health_check))
    })
    .listen(listener)?
    .run();
    Ok(server)
}
