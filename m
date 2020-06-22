From: James Bottomley <James.Bottomley@...2316...>
Date: Mon, 22 Jun 2020 16:23:18 -0700
Message-Id: <20200622232319.8143-1-James.Bottomley@...2316...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v8 0/1] Add unit tests for engine keys
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

This is the version that should work on Linux, Mac and BSD (famous
last words ...).  I've checked it on the Linux platforms (Ubuntu and
OpenSUSE).

James

---

James Bottomley (1):
  Add unit tests for engine keys

 configure.ac                                  |   2 +
 tests/unit_tests/Makefile.am                  |   3 +
 tests/unit_tests/engine-key/Makefile.am       |  24 +++++
 .../engine-key/check_engine_keys.sh           |  30 ++++++
 tests/unit_tests/engine-key/libtestengine.c   | 101 ++++++++++++++++++
 tests/unit_tests/engine-key/openssl.cnf.in    |  12 +++
 6 files changed, 172 insertions(+)
 create mode 100644 tests/unit_tests/engine-key/Makefile.am
 create mode 100755 tests/unit_tests/engine-key/check_engine_keys.sh
 create mode 100644 tests/unit_tests/engine-key/libtestengine.c
 create mode 100644 tests/unit_tests/engine-key/openssl.cnf.in

-- 
2.26.2


