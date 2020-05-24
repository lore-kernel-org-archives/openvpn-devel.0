From: James Bottomley <James.Bottomley@...2316...>
Date: Sun, 24 May 2020 13:15:50 -0700
Message-Id: <20200524201552.15321-1-James.Bottomley@...2316...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5 0/2] add engine keys
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

This update tries to cope with the fact that the test engine
dynamic extension is different on macos (.dylib) and linux (.so)
by dynamically building the openssl.cnf file with the correct one

Note: I don't have any MacOS machines to test this on, so I only know
it works on Linux if someone with a Mac could check, I'd be grateful.

---

Engine keys are an openssl concept for a key file which can only be
understood by an engine (usually because it's been wrapped by the
engine itself).  We use this for TPM engine keys, so you can either
generate them within your TPM or wrap them from existing private keys.
 Once wrapped, the keys will only function in the TPM that generated
them, so it means the VPN keys are tied to the physical platform, which
is very useful.  Engine keys have to be loaded via a specific callback,
so use this as a fallback in openvpn if an engine is specified and if
the PEM read of the private key fails.

Adding a unit test for this type of key proved particularly
problematic: there's apparently no simple engine you can use to check
the functionality, so after a bit of googling, I just wrote one as part
of the test.  You can see that the unit test converts an existing key
to engine format (which is simply changing the PEM guards), tries to
start openvpn with the key and verifies that the engine methods are
called and the password correctly retrieved.  To make the test simple,
it relies on openssl detecting a mismatch between the certificate and
the key after the key has been loaded rather than going on to bring up
an openvpn loop, but I think that's sufficient to test out the engine
patch fully.

---

James Bottomley (2):
  openssl: add engine method for loading the key
  Add unit tests for engine keys

 configure.ac                                  |   5 +
 src/openvpn/crypto_openssl.c                  |  57 ++++++++++
 src/openvpn/crypto_openssl.h                  |  12 +++
 src/openvpn/ssl_openssl.c                     |   5 +
 tests/unit_tests/Makefile.am                  |   3 +
 tests/unit_tests/engine-key/Makefile.am       |  24 +++++
 .../engine-key/check_engine_keys.sh           |  30 ++++++
 tests/unit_tests/engine-key/libtestengine.c   | 101 ++++++++++++++++++
 tests/unit_tests/engine-key/openssl.cnf.in    |  12 +++
 9 files changed, 249 insertions(+)
 create mode 100644 tests/unit_tests/engine-key/Makefile.am
 create mode 100755 tests/unit_tests/engine-key/check_engine_keys.sh
 create mode 100644 tests/unit_tests/engine-key/libtestengine.c
 create mode 100644 tests/unit_tests/engine-key/openssl.cnf.in

-- 
2.26.2


