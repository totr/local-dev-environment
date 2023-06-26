
git clone git@github.com:comtrya/comtrya.git

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup install stable
rustup component add rustfmt
rustup component add clippy
cargo install cargo-nextest

cd comtrya
cargo build --release
sudo cp target/release/comtrya /usr/local/bin/comtrya