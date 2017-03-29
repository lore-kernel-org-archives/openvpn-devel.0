From: David Sommerseth <davids@...515...>
Date: Wed, 29 Mar 2017 11:36:48 +0200
Message-Id: <20170329093648.10156-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] copyright: Update GPLv2 license texts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The COPYRIGHT.GPL file was slightly out-of-sync with the last GPLv2
license from Free Software Foundation, Inc.

The changes are primarily a new address, which required touching almost
all the project files.

Except of that, it is just minor adjustments to formatting, removal of
form-feed characters and referencing "GNU Lesser General Public License"
instead of "GNU Library General Public License".

Signed-off-by: David Sommerseth <davids@...515...>
---
 COPYRIGHT.GPL                                      | 39 +++++++++++-----------
 Makefile.am                                        |  7 ++--
 compat.m4                                          |  7 ++--
 configure.ac                                       |  7 ++--
 contrib/keychain-mcd/cert_data.c                   |  7 ++--
 contrib/keychain-mcd/cert_data.h                   |  7 ++--
 contrib/keychain-mcd/common_osx.c                  |  7 ++--
 contrib/keychain-mcd/common_osx.h                  |  7 ++--
 contrib/keychain-mcd/crypto_osx.c                  |  7 ++--
 contrib/keychain-mcd/crypto_osx.h                  |  7 ++--
 contrib/keychain-mcd/main.c                        |  7 ++--
 doc/doxygen/doc_compression.h                      |  7 ++--
 doc/doxygen/doc_control_processor.h                |  7 ++--
 doc/doxygen/doc_control_tls.h                      |  7 ++--
 doc/doxygen/doc_data_control.h                     |  7 ++--
 doc/doxygen/doc_data_crypto.h                      |  7 ++--
 doc/doxygen/doc_eventloop.h                        |  7 ++--
 doc/doxygen/doc_external_multiplexer.h             |  7 ++--
 doc/doxygen/doc_fragmentation.h                    |  7 ++--
 doc/doxygen/doc_internal_multiplexer.h             |  7 ++--
 doc/doxygen/doc_key_generation.h                   |  7 ++--
 doc/doxygen/doc_mainpage.h                         |  7 ++--
 doc/doxygen/doc_memory_management.h                |  7 ++--
 doc/doxygen/doc_protocol_overview.h                |  7 ++--
 doc/doxygen/doc_reliable.h                         |  7 ++--
 doc/doxygen/doc_tunnel_state.h                     |  7 ++--
 doc/openvpn.8                                      |  7 ++--
 include/openvpn-msg.h                              |  7 ++--
 include/openvpn-plugin.h.in                        |  7 ++--
 m4/pkg.m4                                          |  6 ++--
 sample/sample-plugins/defer/simple.c               |  7 ++--
 .../keyingmaterialexporter.c                       |  7 ++--
 sample/sample-plugins/log/log.c                    |  7 ++--
 sample/sample-plugins/log/log_v3.c                 |  7 ++--
 sample/sample-plugins/simple/simple.c              |  7 ++--
 src/compat/compat-basename.c                       |  7 ++--
 src/compat/compat-daemon.c                         |  7 ++--
 src/compat/compat-dirname.c                        |  7 ++--
 src/compat/compat-gettimeofday.c                   |  7 ++--
 src/compat/compat-inet_ntop.c                      |  7 ++--
 src/compat/compat-inet_pton.c                      |  7 ++--
 src/compat/compat.h                                |  7 ++--
 src/openvpn/argv.c                                 |  7 ++--
 src/openvpn/argv.h                                 |  7 ++--
 src/openvpn/basic.h                                |  7 ++--
 src/openvpn/block_dns.c                            |  7 ++--
 src/openvpn/block_dns.h                            |  7 ++--
 src/openvpn/buffer.c                               |  7 ++--
 src/openvpn/buffer.h                               |  7 ++--
 src/openvpn/circ_list.h                            |  7 ++--
 src/openvpn/clinat.c                               |  7 ++--
 src/openvpn/clinat.h                               |  7 ++--
 src/openvpn/common.h                               |  7 ++--
 src/openvpn/comp-lz4.c                             |  7 ++--
 src/openvpn/comp-lz4.h                             |  7 ++--
 src/openvpn/comp.c                                 |  7 ++--
 src/openvpn/comp.h                                 |  7 ++--
 src/openvpn/compstub.c                             |  7 ++--
 src/openvpn/console.c                              |  7 ++--
 src/openvpn/console.h                              |  9 +++--
 src/openvpn/console_builtin.c                      |  7 ++--
 src/openvpn/console_systemd.c                      |  7 ++--
 src/openvpn/crypto.c                               |  7 ++--
 src/openvpn/crypto.h                               |  7 ++--
 src/openvpn/crypto_backend.h                       |  7 ++--
 src/openvpn/crypto_mbedtls.c                       |  7 ++--
 src/openvpn/crypto_mbedtls.h                       |  7 ++--
 src/openvpn/crypto_openssl.c                       |  7 ++--
 src/openvpn/crypto_openssl.h                       |  7 ++--
 src/openvpn/dhcp.c                                 |  7 ++--
 src/openvpn/dhcp.h                                 |  7 ++--
 src/openvpn/errlevel.h                             |  7 ++--
 src/openvpn/error.c                                |  7 ++--
 src/openvpn/error.h                                |  7 ++--
 src/openvpn/event.c                                |  7 ++--
 src/openvpn/event.h                                |  7 ++--
 src/openvpn/fdmisc.c                               |  7 ++--
 src/openvpn/fdmisc.h                               |  7 ++--
 src/openvpn/forward-inline.h                       |  7 ++--
 src/openvpn/forward.c                              |  7 ++--
 src/openvpn/forward.h                              |  7 ++--
 src/openvpn/fragment.c                             |  7 ++--
 src/openvpn/fragment.h                             |  7 ++--
 src/openvpn/gremlin.c                              |  7 ++--
 src/openvpn/gremlin.h                              |  7 ++--
 src/openvpn/helper.c                               |  7 ++--
 src/openvpn/helper.h                               |  7 ++--
 src/openvpn/httpdigest.c                           |  7 ++--
 src/openvpn/httpdigest.h                           |  7 ++--
 src/openvpn/init.c                                 |  7 ++--
 src/openvpn/init.h                                 |  7 ++--
 src/openvpn/integer.h                              |  7 ++--
 src/openvpn/interval.c                             |  7 ++--
 src/openvpn/interval.h                             |  7 ++--
 src/openvpn/list.c                                 |  7 ++--
 src/openvpn/list.h                                 |  7 ++--
 src/openvpn/lzo.c                                  |  7 ++--
 src/openvpn/lzo.h                                  |  7 ++--
 src/openvpn/manage.c                               |  7 ++--
 src/openvpn/manage.h                               |  7 ++--
 src/openvpn/mbuf.c                                 |  7 ++--
 src/openvpn/mbuf.h                                 |  7 ++--
 src/openvpn/memdbg.h                               |  7 ++--
 src/openvpn/misc.c                                 |  7 ++--
 src/openvpn/misc.h                                 |  7 ++--
 src/openvpn/mroute.c                               |  7 ++--
 src/openvpn/mroute.h                               |  7 ++--
 src/openvpn/mss.c                                  |  7 ++--
 src/openvpn/mss.h                                  |  7 ++--
 src/openvpn/mstats.c                               |  7 ++--
 src/openvpn/mstats.h                               |  7 ++--
 src/openvpn/mtcp.c                                 |  7 ++--
 src/openvpn/mtcp.h                                 |  7 ++--
 src/openvpn/mtu.c                                  |  7 ++--
 src/openvpn/mtu.h                                  |  7 ++--
 src/openvpn/mudp.c                                 |  7 ++--
 src/openvpn/mudp.h                                 |  7 ++--
 src/openvpn/multi.c                                |  7 ++--
 src/openvpn/multi.h                                |  7 ++--
 src/openvpn/ntlm.c                                 |  7 ++--
 src/openvpn/occ-inline.h                           |  7 ++--
 src/openvpn/occ.c                                  |  7 ++--
 src/openvpn/occ.h                                  |  7 ++--
 src/openvpn/openssl_compat.h                       |  7 ++--
 src/openvpn/openvpn.c                              |  7 ++--
 src/openvpn/openvpn.h                              |  7 ++--
 src/openvpn/options.c                              |  7 ++--
 src/openvpn/options.h                              |  7 ++--
 src/openvpn/otime.c                                |  7 ++--
 src/openvpn/otime.h                                |  7 ++--
 src/openvpn/packet_id.c                            |  7 ++--
 src/openvpn/packet_id.h                            |  7 ++--
 src/openvpn/perf.c                                 |  7 ++--
 src/openvpn/perf.h                                 |  7 ++--
 src/openvpn/pf-inline.h                            |  7 ++--
 src/openvpn/pf.c                                   |  7 ++--
 src/openvpn/pf.h                                   |  7 ++--
 src/openvpn/ping-inline.h                          |  7 ++--
 src/openvpn/ping.c                                 |  7 ++--
 src/openvpn/ping.h                                 |  7 ++--
 src/openvpn/pkcs11.c                               |  7 ++--
 src/openvpn/pkcs11.h                               |  7 ++--
 src/openvpn/pkcs11_backend.h                       |  7 ++--
 src/openvpn/pkcs11_mbedtls.c                       |  7 ++--
 src/openvpn/pkcs11_openssl.c                       |  7 ++--
 src/openvpn/platform.c                             |  7 ++--
 src/openvpn/platform.h                             |  7 ++--
 src/openvpn/plugin.c                               |  7 ++--
 src/openvpn/plugin.h                               |  7 ++--
 src/openvpn/pool.c                                 |  7 ++--
 src/openvpn/pool.h                                 |  7 ++--
 src/openvpn/proto.c                                |  7 ++--
 src/openvpn/proto.h                                |  7 ++--
 src/openvpn/proxy.c                                |  7 ++--
 src/openvpn/proxy.h                                |  7 ++--
 src/openvpn/ps.c                                   |  7 ++--
 src/openvpn/ps.h                                   |  7 ++--
 src/openvpn/push.c                                 |  7 ++--
 src/openvpn/push.h                                 |  7 ++--
 src/openvpn/pushlist.h                             |  7 ++--
 src/openvpn/reliable.c                             |  7 ++--
 src/openvpn/reliable.h                             |  7 ++--
 src/openvpn/route.c                                |  7 ++--
 src/openvpn/route.h                                |  7 ++--
 src/openvpn/schedule.c                             |  7 ++--
 src/openvpn/schedule.h                             |  7 ++--
 src/openvpn/session_id.c                           |  7 ++--
 src/openvpn/session_id.h                           |  7 ++--
 src/openvpn/shaper.c                               |  7 ++--
 src/openvpn/shaper.h                               |  7 ++--
 src/openvpn/sig.c                                  |  7 ++--
 src/openvpn/sig.h                                  |  7 ++--
 src/openvpn/socket.c                               |  7 ++--
 src/openvpn/socket.h                               |  7 ++--
 src/openvpn/socks.c                                |  7 ++--
 src/openvpn/socks.h                                |  7 ++--
 src/openvpn/ssl.c                                  |  7 ++--
 src/openvpn/ssl.h                                  |  7 ++--
 src/openvpn/ssl_backend.h                          |  7 ++--
 src/openvpn/ssl_common.h                           |  7 ++--
 src/openvpn/ssl_mbedtls.c                          |  7 ++--
 src/openvpn/ssl_mbedtls.h                          |  7 ++--
 src/openvpn/ssl_openssl.c                          |  7 ++--
 src/openvpn/ssl_openssl.h                          |  7 ++--
 src/openvpn/ssl_verify.c                           |  7 ++--
 src/openvpn/ssl_verify.h                           |  7 ++--
 src/openvpn/ssl_verify_backend.h                   |  7 ++--
 src/openvpn/ssl_verify_mbedtls.c                   |  7 ++--
 src/openvpn/ssl_verify_mbedtls.h                   |  7 ++--
 src/openvpn/ssl_verify_openssl.c                   |  7 ++--
 src/openvpn/ssl_verify_openssl.h                   |  7 ++--
 src/openvpn/status.c                               |  7 ++--
 src/openvpn/status.h                               |  7 ++--
 src/openvpn/syshead.h                              |  7 ++--
 src/openvpn/tls_crypt.c                            |  7 ++--
 src/openvpn/tls_crypt.h                            |  7 ++--
 src/openvpn/tun.c                                  |  7 ++--
 src/openvpn/tun.h                                  |  7 ++--
 src/openvpn/win32.c                                |  7 ++--
 src/openvpn/win32.h                                |  7 ++--
 src/openvpnserv/automatic.c                        |  7 ++--
 src/openvpnserv/common.c                           |  7 ++--
 src/openvpnserv/interactive.c                      |  7 ++--
 src/openvpnserv/service.h                          |  7 ++--
 src/openvpnserv/validate.c                         |  7 ++--
 src/openvpnserv/validate.h                         |  7 ++--
 src/plugins/auth-pam/auth-pam.c                    |  7 ++--
 src/plugins/auth-pam/utils.c                       |  7 ++--
 src/plugins/auth-pam/utils.h                       |  7 ++--
 src/plugins/down-root/down-root.c                  |  7 ++--
 tests/unit_tests/openvpn/mock_msg.c                |  7 ++--
 tests/unit_tests/openvpn/mock_msg.h                |  7 ++--
 tests/unit_tests/openvpn/test_buffer.c             |  7 ++--
 tests/unit_tests/openvpn/test_tls_crypt.c          |  7 ++--
 214 files changed, 659 insertions(+), 872 deletions(-)

