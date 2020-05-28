From: James Bottomley <James.Bottomley@...2316...>
Date: Thu, 28 May 2020 15:59:17 -0700
Message-Id: <20200528225920.6983-1-James.Bottomley@...2316...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6 0/3] add support for engine keys
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

This update exposes the new configuration file addition to the openssl
initialization as a separate patch.  This means that the behaviour of
pontentially reading from a configuration file is global rather than
contingent on the engine parameter being present and thus is now fully
consistent.  I've added this as a separate patch, since it's a
separate feature.

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

James Bottomley (3):
  openssl: add engine method for loading the key
  crypto_openssl: add initialization to pick up local configuration
  Add unit tests for engine keys

 configure.ac                                  |   5 +
 src/openvpn/crypto_openssl.c                  |  61 +++++++++++
 src/openvpn/crypto_openssl.h                  |  12 +++
 src/openvpn/ssl_openssl.c                     |   5 +
 tests/unit_tests/Makefile.am                  |   3 +
 tests/unit_tests/engine-key/Makefile.am       |  24 +++++
 .../engine-key/check_engine_keys.sh           |  30 ++++++
 tests/unit_tests/engine-key/libtestengine.c   | 101 ++++++++++++++++++
 tests/unit_tests/engine-key/openssl.cnf.in    |  12 +++
 9 files changed, 253 insertions(+)
 create mode 100644 tests/unit_tests/engine-key/Makefile.am
 create mode 100755 tests/unit_tests/engine-key/check_engine_keys.sh
 create mode 100644 tests/unit_tests/engine-key/libtestengine.c
 create mode 100644 tests/unit_tests/engine-key/openssl.cnf.in

-- 
2.26.2


