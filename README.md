README
=======
Sonitus is a simple application to keep track of one's music collection.

* Deployed on [sonitus.jgroeneveld.de](http://sonitus.jgroeneveld.de)
* Testuser with some albums: maxmuster@example.com / 12345678

Versions
-------
* Ruby: 2.0.0
* Rails: 4.0.0rc2

Important Gems:
-------
* Viewtemplates: [Haml](http://haml.info/)
* Auth: [devise](https://github.com/plataformatec/devise)
* Testing: [RSpec](http://rspec.info/), [Steak](https://github.com/cavalle/steak), [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
* TestData: [Fabrication](http://fabricationgem.org), [Faker](https://github.com/stympy/faker)
* CodeCoverage: [SimpleCov](https://github.com/colszowka/simplecov)
* Forms: [SimpleForm](https://github.com/plataformatec/simple_form)
* Uploading: [CarrierWave](https://github.com/carrierwaveuploader/carrierwave)
* CSS-Framework: [Skeleton](http://www.getskeleton.com/)

Running
-------
Run Tests

    bin/rspec

Generate Code Coverage

    rake coverage