diff --git a/COPYRIGHT.GPL b/COPYRIGHT.GPL
index ff8a7f0..2a591d0 100644
--- a/COPYRIGHT.GPL
+++ b/COPYRIGHT.GPL
@@ -1,12 +1,12 @@
-		    GNU GENERAL PUBLIC LICENSE
-		       Version 2, June 1991
+                    GNU GENERAL PUBLIC LICENSE
+                       Version 2, June 1991
 
- Copyright (C) 1989, 1991 Free Software Foundation, Inc.
-                       59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ Copyright (C) 1989, 1991 Free Software Foundation, Inc.,
+ 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
-			    Preamble
+                            Preamble
 
   The licenses for most software are designed to take away your
 freedom to share and change it.  By contrast, the GNU General Public
@@ -15,7 +15,7 @@ software--to make sure the software is free for all its users.  This
 General Public License applies to most of the Free Software
 Foundation's software and to any other program whose authors commit to
 using it.  (Some other Free Software Foundation software is covered by
-the GNU Library General Public License instead.)  You can apply it to
+the GNU Lesser General Public License instead.)  You can apply it to
 your programs, too.
 
   When we speak of free software, we are referring to freedom, not
@@ -55,8 +55,8 @@ patent must be licensed for everyone's free use or not licensed at all.
 
   The precise terms and conditions for copying, distribution and
 modification follow.
