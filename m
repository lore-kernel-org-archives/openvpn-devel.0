From: selva.nair@...277...
Date: Tue, 14 Mar 2023 21:35:12 -0400
Message-Id: <20230315013516.1256700-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/4] Add some tests for cryptoapi.c functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Selva Nair <selva.nair@...277...>

  Import some sample certificates into Windows store for testing
    - 4 test certificates&keys imported to user store
      and removed at the end.

  Add tests for finding certificates in Windows certficate store
    - test using SUBJ:, THUMB: and ISSUER: select-strings

  Refactor SSL_CTX_use_CryptoAPI_certificate()
    - A minor reorganization avoids wrapping for the next test

  Add a test for signing with certificates in Windows store
    - Test loading keys into xkey-provider and sign a test message.
      The signature is then verified using OpenSSL.

Sample output the test runs:
https://github.com/selvanair/openvpn/actions/runs/4418774866/jobs/7746404938#step:8:1

 src/openvpn/cryptoapi.c                   |  63 ++--
 tests/unit_tests/openvpn/Makefile.am      |   1 +
 tests/unit_tests/openvpn/cert_data.h      | 166 +++++++++
 tests/unit_tests/openvpn/test_cryptoapi.c | 429 +++++++++++++++++++++-
 4 files changed, 635 insertions(+), 24 deletions(-)
 create mode 100644 tests/unit_tests/openvpn/cert_data.h

-- 
2.34.1


