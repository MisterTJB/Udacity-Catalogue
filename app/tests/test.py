import os
import unittest
import tempfile
from app import main

class TestCase(unittest.TestCase):

    def setUp(self):
        # self.db_fd, main.app.config['DATABASE'] = tempfile.mkstemp()
        # main.app.config['TESTING'] = True
        # self.app = main.app.test_client()
        # with main.app.app_context():
        #     main.init_db()
        pass

    def tearDown(self):
        # os.close(self.db_fd)
        # os.unlink(main.app.config['DATABASE'])
        pass

if __name__ == '__main__':
    unittest.main()