-
-		    GNU GENERAL PUBLIC LICENSE
+
+                    GNU GENERAL PUBLIC LICENSE
    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 
   0. This License applies to any program or other work which contains
@@ -110,7 +110,7 @@ above, provided that you also meet all of these conditions:
     License.  (Exception: if the Program itself is interactive but
     does not normally print such an announcement, your work based on
     the Program is not required to print an announcement.)
-
+
 These requirements apply to the modified work as a whole.  If
 identifiable sections of that work are not derived from the Program,
 and can be reasonably considered independent and separate works in
@@ -168,7 +168,7 @@ access to copy from a designated place, then offering equivalent
 access to copy the source code from the same place counts as
 distribution of the source code, even though third parties are not
 compelled to copy the source along with the object code.
-
+
   4. You may not copy, modify, sublicense, or distribute the Program
 except as expressly provided under this License.  Any attempt
 otherwise to copy, modify, sublicense or distribute the Program is
@@ -225,7 +225,7 @@ impose that choice.
 
 This section is intended to make thoroughly clear what is believed to
 be a consequence of the rest of this License.
-
+
   8. If the distribution and/or use of the Program is restricted in
 certain countries either by patents or by copyrighted interfaces, the
 original copyright holder who places the Program under this License
@@ -255,7 +255,7 @@ make exceptions for this.  Our decision will be guided by the two goals
 of preserving the free status of all derivatives of our free software and
 of promoting the sharing and reuse of software generally.
 
-			    NO WARRANTY
+                            NO WARRANTY
 
   11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
 FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
@@ -277,9 +277,9 @@ YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
 PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGES.
 
-		     END OF TERMS AND CONDITIONS
-
-	    How to Apply These Terms to Your New Programs
+                     END OF TERMS AND CONDITIONS
+
+            How to Apply These Terms to Your New Programs
 
   If you develop a new program, and you want it to be of the greatest
 possible use to the public, the best way to achieve this is to make it
