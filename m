From: David Sommerseth <davids@...515...>
Date: Tue,  7 May 2019 22:04:34 +0200
Message-Id: <20190507200434.24931-1-davids@...515...>
In-Reply-To: <20190417203015.1903-1-davids@...515...>
References: <20190417203015.1903-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH v2.4] build: Package missing mock_msg.h
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

The mock_msg.h file was not enlisted in the _SOURCES lists in
Makefile.am for the unit tests.  This caused the mock_msg.h file to not
be present in the .tar.gz file created by 'make dist'.

This was not noticed earlier as we haven't really tried much to run git
clone of the cmocka project manually in vendor/ from an unpacked
tarball.

With this fix the cmocka unit tests can also run from tarballs, with
manually extracting/fetching the cmocka source code in vendor/cmocka.

This patch is a backport of git master commit 19a22ac5a8673e8715.

Signed-off-by: David Sommerseth <davids@...515...>
Cc: Steffan Karger <steffan.karger@...2507...>

----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----

How to test:

- Create a tarball: make distcheck (or just 'dist')
- Extract openvpn-2.4.*.tar.gz in a clean directory
- cd openvpn-2.4.*/vendor
- git clone https://git.cryptomilk.org/projects/cmocka.git
- cd ..
- ./configure
- make check
- Observe that the cmocka unit tests ran as expected

Depending on the CMake version, you might want to check out cmocka git
commit b2732b52202ae48f; which is the one we use in the git submodule.
---
 tests/unit_tests/openvpn/Makefile.am | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 7b44f42e..55e29e40 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -20,14 +20,14 @@ argv_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(compat_srcdir) \
 	$(OPTIONAL_CRYPTO_CFLAGS)
 argv_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(openvpn_srcdir) -Wl,--wrap=parse_line \
 	$(OPTIONAL_CRYPTO_LIBS)
-argv_testdriver_SOURCES = test_argv.c mock_msg.c \
+argv_testdriver_SOURCES = test_argv.c mock_msg.c mock_msg.h \
 	$(openvpn_srcdir)/platform.c \
 	$(openvpn_srcdir)/buffer.c \
 	$(openvpn_srcdir)/argv.c
 
 buffer_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(compat_srcdir)
 buffer_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(openvpn_srcdir) -Wl,--wrap=parse_line
-buffer_testdriver_SOURCES = test_buffer.c mock_msg.c \
+buffer_testdriver_SOURCES = test_buffer.c mock_msg.c mock_msg.h \
 	$(openvpn_srcdir)/buffer.c \
 	$(openvpn_srcdir)/platform.c
 
@@ -36,7 +36,7 @@ packet_id_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 	$(OPTIONAL_CRYPTO_CFLAGS)
 packet_id_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)
-packet_id_testdriver_SOURCES = test_packet_id.c mock_msg.c \
+packet_id_testdriver_SOURCES = test_packet_id.c mock_msg.c mock_msg.h \
 	$(openvpn_srcdir)/buffer.c \
 	$(openvpn_srcdir)/otime.c \
 	$(openvpn_srcdir)/packet_id.c \
@@ -47,7 +47,7 @@ tls_crypt_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 	$(OPTIONAL_CRYPTO_CFLAGS)
 tls_crypt_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)
-tls_crypt_testdriver_SOURCES = test_tls_crypt.c mock_msg.c \
+tls_crypt_testdriver_SOURCES = test_tls_crypt.c mock_msg.c mock_msg.h \
 	$(openvpn_srcdir)/buffer.c \
 	$(openvpn_srcdir)/crypto.c \
 	$(openvpn_srcdir)/crypto_mbedtls.c \
-- 
2.17.1


