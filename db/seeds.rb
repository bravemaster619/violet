User.destroy_all

User.create!([{
                  name: 'admin',
                  email: 'admin@dev.com',
                  role: 'admin',
                  birthday: Date.new(1993, 6, 19),
                  verified: true,
                  allowed: true,
                  password_digest: BCrypt::Password.create('admin123')
              }])