@@ -302,10 +302,9 @@ the "copyright" line and a pointer to where the full notice is found.
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
 
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-
+    You should have received a copy of the GNU General Public License along
+    with this program; if not, write to the Free Software Foundation, Inc.,
+    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 Also add information on how to contact you by electronic and paper mail.
 
@@ -335,5 +334,5 @@ necessary.  Here is a sample; alter the names:
 This General Public License does not permit incorporating your program into
 proprietary programs.  If your program is a subroutine library, you may
 consider it more useful to permit linking proprietary applications with the
-library.  If this is what you want to do, use the GNU Library General
+library.  If this is what you want to do, use the GNU Lesser General
 Public License instead of this License.
diff --git a/Makefile.am b/Makefile.am
index 1197aad..87da182 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -18,10 +18,9 @@
 #  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 #  GNU General Public License for more details.
 #
-#  You should have received a copy of the GNU General Public License
-#  along with this program (see the file COPYING included with this
-#  distribution); if not, write to the Free Software Foundation, Inc.,
-#  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+#  You should have received a copy of the GNU General Public License along
+#  with this program; if not, write to the Free Software Foundation, Inc.,
+#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 #
 
 # This option prevents autoreconf from overriding our COPYING and
diff --git a/compat.m4 b/compat.m4
index 4c13254..e54a720 100644
--- a/compat.m4
+++ b/compat.m4
@@ -16,10 +16,9 @@ dnl  but WITHOUT ANY WARRANTY; without even the implied warranty of
 dnl  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 dnl  GNU General Public License for more details.
 dnl
-dnl  You should have received a copy of the GNU General Public License
-dnl  along with this program (see the file COPYING included with this
-dnl  distribution); if not, write to the Free Software Foundation, Inc.,
-dnl  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+dnl  You should have received a copy of the GNU General Public License along
+dnl  with this program; if not, write to the Free Software Foundation, Inc.,
+dnl  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 dnl Compatibility layer for <autoconf-2.60 <automake-1.10
 dnl REMOVE THIS IN FUTURE!
diff --git a/configure.ac b/configure.ac
index 2406ad8..a587877 100644
--- a/configure.ac
+++ b/configure.ac
@@ -17,10 +17,9 @@ dnl  but WITHOUT ANY WARRANTY; without even the implied warranty of
 dnl  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 dnl  GNU General Public License for more details.
 dnl
-dnl  You should have received a copy of the GNU General Public License
-dnl  along with this program (see the file COPYING included with this
-dnl  distribution); if not, write to the Free Software Foundation, Inc.,
-dnl  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+dnl  You should have received a copy of the GNU General Public License along
+dnl  with this program; if not, write to the Free Software Foundation, Inc.,
+dnl  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 dnl Process this file with autoconf to produce a configure script.
 
diff --git a/contrib/keychain-mcd/cert_data.c b/contrib/keychain-mcd/cert_data.c
index b84f3fc..c04f68e 100644
--- a/contrib/keychain-mcd/cert_data.c
+++ b/contrib/keychain-mcd/cert_data.c
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 
diff --git a/contrib/keychain-mcd/cert_data.h b/contrib/keychain-mcd/cert_data.h
index c5f83c0..c01251f 100644
--- a/contrib/keychain-mcd/cert_data.h
+++ b/contrib/keychain-mcd/cert_data.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 #ifndef __cert_data_h__
 #define __cert_data_h__
diff --git a/contrib/keychain-mcd/common_osx.c b/contrib/keychain-mcd/common_osx.c
index 0f7c4ae..f817814 100644
--- a/contrib/keychain-mcd/common_osx.c
+++ b/contrib/keychain-mcd/common_osx.c
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/contrib/keychain-mcd/common_osx.h b/contrib/keychain-mcd/common_osx.h
index 965d4fa..d37e059 100644
--- a/contrib/keychain-mcd/common_osx.h
+++ b/contrib/keychain-mcd/common_osx.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef __common_osx_h__
diff --git a/contrib/keychain-mcd/crypto_osx.c b/contrib/keychain-mcd/crypto_osx.c
index 092e64f..27ac4f5 100644
--- a/contrib/keychain-mcd/crypto_osx.c
+++ b/contrib/keychain-mcd/crypto_osx.c
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 
diff --git a/contrib/keychain-mcd/crypto_osx.h b/contrib/keychain-mcd/crypto_osx.h
index 115ec18..9f4b3f9 100644
--- a/contrib/keychain-mcd/crypto_osx.h
+++ b/contrib/keychain-mcd/crypto_osx.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef __crypto_osx_h__
diff --git a/contrib/keychain-mcd/main.c b/contrib/keychain-mcd/main.c
index 7d8fc83..c1d091e 100644
--- a/contrib/keychain-mcd/main.c
+++ b/contrib/keychain-mcd/main.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 
diff --git a/doc/doxygen/doc_compression.h b/doc/doxygen/doc_compression.h
index 3213164..beb8c74 100644
--- a/doc/doxygen/doc_compression.h
+++ b/doc/doxygen/doc_compression.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/doc/doxygen/doc_control_processor.h b/doc/doxygen/doc_control_processor.h
index 797bf0f..59ace2c 100644
--- a/doc/doxygen/doc_control_processor.h
+++ b/doc/doxygen/doc_control_processor.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/doc/doxygen/doc_control_tls.h b/doc/doxygen/doc_control_tls.h
index fc5c96a..e854fc6 100644
--- a/doc/doxygen/doc_control_tls.h
+++ b/doc/doxygen/doc_control_tls.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/doc/doxygen/doc_data_control.h b/doc/doxygen/doc_data_control.h
index c527f70..f9bd8d0 100644
--- a/doc/doxygen/doc_data_control.h
+++ b/doc/doxygen/doc_data_control.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/doc/doxygen/doc_data_crypto.h b/doc/doxygen/doc_data_crypto.h
index 571171e..925fcd5 100644
--- a/doc/doxygen/doc_data_crypto.h
+++ b/doc/doxygen/doc_data_crypto.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/doc/doxygen/doc_eventloop.h b/doc/doxygen/doc_eventloop.h
index 10d41c4..b93c2a9 100644
--- a/doc/doxygen/doc_eventloop.h
+++ b/doc/doxygen/doc_eventloop.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/doc/doxygen/doc_external_multiplexer.h b/doc/doxygen/doc_external_multiplexer.h
index bc64c33..b69d7eb 100644
--- a/doc/doxygen/doc_external_multiplexer.h
+++ b/doc/doxygen/doc_external_multiplexer.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/doc/doxygen/doc_fragmentation.h b/doc/doxygen/doc_fragmentation.h
index 34d73d6..26f6be9 100644
--- a/doc/doxygen/doc_fragmentation.h
+++ b/doc/doxygen/doc_fragmentation.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/doc/doxygen/doc_internal_multiplexer.h b/doc/doxygen/doc_internal_multiplexer.h
index d38231b..da872e5 100644
--- a/doc/doxygen/doc_internal_multiplexer.h
+++ b/doc/doxygen/doc_internal_multiplexer.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/doc/doxygen/doc_key_generation.h b/doc/doxygen/doc_key_generation.h
index 43ca150..4b225e0 100644
--- a/doc/doxygen/doc_key_generation.h
+++ b/doc/doxygen/doc_key_generation.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/doc/doxygen/doc_mainpage.h b/doc/doxygen/doc_mainpage.h
index 685e0b9..645561e 100644
--- a/doc/doxygen/doc_mainpage.h
+++ b/doc/doxygen/doc_mainpage.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/doc/doxygen/doc_memory_management.h b/doc/doxygen/doc_memory_management.h
index 0e85d93..451c9d6 100644
--- a/doc/doxygen/doc_memory_management.h
+++ b/doc/doxygen/doc_memory_management.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/doc/doxygen/doc_protocol_overview.h b/doc/doxygen/doc_protocol_overview.h
index 46d2e12..6ac5d9f 100644
--- a/doc/doxygen/doc_protocol_overview.h
+++ b/doc/doxygen/doc_protocol_overview.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/doc/doxygen/doc_reliable.h b/doc/doxygen/doc_reliable.h
index a6d8f2f..0a8f1ec 100644
--- a/doc/doxygen/doc_reliable.h
+++ b/doc/doxygen/doc_reliable.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/doc/doxygen/doc_tunnel_state.h b/doc/doxygen/doc_tunnel_state.h
index 4433dbe..7560672 100644
--- a/doc/doxygen/doc_tunnel_state.h
+++ b/doc/doxygen/doc_tunnel_state.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index f29b72f..321b016 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -15,10 +15,9 @@
 .\"  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 .\"  GNU General Public License for more details.
 .\"
-.\"  You should have received a copy of the GNU General Public License
-.\"  along with this program (see the file COPYING included with this
-.\"  distribution); if not, write to the Free Software Foundation, Inc.,
-.\"  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+.\"  You should have received a copy of the GNU General Public License along
+.\"  with this program; if not, write to the Free Software Foundation, Inc.,
+.\"  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 .\"
 .\" Manual page for openvpn
 .\"
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index 5f3c96c..91e0ccc 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef OPENVPN_MSG_H_
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index 0b30352..6b24b87 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef OPENVPN_PLUGIN_H_
diff --git a/m4/pkg.m4 b/m4/pkg.m4
index 9a71878..12d2a58 100644
--- a/m4/pkg.m4
+++ b/m4/pkg.m4
@@ -13,9 +13,9 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 # General Public License for more details.
 #
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 #
 # As a special exception to the GNU General Public License, if you
 # distribute this file as part of a program that contains a
diff --git a/sample/sample-plugins/defer/simple.c b/sample/sample-plugins/defer/simple.c
index ad1bbb0..4960497 100644
--- a/sample/sample-plugins/defer/simple.c
+++ b/sample/sample-plugins/defer/simple.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
index 177977d..226eea6 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/sample/sample-plugins/log/log.c b/sample/sample-plugins/log/log.c
index 0201628..c59027f 100644
--- a/sample/sample-plugins/log/log.c
+++ b/sample/sample-plugins/log/log.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
index 9037225..8b537dd 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/sample/sample-plugins/simple/simple.c b/sample/sample-plugins/simple/simple.c
index f595333..0a05240 100644
--- a/sample/sample-plugins/simple/simple.c
+++ b/sample/sample-plugins/simple/simple.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/compat/compat-basename.c b/src/compat/compat-basename.c
index b7b5c43..e66e225 100644
--- a/src/compat/compat-basename.c
+++ b/src/compat/compat-basename.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/compat/compat-daemon.c b/src/compat/compat-daemon.c
index b54e813..4ef28fa 100644
--- a/src/compat/compat-daemon.c
+++ b/src/compat/compat-daemon.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/compat/compat-dirname.c b/src/compat/compat-dirname.c
index 7747dbd..c1523d9 100644
--- a/src/compat/compat-dirname.c
+++ b/src/compat/compat-dirname.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/compat/compat-gettimeofday.c b/src/compat/compat-gettimeofday.c
index d53e360..fb57f2d 100644
--- a/src/compat/compat-gettimeofday.c
+++ b/src/compat/compat-gettimeofday.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/compat/compat-inet_ntop.c b/src/compat/compat-inet_ntop.c
index 07d0dde..f2a181e 100644
--- a/src/compat/compat-inet_ntop.c
+++ b/src/compat/compat-inet_ntop.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/compat/compat-inet_pton.c b/src/compat/compat-inet_pton.c
index 170e294..9d451cc 100644
--- a/src/compat/compat-inet_pton.c
+++ b/src/compat/compat-inet_pton.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/compat/compat.h b/src/compat/compat.h
index 75bfaed..d522898 100644
--- a/src/compat/compat.h
+++ b/src/compat/compat.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef COMPAT_H
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 59caa6f..a71d261 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  *
  *
  *  A printf-like function (that only recognizes a subset of standard printf
diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
index 1dd6dd7..7d0754c 100644
--- a/src/openvpn/argv.h
+++ b/src/openvpn/argv.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  *
  *
  *  A printf-like function (that only recognizes a subset of standard printf
diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h
index dac6f01..3aa69ca 100644
--- a/src/openvpn/basic.h
+++ b/src/openvpn/basic.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef BASIC_H
diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c
index e31765e..6ed5fc0 100644
--- a/src/openvpn/block_dns.c
+++ b/src/openvpn/block_dns.c
@@ -18,10 +18,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/block_dns.h b/src/openvpn/block_dns.h
index a7dadc4..64028d3 100644
--- a/src/openvpn/block_dns.h
+++ b/src/openvpn/block_dns.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef _WIN32
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 7e46387..87e27ec 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 59d12ab..8bc4428 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef BUFFER_H
diff --git a/src/openvpn/circ_list.h b/src/openvpn/circ_list.h
index ecf2a7f..386e18d 100644
--- a/src/openvpn/circ_list.h
+++ b/src/openvpn/circ_list.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef CIRC_LIST_H
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index 9158437..633cec6 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
index cdaf2a8..e0cfad5 100644
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #if !defined(CLINAT_H)
diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index cd988d4..bb08c01 100644
--- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef COMMON_H
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index e1f83e7..6e40c32 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/comp-lz4.h b/src/openvpn/comp-lz4.h
index 8621e93..c256ba5 100644
--- a/src/openvpn/comp-lz4.h
+++ b/src/openvpn/comp-lz4.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef OPENVPN_COMP_LZ4_H
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 0182a7c..4cda7e5 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 3c0b18e..e56fd2b 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/compstub.c b/src/openvpn/compstub.c
index dd9c175..ca90924 100644
--- a/src/openvpn/compstub.c
+++ b/src/openvpn/compstub.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index 2c418ac..eb6944d 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -18,10 +18,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 2c7f3e9..7e5c96d 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -18,11 +18,10 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA. 
+*/
 
 #ifndef CONSOLE_H
 #define CONSOLE_H
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 13b9d7e..7b95da9 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -18,10 +18,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
index 1c0aa4c..8cee8c8 100644
--- a/src/openvpn/console_systemd.c
+++ b/src/openvpn/console_systemd.c
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 909f725..1bfce00 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index afd6fe5..8e2f2b1 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 2c79baa..45f1741 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 942684c..e6388dd 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index da2db16..a434ce3 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 881a2d1..ee20902 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index f8ddbc8..60a2812 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index 4ffa9d6..a2a5454 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/dhcp.h b/src/openvpn/dhcp.h
index d406870..dc41658 100644
--- a/src/openvpn/dhcp.h
+++ b/src/openvpn/dhcp.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef DHCP_H
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index c4dd518..5bb043b 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef ERRLEVEL_H
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index dbff81d..ce50ff9 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index c86b956..14ef7e6 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef ERROR_H
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index e77bc4c..d123070 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index 6a6e029..ff795f4 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef EVENT_H
diff --git a/src/openvpn/fdmisc.c b/src/openvpn/fdmisc.c
index 401069d..56e2250 100644
--- a/src/openvpn/fdmisc.c
+++ b/src/openvpn/fdmisc.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/fdmisc.h b/src/openvpn/fdmisc.h
index 1e84a08..b6d7101 100644
--- a/src/openvpn/fdmisc.h
+++ b/src/openvpn/fdmisc.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef FD_MISC_H
diff --git a/src/openvpn/forward-inline.h b/src/openvpn/forward-inline.h
index 97e1cd6..ab83ea4 100644
--- a/src/openvpn/forward-inline.h
+++ b/src/openvpn/forward-inline.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef FORWARD_INLINE_H
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 8102e94..f8f01d6 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index ae86e7a..9fde5a3 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 
diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index c504a4f..38de62f 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/fragment.h b/src/openvpn/fragment.h
index a24b524..90ba8f7 100644
--- a/src/openvpn/fragment.h
+++ b/src/openvpn/fragment.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef FRAGMENT_H
diff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin.c
index b077ae3..e85ce9c 100644
--- a/src/openvpn/gremlin.c
+++ b/src/openvpn/gremlin.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/gremlin.h b/src/openvpn/gremlin.h
index 8f41864..8b23b34 100644
--- a/src/openvpn/gremlin.h
+++ b/src/openvpn/gremlin.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef GREMLIN_H
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index adcc4f8..17d1528 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/helper.h b/src/openvpn/helper.h
index 593d1ed..c5b438b 100644
--- a/src/openvpn/helper.h
+++ b/src/openvpn/helper.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index ae4a638..e578c85 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/httpdigest.h b/src/openvpn/httpdigest.h
index b074fb2..aae7b8c 100644
--- a/src/openvpn/httpdigest.h
+++ b/src/openvpn/httpdigest.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #if PROXY_DIGEST_AUTH
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 0b74f25..edaf17c 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 3b97d84..15feb67 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef INIT_H
diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index bae8f16..240781b 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef INTEGER_H
diff --git a/src/openvpn/interval.c b/src/openvpn/interval.c
index 99e72a0..1634386 100644
--- a/src/openvpn/interval.c
+++ b/src/openvpn/interval.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/interval.h b/src/openvpn/interval.h
index e87d751..8095c0b 100644
--- a/src/openvpn/interval.h
+++ b/src/openvpn/interval.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index d08b599..edca6f7 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index 6270f88..c808efa 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef LIST_H
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index 155507d..f754865 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h
index 85937b2..deaeb8d 100644
--- a/src/openvpn/lzo.h
+++ b/src/openvpn/lzo.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef OPENVPN_LZO_H
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 58b65c2..c2e8dc7 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 6e5cb9b..542cc07 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef MANAGE_H
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index ceee0fd..fafbce0 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/mbuf.h b/src/openvpn/mbuf.h
index cfaef58..e0643de 100644
--- a/src/openvpn/mbuf.h
+++ b/src/openvpn/mbuf.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef MBUF_H
diff --git a/src/openvpn/memdbg.h b/src/openvpn/memdbg.h
index ee30b15..0ba695f 100644
--- a/src/openvpn/memdbg.h
+++ b/src/openvpn/memdbg.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef MEMDBG_H
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 68d0687..d286c19 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -18,10 +18,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 009767f..94573b2 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef MISC_H
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 33c2ef4..7b46a6a 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 0698348..e57a950 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef MROUTE_H
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 51e1ae0..ff24068 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h
index afe7a32..0de2042 100644
--- a/src/openvpn/mss.h
+++ b/src/openvpn/mss.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef MSS_H
diff --git a/src/openvpn/mstats.c b/src/openvpn/mstats.c
index 8ab1d02..9b09188 100644
--- a/src/openvpn/mstats.c
+++ b/src/openvpn/mstats.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/mstats.h b/src/openvpn/mstats.h
index f87a858..486035f 100644
--- a/src/openvpn/mstats.h
+++ b/src/openvpn/mstats.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 195d08d..cb940d8 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index 835b8fd..79dcb13 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 73eab21..44bef68 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 471e51e..d1e8c18 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef MTU_H
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 64ce4d7..793678d 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index a98d64d..b9ceaf7 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 56009b7..8d3d67f 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index b4ffd69..63afbaf 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 0c43681..4750bcf 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -15,10 +15,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/occ-inline.h b/src/openvpn/occ-inline.h
index 84fe1ac..68e9098 100644
--- a/src/openvpn/occ-inline.h
+++ b/src/openvpn/occ-inline.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef OCC_INLINE_H
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index e720f6c..40f7e76 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
index 843ceb2..12d7bc5 100644
--- a/src/openvpn/occ.h
+++ b/src/openvpn/occ.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef OCC_H
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 92f014d..811d559 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 3cb33b6..08c09e6 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 893296e..49e01a8 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef OPENVPN_H
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index dcb6ecf..c469403 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index dc63aed..e1d54c6 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index 22abda0..3e576cc 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index ad066b6..8731472 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef OTIME_H
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index e34c228..d767cdb 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index ecc25a6..b3b2098 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/perf.c b/src/openvpn/perf.c
index 3603f4e..16cf749 100644
--- a/src/openvpn/perf.c
+++ b/src/openvpn/perf.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/perf.h b/src/openvpn/perf.h
index a670843..ae5ae08 100644
--- a/src/openvpn/perf.h
+++ b/src/openvpn/perf.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/pf-inline.h b/src/openvpn/pf-inline.h
index a0f5cc7..ac19ac4 100644
--- a/src/openvpn/pf-inline.h
+++ b/src/openvpn/pf-inline.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #if defined(ENABLE_PF) && !defined(PF_INLINE_H)
diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
index 56b6858..5cb002b 100644
--- a/src/openvpn/pf.c
+++ b/src/openvpn/pf.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /* packet filter functions */
diff --git a/src/openvpn/pf.h b/src/openvpn/pf.h
index 3832683..414c85b 100644
--- a/src/openvpn/pf.h
+++ b/src/openvpn/pf.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /* packet filter functions */
diff --git a/src/openvpn/ping-inline.h b/src/openvpn/ping-inline.h
index 2fa1d5c..0642b85 100644
--- a/src/openvpn/ping-inline.h
+++ b/src/openvpn/ping-inline.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef PING_INLINE_H
diff --git a/src/openvpn/ping.c b/src/openvpn/ping.c
index 0496b72..728d6c2 100644
--- a/src/openvpn/ping.c
+++ b/src/openvpn/ping.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/ping.h b/src/openvpn/ping.h
index e839ce7..5bd5c08 100644
--- a/src/openvpn/ping.h
+++ b/src/openvpn/ping.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef PING_H
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 3e494e5..6041828 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/pkcs11.h b/src/openvpn/pkcs11.h
index 3747d3a..f1722c0 100644
--- a/src/openvpn/pkcs11.h
+++ b/src/openvpn/pkcs11.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef OPENVPN_PKCS11_H
diff --git a/src/openvpn/pkcs11_backend.h b/src/openvpn/pkcs11_backend.h
index 9606899..b47b757 100644
--- a/src/openvpn/pkcs11_backend.h
+++ b/src/openvpn/pkcs11_backend.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c
index bdca893..6361be1 100644
--- a/src/openvpn/pkcs11_mbedtls.c
+++ b/src/openvpn/pkcs11_mbedtls.c
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index 6244cc7..c37425b 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 952d633..2495523 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index 62396a9..cd2bbc9 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef PLATFORM_H
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 05cbae3..75cc8cd 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index 4ded529..0cffee0 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 9543a9d..a8f15b9 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/pool.h b/src/openvpn/pool.h
index c3e1190..ee91d82 100644
--- a/src/openvpn/pool.h
+++ b/src/openvpn/pool.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef POOL_H
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index 40e0714..2cbea3a 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index bfcb36d..57f25c9 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef PROTO_H
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index b0ed327..4b2df8c 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index c20a676..3ce79de 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef PROXY_H
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 21b12ca..c2b05cd 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/ps.h b/src/openvpn/ps.h
index 0fc1ee4..b8c6853 100644
--- a/src/openvpn/ps.h
+++ b/src/openvpn/ps.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef PS_H
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 8c3104e..620dc6e 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 86900c8..4d42e81 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef PUSH_H
diff --git a/src/openvpn/pushlist.h b/src/openvpn/pushlist.h
index 58fc870..57216b2 100644
--- a/src/openvpn/pushlist.h
+++ b/src/openvpn/pushlist.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #if !defined(PUSHLIST_H) && P2MP && P2MP_SERVER
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 9de974b..93541a9 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 455168a..aa34b02 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 08998d5..c0af249 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index d6836ab..6414d6c 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
index 8a9eb3f..b1ba5d4 100644
--- a/src/openvpn/schedule.c
+++ b/src/openvpn/schedule.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/schedule.h b/src/openvpn/schedule.h
index f2a6813..e6c1b7e 100644
--- a/src/openvpn/schedule.h
+++ b/src/openvpn/schedule.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef SCHEDULE_H
diff --git a/src/openvpn/session_id.c b/src/openvpn/session_id.c
index 04caf39..dce42e7 100644
--- a/src/openvpn/session_id.c
+++ b/src/openvpn/session_id.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/session_id.h b/src/openvpn/session_id.h
index 2b0ceb8..6611a3c 100644
--- a/src/openvpn/session_id.h
+++ b/src/openvpn/session_id.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/shaper.c b/src/openvpn/shaper.c
index bb936ac..19dd54d 100644
--- a/src/openvpn/shaper.c
+++ b/src/openvpn/shaper.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/shaper.h b/src/openvpn/shaper.h
index d97221a..6fac16d 100644
--- a/src/openvpn/shaper.h
+++ b/src/openvpn/shaper.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef SHAPER_H
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 9f4841a..87cef71 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
index 5783731..7c41070 100644
--- a/src/openvpn/sig.h
+++ b/src/openvpn/sig.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef SIG_H
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 7d3dd60..4e7e3f9 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 3d96aab..2d7f218 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef SOCKET_H
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index b50cac3..92747ec 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
index 17e75e1..39b96c5 100644
--- a/src/openvpn/socks.h
+++ b/src/openvpn/socks.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index fca1e7c..15c22c9 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -18,10 +18,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index ed1344e..49f1b09 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 206400f..a738f0f 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 9a16d77..145025b 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index ba8dadf..ef583e6 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -18,10 +18,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index d8f717c..f69b610 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index d7cc2ba..91035f0 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index 6ca4cb6..db4e1da 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index a6e9be3..cbbad0d 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 278c5cb..f2d0d6c 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index c4330ba..3566053 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index c32e481..d80b7a5 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/ssl_verify_mbedtls.h b/src/openvpn/ssl_verify_mbedtls.h
index 3c71073..8b0a5ae 100644
--- a/src/openvpn/ssl_verify_mbedtls.h
+++ b/src/openvpn/ssl_verify_mbedtls.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 5624daa..448575e 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/ssl_verify_openssl.h b/src/openvpn/ssl_verify_openssl.h
index 1db6fe6..4c8dbeb 100644
--- a/src/openvpn/ssl_verify_openssl.h
+++ b/src/openvpn/ssl_verify_openssl.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index e47f35c..a163408 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/status.h b/src/openvpn/status.h
index 590ae41..8199935 100644
--- a/src/openvpn/status.h
+++ b/src/openvpn/status.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef STATUS_H
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index f445864..3b8b024 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef SYSHEAD_H
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index e2fdbed..10f978f 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
index 47f75d0..e8080df 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /**
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 3504fbf..98d063a 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index b39fe15..8782d69 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef TUN_H
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 18e7aee..28a04f4 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 4ee44fd..d492ccc 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef _WIN32
diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
index b9a377a..4123d0f 100644
--- a/src/openvpnserv/automatic.c
+++ b/src/openvpnserv/automatic.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index 3b9b396..0c9098f 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #include <service.h>
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 2bce598..36a7505 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index b1130c9..9fe573e 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef _SERVICE_H
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 894c51b..f6a97e9 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #include "validate.h"
diff --git a/src/openvpnserv/validate.h b/src/openvpnserv/validate.h
index 033e0e4..cc443e6 100644
--- a/src/openvpnserv/validate.h
+++ b/src/openvpnserv/validate.h
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef VALIDATE_H
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index d3e2c89..3df9899 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c
index 724a437..4b900c7 100644
--- a/src/plugins/auth-pam/utils.c
+++ b/src/plugins/auth-pam/utils.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/src/plugins/auth-pam/utils.h b/src/plugins/auth-pam/utils.h
index fbc9705..c0b4b10 100644
--- a/src/plugins/auth-pam/utils.h
+++ b/src/plugins/auth-pam/utils.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef _PLUGIN_AUTH_PAM_UTILS__H
diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
index ab6b483..4198184 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -17,10 +17,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c
index eb0d5e9..37e39e6 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/tests/unit_tests/openvpn/mock_msg.h b/tests/unit_tests/openvpn/mock_msg.h
index e0933c6..2f8c8bf 100644
--- a/tests/unit_tests/openvpn/mock_msg.h
+++ b/tests/unit_tests/openvpn/mock_msg.h
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef MOCK_MSG_H
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index 5158eb8..69bb2e5 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 7b014e0..ccc2801 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -16,10 +16,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifdef HAVE_CONFIG_H
-- 
2.11.0




