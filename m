From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 3 Aug 2025 14:59:12 +0000
In-Reply-To: <gerrit.1753966620000.Ic3959970fa9ab993e98d4b38c025fd0efc7b92f2@...2715...>
References: <gerrit.1753966620000.Ic3959970fa9ab993e98d4b38c025fd0efc7b92f2@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9758f902100d0f5c48ee345d0b147963080966c6-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E8vzTfyB2Fk="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Update GPL header in
 all source files to current recommended version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--E8vzTfyB2Fk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1124?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Update GPL header in all source files to current recommende=
d version
......................................................................

Update GPL header in all source files to current recommended version

This removes the postal address of the FSF and replaces
it with their URL.

Mostly generated with
sed -i -e 's@...2901... not, write to the Free Software Foundation, Inc.,\
            @if not, see <https://www.gnu.org/licenses/>.@'
sed -i -e '/51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA/d'
sed -i -e '/59 Temple Place, Suite 330, Boston, MA  02111-1307  USA/d'

With some manual fix-ups afterwards.

Change-Id: Ic3959970fa9ab993e98d4b38c025fd0efc7b92f2
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250803145126.23494-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
481.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M Makefile.am
M compat.m4
M configure.ac
M contrib/cmake/git-version.py
M contrib/cmake/parse-version.m4.py
M dev-tools/gen-release-tarballs.sh
M dev-tools/gerrit-send-mail.py
M dev-tools/reformat-all.sh
M dev-tools/update-copyright.sh
M doc/doxygen/doc_compression.h
M doc/doxygen/doc_control_processor.h
M doc/doxygen/doc_control_tls.h
M doc/doxygen/doc_data_control.h
M doc/doxygen/doc_data_crypto.h
M doc/doxygen/doc_eventloop.h
M doc/doxygen/doc_external_multiplexer.h
M doc/doxygen/doc_fragmentation.h
M doc/doxygen/doc_internal_multiplexer.h
M doc/doxygen/doc_key_generation.h
M doc/doxygen/doc_mainpage.h
M doc/doxygen/doc_memory_management.h
M doc/doxygen/doc_protocol_overview.h
M doc/doxygen/doc_reliable.h
M doc/doxygen/doc_tunnel_state.h
M include/openvpn-msg.h
M include/openvpn-plugin.h.in
M sample/sample-plugins/client-connect/sample-client-connect.c
M sample/sample-plugins/defer/multi-auth.c
M sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporte=
r.c
M sample/sample-plugins/log/log.c
M sample/sample-plugins/log/log_v3.c
M sample/sample-plugins/simple/base64.c
M sample/sample-plugins/simple/simple.c
M src/compat/compat-basename.c
M src/compat/compat-daemon.c
M src/compat/compat-dirname.c
M src/compat/compat-gettimeofday.c
M src/compat/compat-strsep.c
M src/compat/compat.h
M src/openvpn/argv.c
M src/openvpn/argv.h
M src/openvpn/auth_token.h
M src/openvpn/basic.h
M src/openvpn/buffer.c
M src/openvpn/buffer.h
M src/openvpn/circ_list.h
M src/openvpn/clinat.c
M src/openvpn/clinat.h
M src/openvpn/common.h
M src/openvpn/comp-lz4.c
M src/openvpn/comp-lz4.h
M src/openvpn/comp.c
M src/openvpn/comp.h
M src/openvpn/compstub.c
M src/openvpn/console.c
M src/openvpn/console.h
M src/openvpn/console_builtin.c
M src/openvpn/console_systemd.c
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/crypto_backend.h
M src/openvpn/crypto_epoch.c
M src/openvpn/crypto_epoch.h
M src/openvpn/crypto_mbedtls.c
M src/openvpn/crypto_mbedtls.h
M src/openvpn/crypto_openssl.c
M src/openvpn/crypto_openssl.h
M src/openvpn/dco.c
M src/openvpn/dco.h
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_freebsd.h
M src/openvpn/dco_internal.h
M src/openvpn/dco_linux.c
M src/openvpn/dco_linux.h
M src/openvpn/dco_win.c
M src/openvpn/dco_win.h
M src/openvpn/dhcp.c
M src/openvpn/dhcp.h
M src/openvpn/dns.c
M src/openvpn/dns.h
M src/openvpn/env_set.c
M src/openvpn/env_set.h
M src/openvpn/errlevel.h
M src/openvpn/error.c
M src/openvpn/error.h
M src/openvpn/event.c
M src/openvpn/event.h
M src/openvpn/fdmisc.c
M src/openvpn/fdmisc.h
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/fragment.c
M src/openvpn/fragment.h
M src/openvpn/gremlin.c
M src/openvpn/gremlin.h
M src/openvpn/helper.c
M src/openvpn/helper.h
M src/openvpn/httpdigest.c
M src/openvpn/httpdigest.h
M src/openvpn/init.c
M src/openvpn/init.h
M src/openvpn/integer.h
M src/openvpn/interval.c
M src/openvpn/interval.h
M src/openvpn/list.c
M src/openvpn/list.h
M src/openvpn/lzo.c
M src/openvpn/lzo.h
M src/openvpn/manage.c
M src/openvpn/manage.h
M src/openvpn/mbedtls_compat.h
M src/openvpn/mbuf.c
M src/openvpn/mbuf.h
M src/openvpn/memdbg.h
M src/openvpn/misc.c
M src/openvpn/misc.h
M src/openvpn/mroute.c
M src/openvpn/mroute.h
M src/openvpn/mss.c
M src/openvpn/mss.h
M src/openvpn/mstats.c
M src/openvpn/mstats.h
M src/openvpn/mtcp.c
M src/openvpn/mtcp.h
M src/openvpn/mtu.c
M src/openvpn/mtu.h
M src/openvpn/mudp.c
M src/openvpn/mudp.h
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/multi_io.c
M src/openvpn/multi_io.h
M src/openvpn/networking.h
M src/openvpn/networking_iproute2.c
M src/openvpn/networking_iproute2.h
M src/openvpn/networking_sitnl.c
M src/openvpn/networking_sitnl.h
M src/openvpn/ntlm.c
M src/openvpn/occ.c
M src/openvpn/occ.h
M src/openvpn/openssl_compat.h
M src/openvpn/openvpn.c
M src/openvpn/openvpn.h
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/options_util.c
M src/openvpn/options_util.h
M src/openvpn/otime.c
M src/openvpn/otime.h
M src/openvpn/ovpn_dco_win.h
M src/openvpn/packet_id.c
M src/openvpn/packet_id.h
M src/openvpn/perf.c
M src/openvpn/perf.h
M src/openvpn/ping.c
M src/openvpn/ping.h
M src/openvpn/pkcs11.c
M src/openvpn/pkcs11.h
M src/openvpn/pkcs11_backend.h
M src/openvpn/pkcs11_mbedtls.c
M src/openvpn/pkcs11_openssl.c
M src/openvpn/platform.c
M src/openvpn/platform.h
M src/openvpn/plugin.c
M src/openvpn/plugin.h
M src/openvpn/pool.c
M src/openvpn/pool.h
M src/openvpn/proto.c
M src/openvpn/proto.h
M src/openvpn/proxy.c
M src/openvpn/proxy.h
M src/openvpn/ps.c
M src/openvpn/ps.h
M src/openvpn/push.c
M src/openvpn/push.h
M src/openvpn/pushlist.h
M src/openvpn/reflect_filter.c
M src/openvpn/reflect_filter.h
M src/openvpn/reliable.c
M src/openvpn/reliable.h
M src/openvpn/route.c
M src/openvpn/route.h
M src/openvpn/run_command.c
M src/openvpn/run_command.h
M src/openvpn/schedule.c
M src/openvpn/schedule.h
M src/openvpn/session_id.c
M src/openvpn/session_id.h
M src/openvpn/shaper.c
M src/openvpn/shaper.h
M src/openvpn/sig.c
M src/openvpn/sig.h
M src/openvpn/socket.c
M src/openvpn/socket.h
M src/openvpn/socks.c
M src/openvpn/socks.h
M src/openvpn/ssl.c
M src/openvpn/ssl.h
M src/openvpn/ssl_backend.h
M src/openvpn/ssl_common.h
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_mbedtls.h
M src/openvpn/ssl_ncp.c
M src/openvpn/ssl_ncp.h
M src/openvpn/ssl_openssl.c
M src/openvpn/ssl_openssl.h
M src/openvpn/ssl_pkt.c
M src/openvpn/ssl_pkt.h
M src/openvpn/ssl_util.c
M src/openvpn/ssl_util.h
M src/openvpn/ssl_verify.c
M src/openvpn/ssl_verify.h
M src/openvpn/ssl_verify_backend.h
M src/openvpn/ssl_verify_mbedtls.c
M src/openvpn/ssl_verify_mbedtls.h
M src/openvpn/ssl_verify_openssl.c
M src/openvpn/ssl_verify_openssl.h
M src/openvpn/status.c
M src/openvpn/status.h
M src/openvpn/syshead.h
M src/openvpn/tls_crypt.c
M src/openvpn/tls_crypt.h
M src/openvpn/tun.c
M src/openvpn/tun.h
M src/openvpn/tun_afunix.c
M src/openvpn/tun_afunix.h
M src/openvpn/vlan.c
M src/openvpn/vlan.h
M src/openvpn/wfp_block.c
M src/openvpn/wfp_block.h
M src/openvpn/win32-util.c
M src/openvpn/win32-util.h
M src/openvpn/win32.c
M src/openvpn/win32.h
M src/openvpn/xkey_common.h
M src/openvpn/xkey_helper.c
M src/openvpn/xkey_provider.c
M src/openvpnmsica/Makefile.am
M src/openvpnmsica/dllmain.c
M src/openvpnmsica/msica_arg.c
M src/openvpnmsica/msica_arg.h
M src/openvpnmsica/msiex.c
M src/openvpnmsica/msiex.h
M src/openvpnmsica/openvpnmsica.c
M src/openvpnmsica/openvpnmsica.h
M src/openvpnmsica/openvpnmsica_resources.rc
M src/openvpnserv/common.c
M src/openvpnserv/interactive.c
M src/openvpnserv/service.h
M src/openvpnserv/validate.c
M src/openvpnserv/validate.h
M src/plugins/auth-pam/auth-pam.c
M src/plugins/auth-pam/utils.c
M src/plugins/auth-pam/utils.h
M src/plugins/down-root/down-root.c
M src/tapctl/Makefile.am
M src/tapctl/basic.h
M src/tapctl/error.c
M src/tapctl/error.h
M src/tapctl/main.c
M src/tapctl/tap.c
M src/tapctl/tap.h
M src/tapctl/tapctl_resources.rc
M tests/ntlm_support.c
M tests/t_cltsrv.sh
M tests/t_lpback.sh
M tests/unit_tests/openvpn/cert_data.h
M tests/unit_tests/openvpn/mock_get_random.c
M tests/unit_tests/openvpn/mock_management.c
M tests/unit_tests/openvpn/mock_msg.c
M tests/unit_tests/openvpn/mock_msg.h
M tests/unit_tests/openvpn/mock_ssl_dependencies.c
M tests/unit_tests/openvpn/mock_win32_execve.c
M tests/unit_tests/openvpn/pkey_test_utils.c
M tests/unit_tests/openvpn/test_auth_token.c
M tests/unit_tests/openvpn/test_buffer.c
M tests/unit_tests/openvpn/test_common.h
M tests/unit_tests/openvpn/test_crypto.c
M tests/unit_tests/openvpn/test_cryptoapi.c
M tests/unit_tests/openvpn/test_misc.c
M tests/unit_tests/openvpn/test_ncp.c
M tests/unit_tests/openvpn/test_packet_id.c
M tests/unit_tests/openvpn/test_pkcs11.c
M tests/unit_tests/openvpn/test_pkt.c
M tests/unit_tests/openvpn/test_provider.c
M tests/unit_tests/openvpn/test_ssl.c
M tests/unit_tests/openvpn/test_tls_crypt.c
M tests/unit_tests/openvpn/test_user_pass.c
288 files changed, 288 insertions(+), 578 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/1124/3

diff --git a/Makefile.am b/Makefile.am
index 8a28149..a62200d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -19,8 +19,7 @@
 #  GNU General Public License for more details.
 #
 #  You should have received a copy of the GNU General Public License along
-#  with this program; if not, write to the Free Software Foundation, Inc.,
-#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#  with this program; if not, see <https://www.gnu.org/licenses/>.
 #

 ACLOCAL_AMFLAGS =3D -I m4
diff --git a/compat.m4 b/compat.m4
index 8fa9abe..2cf9844 100644
--- a/compat.m4
+++ b/compat.m4
@@ -17,8 +17,7 @@
 dnl  GNU General Public License for more details.
 dnl
 dnl  You should have received a copy of the GNU General Public License alo=
ng
-dnl  with this program; if not, write to the Free Software Foundation, Inc=
.,
-dnl  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+dnl  with this program; if not, see <https://www.gnu.org/licenses/>.

 dnl Compatibility layer for <autoconf-2.60 <automake-1.10
 dnl REMOVE THIS IN FUTURE!
diff --git a/configure.ac b/configure.ac
index 66cb79b..7059871 100644
--- a/configure.ac
+++ b/configure.ac
@@ -18,8 +18,7 @@
 dnl  GNU General Public License for more details.
 dnl
 dnl  You should have received a copy of the GNU General Public License alo=
ng
-dnl  with this program; if not, write to the Free Software Foundation, Inc=
.,
-dnl  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+dnl  with this program; if not, see <https://www.gnu.org/licenses/>.

 dnl Process this file with autoconf to produce a configure script.

diff --git a/contrib/cmake/git-version.py b/contrib/cmake/git-version.py
index a89b039..fc390f3 100644
--- a/contrib/cmake/git-version.py
+++ b/contrib/cmake/git-version.py
@@ -18,8 +18,7 @@
 #  GNU General Public License for more details.
 #
 #  You should have received a copy of the GNU General Public License along
-#  with this program; if not, write to the Free Software Foundation, Inc.,
-#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#  with this program; if not, see <https://www.gnu.org/licenses/>.
 #

 # Usage: ./git-version.py [directory]
diff --git a/contrib/cmake/parse-version.m4.py b/contrib/cmake/parse-versio=
n.m4.py
index 6297b92..8c95ffc 100644
--- a/contrib/cmake/parse-version.m4.py
+++ b/contrib/cmake/parse-version.m4.py
@@ -18,8 +18,7 @@
 #  GNU General Public License for more details.
 #
 #  You should have received a copy of the GNU General Public License along
-#  with this program; if not, write to the Free Software Foundation, Inc.,
-#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#  with this program; if not, see <https://www.gnu.org/licenses/>.
 #

 # Usage: ./parse-version.m4.py m4file [directory]
diff --git a/dev-tools/gen-release-tarballs.sh b/dev-tools/gen-release-tarb=
alls.sh
index 6262dd4..7b97aa6 100755
--- a/dev-tools/gen-release-tarballs.sh
+++ b/dev-tools/gen-release-tarballs.sh
@@ -14,8 +14,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-130=
1, USA.
+# along with this program; if not, see <https://www.gnu.org/licenses/>.
 #
 set -u

diff --git a/dev-tools/gerrit-send-mail.py b/dev-tools/gerrit-send-mail.py
index ec1b2bc..0b49ae9 100755
--- a/dev-tools/gerrit-send-mail.py
+++ b/dev-tools/gerrit-send-mail.py
@@ -13,8 +13,7 @@
 #  GNU General Public License for more details.
 #
 #  You should have received a copy of the GNU General Public License along
-#  with this program; if not, write to the Free Software Foundation, Inc.,
-#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#  with this program; if not, see <https://www.gnu.org/licenses/>.

 # Extract a patch from Gerrit and transform it in a file suitable as input
 # for git send-email.
diff --git a/dev-tools/reformat-all.sh b/dev-tools/reformat-all.sh
index 02421c1..0a31a83 100755
--- a/dev-tools/reformat-all.sh
+++ b/dev-tools/reformat-all.sh
@@ -15,8 +15,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-130=
1, USA.
+# along with this program; if not, see <https://www.gnu.org/licenses/>.
 #

 tstamp=3D"$(date +%Y%m%d-%H%M%S)"
diff --git a/dev-tools/update-copyright.sh b/dev-tools/update-copyright.sh
index f6c8cdf..d19343f 100755
--- a/dev-tools/update-copyright.sh
+++ b/dev-tools/update-copyright.sh
@@ -16,8 +16,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-130=
1, USA.
+# along with this program; if not, see <https://www.gnu.org/licenses/>.
 #

 # Basic shell sanity
diff --git a/doc/doxygen/doc_compression.h b/doc/doxygen/doc_compression.h
index c5678be..d5a1bd9 100644
--- a/doc/doxygen/doc_compression.h
+++ b/doc/doxygen/doc_compression.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/doc/doxygen/doc_control_processor.h b/doc/doxygen/doc_control_=
processor.h
index 3e9c592..03549e2 100644
--- a/doc/doxygen/doc_control_processor.h
+++ b/doc/doxygen/doc_control_processor.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/doc/doxygen/doc_control_tls.h b/doc/doxygen/doc_control_tls.h
index 3c92a76..c6bbfe6 100644
--- a/doc/doxygen/doc_control_tls.h
+++ b/doc/doxygen/doc_control_tls.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/doc/doxygen/doc_data_control.h b/doc/doxygen/doc_data_control.h
index ccb0117..010155b 100644
--- a/doc/doxygen/doc_data_control.h
+++ b/doc/doxygen/doc_data_control.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/doc/doxygen/doc_data_crypto.h b/doc/doxygen/doc_data_crypto.h
index 165ce44..b2e50ab 100644
--- a/doc/doxygen/doc_data_crypto.h
+++ b/doc/doxygen/doc_data_crypto.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/doc/doxygen/doc_eventloop.h b/doc/doxygen/doc_eventloop.h
index 48d0c50..ec60afb 100644
--- a/doc/doxygen/doc_eventloop.h
+++ b/doc/doxygen/doc_eventloop.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/doc/doxygen/doc_external_multiplexer.h b/doc/doxygen/doc_exter=
nal_multiplexer.h
index 61b2d8f..15ae8bb 100644
--- a/doc/doxygen/doc_external_multiplexer.h
+++ b/doc/doxygen/doc_external_multiplexer.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/doc/doxygen/doc_fragmentation.h b/doc/doxygen/doc_fragmentatio=
n.h
index 03b6310..02d8cb2 100644
--- a/doc/doxygen/doc_fragmentation.h
+++ b/doc/doxygen/doc_fragmentation.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/doc/doxygen/doc_internal_multiplexer.h b/doc/doxygen/doc_inter=
nal_multiplexer.h
index 0085fbf..3da2df8 100644
--- a/doc/doxygen/doc_internal_multiplexer.h
+++ b/doc/doxygen/doc_internal_multiplexer.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/doc/doxygen/doc_key_generation.h b/doc/doxygen/doc_key_generat=
ion.h
index 91c7a5a..766f433 100644
--- a/doc/doxygen/doc_key_generation.h
+++ b/doc/doxygen/doc_key_generation.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/doc/doxygen/doc_mainpage.h b/doc/doxygen/doc_mainpage.h
index 7b1b80e..25fd40e 100644
--- a/doc/doxygen/doc_mainpage.h
+++ b/doc/doxygen/doc_mainpage.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/doc/doxygen/doc_memory_management.h b/doc/doxygen/doc_memory_m=
anagement.h
index 27d9188..5e9a930 100644
--- a/doc/doxygen/doc_memory_management.h
+++ b/doc/doxygen/doc_memory_management.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/doc/doxygen/doc_protocol_overview.h b/doc/doxygen/doc_protocol=
_overview.h
index 65a9c85..a6e9369 100644
--- a/doc/doxygen/doc_protocol_overview.h
+++ b/doc/doxygen/doc_protocol_overview.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/doc/doxygen/doc_reliable.h b/doc/doxygen/doc_reliable.h
index 5718699..e9a8b06 100644
--- a/doc/doxygen/doc_reliable.h
+++ b/doc/doxygen/doc_reliable.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/doc/doxygen/doc_tunnel_state.h b/doc/doxygen/doc_tunnel_state.h
index cbc1fa2..04a48f3 100644
--- a/doc/doxygen/doc_tunnel_state.h
+++ b/doc/doxygen/doc_tunnel_state.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index e0d0bb0..106a274 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef OPENVPN_MSG_H_
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index 4d270da..0bf88fc 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef OPENVPN_PLUGIN_H_
diff --git a/sample/sample-plugins/client-connect/sample-client-connect.c b=
/sample/sample-plugins/client-connect/sample-client-connect.c
index 5194270..3dda782 100644
--- a/sample/sample-plugins/client-connect/sample-client-connect.c
+++ b/sample/sample-plugins/client-connect/sample-client-connect.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/sample/sample-plugins/defer/multi-auth.c b/sample/sample-plugi=
ns/defer/multi-auth.c
index c458346..9a2cb13 100644
--- a/sample/sample-plugins/defer/multi-auth.c
+++ b/sample/sample-plugins/defer/multi-auth.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmate=
rialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keying=
materialexporter.c
index f1f8868..b73144f 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexp=
orter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexp=
orter.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/sample/sample-plugins/log/log.c b/sample/sample-plugins/log/lo=
g.c
index b304f16..63d714f 100644
--- a/sample/sample-plugins/log/log.c
+++ b/sample/sample-plugins/log/log.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log=
/log_v3.c
index a024027..02cdda8 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/sample/sample-plugins/simple/base64.c b/sample/sample-plugins/=
simple/base64.c
index e1cc791..b6c0c97 100644
--- a/sample/sample-plugins/simple/base64.c
+++ b/sample/sample-plugins/simple/base64.c
@@ -18,8 +18,7 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  distribution); if not, see <https://www.gnu.org/licenses/>.
  */

 #include <stdio.h>
diff --git a/sample/sample-plugins/simple/simple.c b/sample/sample-plugins/=
simple/simple.c
index 2c096e2..ed5bce5 100644
--- a/sample/sample-plugins/simple/simple.c
+++ b/sample/sample-plugins/simple/simple.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/compat/compat-basename.c b/src/compat/compat-basename.c
index abb4f49..18944f6 100644
--- a/src/compat/compat-basename.c
+++ b/src/compat/compat-basename.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/compat/compat-daemon.c b/src/compat/compat-daemon.c
index 5c6d740..8eb76ee 100644
--- a/src/compat/compat-daemon.c
+++ b/src/compat/compat-daemon.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/compat/compat-dirname.c b/src/compat/compat-dirname.c
index c131dee..17de8ad 100644
--- a/src/compat/compat-dirname.c
+++ b/src/compat/compat-dirname.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/compat/compat-gettimeofday.c b/src/compat/compat-gettimeof=
day.c
index 997f360..de53cb5 100644
--- a/src/compat/compat-gettimeofday.c
+++ b/src/compat/compat-gettimeofday.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/compat/compat-strsep.c b/src/compat/compat-strsep.c
index 25eae0c..3efe0bf 100644
--- a/src/compat/compat-strsep.c
+++ b/src/compat/compat-strsep.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/compat/compat.h b/src/compat/compat.h
index 026974a..6532b86 100644
--- a/src/compat/compat.h
+++ b/src/compat/compat.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef COMPAT_H
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 95215c0..34266d4 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  *
  *
  *  A printf-like function (that only recognizes a subset of standard prin=
tf
diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
index 098a1cb..f694760 100644
--- a/src/openvpn/argv.h
+++ b/src/openvpn/argv.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  *
  *
  *  A printf-like function (that only recognizes a subset of standard prin=
tf
diff --git a/src/openvpn/auth_token.h b/src/openvpn/auth_token.h
index 5859905..3d56ee6 100644
--- a/src/openvpn/auth_token.h
+++ b/src/openvpn/auth_token.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 #ifndef AUTH_TOKEN_H
 #define AUTH_TOKEN_H
diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h
index f603ecc..47a86d9 100644
--- a/src/openvpn/basic.h
+++ b/src/openvpn/basic.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef BASIC_H
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index dd6044b..5940ad9 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 5f2ad5d..0d5c30d 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef BUFFER_H
diff --git a/src/openvpn/circ_list.h b/src/openvpn/circ_list.h
index 0189c8b..cdbc8ef 100644
--- a/src/openvpn/circ_list.h
+++ b/src/openvpn/circ_list.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef CIRC_LIST_H
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index f040724..f120a54 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
index 334b3f2..d565a49 100644
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #if !defined(CLINAT_H)
diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index 5d4cf2e..d7f5d959 100644
--- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef COMMON_H
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index ab37164..425b1d9 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/comp-lz4.h b/src/openvpn/comp-lz4.h
index 09d0dc7..fb22c12 100644
--- a/src/openvpn/comp-lz4.h
+++ b/src/openvpn/comp-lz4.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef OPENVPN_COMP_LZ4_H
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index b2aa07e..afea948 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 0bb0d32..a1c885b 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/compstub.c b/src/openvpn/compstub.c
index 109d691..853e9ee 100644
--- a/src/openvpn/compstub.c
+++ b/src/openvpn/compstub.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index 617e146..7cc4fff 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -19,8 +19,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 589f778..3e99776 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -19,8 +19,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef CONSOLE_H
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index ba61d3f..b6db701 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -19,8 +19,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
index 91ebb35..36103b2 100644
--- a/src/openvpn/console_systemd.c
+++ b/src/openvpn/console_systemd.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 7564f82..1c1be46 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 68ad901..b6f3549 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 8bb7f47..df5bc4d 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c
index 14727c7..741ad23 100644
--- a/src/openvpn/crypto_epoch.c
+++ b/src/openvpn/crypto_epoch.c
@@ -19,8 +19,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */


diff --git a/src/openvpn/crypto_epoch.h b/src/openvpn/crypto_epoch.h
index c16f966..ff5974e 100644
--- a/src/openvpn/crypto_epoch.h
+++ b/src/openvpn/crypto_epoch.h
@@ -19,8 +19,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef CRYPTO_EPOCH_H
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 1f3dcba..0950f6b 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index 6575bad..620732e 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 88b3580..2e7bd63 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 85f53f6..9680c18 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 98cbb72..df70e87 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -20,8 +20,7 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  distribution); if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 2ce0eb1..95abf71 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -20,8 +20,7 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  distribution); if not, see <https://www.gnu.org/licenses/>.
  */
 #ifndef DCO_H
 #define DCO_H
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 488665f..04c1e3d 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -14,8 +14,7 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  distribution); if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h
index 69c2d05..cbb1dda 100644
--- a/src/openvpn/dco_freebsd.h
+++ b/src/openvpn/dco_freebsd.h
@@ -14,8 +14,7 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  distribution); if not, see <https://www.gnu.org/licenses/>.
  */
 #ifndef DCO_FREEBSD_H
 #define DCO_FREEBSD_H
diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
index 27d03ef..96aa281 100644
--- a/src/openvpn/dco_internal.h
+++ b/src/openvpn/dco_internal.h
@@ -19,8 +19,7 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  distribution); if not, see <https://www.gnu.org/licenses/>.
  */
 #ifndef DCO_INTERNAL_H
 #define DCO_INTERNAL_H
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 9ad3d51..ab59e3e 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -16,8 +16,7 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  distribution); if not, see <https://www.gnu.org/licenses/>.
  */


diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index cc14f45..9f15199 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -16,8 +16,7 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  distribution); if not, see <https://www.gnu.org/licenses/>.
  */
 #ifndef DCO_LINUX_H
 #define DCO_LINUX_H
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 995b121..d227965 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -15,8 +15,7 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  distribution); if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index b9d93fa..7311de8 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -15,8 +15,7 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  distribution); if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef DCO_WIN_H
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index da7a932..df01412 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/dhcp.h b/src/openvpn/dhcp.h
index c578c6a..34f4513 100644
--- a/src/openvpn/dhcp.h
+++ b/src/openvpn/dhcp.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef DHCP_H
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index ea3d91b..2952a8a 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index d33f64e..94c76e5 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef DNS_H
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index f20ee8a..7809237 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -20,8 +20,7 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  distribution); if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/env_set.h b/src/openvpn/env_set.h
index 52c5312..63237a7 100644
--- a/src/openvpn/env_set.h
+++ b/src/openvpn/env_set.h
@@ -18,8 +18,7 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  distribution); if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef ENV_SET_H
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index fc3e64a..e5e5b48 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef ERRLEVEL_H
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 049cd92..22c339f 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index e0a2730..cd0cac3 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef ERROR_H
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index c3907b9..c773783 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index 389f80d..38178fc 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef EVENT_H
diff --git a/src/openvpn/fdmisc.c b/src/openvpn/fdmisc.c
index 3d8654c..b8d9334 100644
--- a/src/openvpn/fdmisc.c
+++ b/src/openvpn/fdmisc.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/fdmisc.h b/src/openvpn/fdmisc.h
index 17b6994..de0007a 100644
--- a/src/openvpn/fdmisc.h
+++ b/src/openvpn/fdmisc.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef FD_MISC_H
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 475d142..d750ebf 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 2818fd1..abb45c0 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */


diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index 287eb9b..a7fbe09 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/fragment.h b/src/openvpn/fragment.h
index cc96057..6120079 100644
--- a/src/openvpn/fragment.h
+++ b/src/openvpn/fragment.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef FRAGMENT_H
diff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin.c
index b58defe..a3ecc8d 100644
--- a/src/openvpn/gremlin.c
+++ b/src/openvpn/gremlin.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/gremlin.h b/src/openvpn/gremlin.h
index bf1cfea..3cbfb77 100644
--- a/src/openvpn/gremlin.h
+++ b/src/openvpn/gremlin.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef GREMLIN_H
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 7cef9db..36b88f5 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/helper.h b/src/openvpn/helper.h
index ec5fe9e..0ce12dd 100644
--- a/src/openvpn/helper.h
+++ b/src/openvpn/helper.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index 8665402..be700b2 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/httpdigest.h b/src/openvpn/httpdigest.h
index 50cf451..ecdd6d3 100644
--- a/src/openvpn/httpdigest.h
+++ b/src/openvpn/httpdigest.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #if PROXY_DIGEST_AUTH
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 3254cc6..32f20e1 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 25078a6..081a295 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef INIT_H
diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index c568036..4a95f4e 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef INTEGER_H
diff --git a/src/openvpn/interval.c b/src/openvpn/interval.c
index f1abeee..a2ac4f7 100644
--- a/src/openvpn/interval.c
+++ b/src/openvpn/interval.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/interval.h b/src/openvpn/interval.h
index 60030fd..420a1be 100644
--- a/src/openvpn/interval.h
+++ b/src/openvpn/interval.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index 1f33b5f..48e549f 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index 783570f..77807c7 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef LIST_H
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index 01db221..d5f60ca 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h
index 03da2af..c47db83 100644
--- a/src/openvpn/lzo.h
+++ b/src/openvpn/lzo.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef OPENVPN_LZO_H
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 8836e79..c7bdd5a 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index eb19a4e..36a1905 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef MANAGE_H
diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
index aeb0c5f..655c48f 100644
--- a/src/openvpn/mbedtls_compat.h
+++ b/src/openvpn/mbedtls_compat.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index 3346a11..76f2e58 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/mbuf.h b/src/openvpn/mbuf.h
index b9c1645..8cc7ab1 100644
--- a/src/openvpn/mbuf.h
+++ b/src/openvpn/mbuf.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef MBUF_H
diff --git a/src/openvpn/memdbg.h b/src/openvpn/memdbg.h
index 6947275..9f8ff11 100644
--- a/src/openvpn/memdbg.h
+++ b/src/openvpn/memdbg.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef MEMDBG_H
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 4695700..5776d6a 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -19,8 +19,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index c6e2fa51..eb2449c 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef MISC_H
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index e3b1e9b..b14be7e 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 4f9fc03..e06d272 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef MROUTE_H
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 01ccdeb..96a9af0 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h
index 426af5e..1b1eafb 100644
--- a/src/openvpn/mss.h
+++ b/src/openvpn/mss.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef MSS_H
diff --git a/src/openvpn/mstats.c b/src/openvpn/mstats.c
index cbef26a..d9ecee3 100644
--- a/src/openvpn/mstats.c
+++ b/src/openvpn/mstats.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/mstats.h b/src/openvpn/mstats.h
index ea0237f..b9f33b6 100644
--- a/src/openvpn/mstats.h
+++ b/src/openvpn/mstats.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 71991dd..9781724 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index 334d6eb..5158427d 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 78f1309..7245f95 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index dca402a..64fd5b9 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef MTU_H
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 118c954..5755273 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index 4c83ad4..7e377b9 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 68b4da6..a306b12 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 3c821d7..3c3db97 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index 102ee2f..82f8372 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/multi_io.h b/src/openvpn/multi_io.h
index aecb65f..07eb3d4 100644
--- a/src/openvpn/multi_io.h
+++ b/src/openvpn/multi_io.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index 0ba4963..eccd8d2 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -14,8 +14,7 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  distribution); if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef NETWORKING_H_
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_ipr=
oute2.c
index 28b5bfc..ec8ab1e 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -14,8 +14,7 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  distribution); if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/networking_iproute2.h b/src/openvpn/networking_ipr=
oute2.h
index ae72099..07de8b7 100644
--- a/src/openvpn/networking_iproute2.h
+++ b/src/openvpn/networking_iproute2.h
@@ -14,8 +14,7 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  distribution); if not, see <https://www.gnu.org/licenses/>.
  */


diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 79aba8d..97e5749 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -14,8 +14,7 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  distribution); if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/networking_sitnl.h b/src/openvpn/networking_sitnl.h
index 002b479..97ff443 100644
--- a/src/openvpn/networking_sitnl.h
+++ b/src/openvpn/networking_sitnl.h
@@ -14,8 +14,7 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  distribution); if not, see <https://www.gnu.org/licenses/>.
  */


diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 2c6a69d..94e5d95 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -16,8 +16,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index 773fcfd..00b2fa4 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
index 8631bce..d5f208e 100644
--- a/src/openvpn/occ.h
+++ b/src/openvpn/occ.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef OCC_H
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 6baaaea..20f612e 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 54d5a06..99c420a 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 7d48888..004cbc7 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef OPENVPN_H
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ff9addd..67139b8 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 0544ca9..dbd50f0 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index d317c1a..e469c28 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index 71d51d6..23fd78d 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef OPTIONS_UTIL_H_
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index d423067..d6b9c2c 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index 448389d..29e8046 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef OTIME_H
diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
index dd6b7ce..baf7214 100644
--- a/src/openvpn/ovpn_dco_win.h
+++ b/src/openvpn/ovpn_dco_win.h
@@ -15,8 +15,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  *
  *  This particular file (uapi.h) is also licensed using the MIT license (=
see COPYRIGHT.MIT).
  */
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 76a81c6..e6ca601 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index 6db939f..8bb6951 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/perf.c b/src/openvpn/perf.c
index 71c00e5..580e0fe 100644
--- a/src/openvpn/perf.c
+++ b/src/openvpn/perf.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/perf.h b/src/openvpn/perf.h
index 5ddebeb..7b35b5e 100644
--- a/src/openvpn/perf.h
+++ b/src/openvpn/perf.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/ping.c b/src/openvpn/ping.c
index f570d95..50f255a 100644
--- a/src/openvpn/ping.c
+++ b/src/openvpn/ping.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/ping.h b/src/openvpn/ping.h
index 4cb89b4..29ee2f2 100644
--- a/src/openvpn/ping.h
+++ b/src/openvpn/ping.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef PING_H
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 00428d8..0177b18 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/pkcs11.h b/src/openvpn/pkcs11.h
index 72913eb..644d7ce 100644
--- a/src/openvpn/pkcs11.h
+++ b/src/openvpn/pkcs11.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef OPENVPN_PKCS11_H
diff --git a/src/openvpn/pkcs11_backend.h b/src/openvpn/pkcs11_backend.h
index dce6822..f65ba3f 100644
--- a/src/openvpn/pkcs11_backend.h
+++ b/src/openvpn/pkcs11_backend.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c
index 13b8a86..d1c8957 100644
--- a/src/openvpn/pkcs11_mbedtls.c
+++ b/src/openvpn/pkcs11_mbedtls.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index e6baa43..489aa35 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index b690192..623daaa 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index 56f8909..18ea97d 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef PLATFORM_H
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index bafa469..12912c0 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index 5e91c60..b44cf0d 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index ced172c..bfa43ec 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/pool.h b/src/openvpn/pool.h
index 9c3905d..9f50ca9 100644
--- a/src/openvpn/pool.h
+++ b/src/openvpn/pool.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef POOL_H
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index 90930fe..4820602 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 11c2a49..0942c11 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef PROTO_H
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 0117a66..393abb4 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index cf1fbdb..fcca1ab 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef PROXY_H
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 0f2b812..6c6e5ea 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/ps.h b/src/openvpn/ps.h
index 59aecbe..c6f5633 100644
--- a/src/openvpn/ps.h
+++ b/src/openvpn/ps.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef PS_H
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 22082a9..3013100 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 18dfcd8..b6770bc 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef PUSH_H
diff --git a/src/openvpn/pushlist.h b/src/openvpn/pushlist.h
index d946a5f..1b66517 100644
--- a/src/openvpn/pushlist.h
+++ b/src/openvpn/pushlist.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */
=20
 #if !defined(PUSHLIST_H)
diff --git a/src/openvpn/reflect_filter.c b/src/openvpn/reflect_filter.c
index a5bcf94..17255f7 100644
--- a/src/openvpn/reflect_filter.c
+++ b/src/openvpn/reflect_filter.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/reflect_filter.h b/src/openvpn/reflect_filter.h
index ae7be21..e3fb165 100644
--- a/src/openvpn/reflect_filter.h
+++ b/src/openvpn/reflect_filter.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 #ifndef REFLECT_FILTER_H
 #define REFLECT_FILTER_H
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 5505f56..278dc33 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 2cbff01..6c37d78 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */


diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 89ebaee..c4f7f95 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index b89ec9f..1a358e32 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
index 8b5fa4f..ed5b08c 100644
--- a/src/openvpn/run_command.c
+++ b/src/openvpn/run_command.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h
index e9a6fe1..e703732 100644
--- a/src/openvpn/run_command.h
+++ b/src/openvpn/run_command.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef RUN_COMMAND_H
diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
index aaa9885..f89f341 100644
--- a/src/openvpn/schedule.c
+++ b/src/openvpn/schedule.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/schedule.h b/src/openvpn/schedule.h
index 1608708..fad3f36 100644
--- a/src/openvpn/schedule.h
+++ b/src/openvpn/schedule.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef SCHEDULE_H
diff --git a/src/openvpn/session_id.c b/src/openvpn/session_id.c
index 47226fb..f31b898 100644
--- a/src/openvpn/session_id.c
+++ b/src/openvpn/session_id.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/session_id.h b/src/openvpn/session_id.h
index 5ce9a96..7c0a968 100644
--- a/src/openvpn/session_id.h
+++ b/src/openvpn/session_id.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/shaper.c b/src/openvpn/shaper.c
index 1075954..1c8cfb3 100644
--- a/src/openvpn/shaper.c
+++ b/src/openvpn/shaper.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/shaper.h b/src/openvpn/shaper.h
index 2b3eeb9..9996b08 100644
--- a/src/openvpn/shaper.h
+++ b/src/openvpn/shaper.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef SHAPER_H
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 9334b10..02df5e0 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
index fe81af9..93219f7 100644
--- a/src/openvpn/sig.h
+++ b/src/openvpn/sig.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef SIG_H
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 980d8b4..8510e1d 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 6d71e83..f30411d 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef SOCKET_H
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index cc2dbdf..6192c39 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
index 0eaa9da..985745b 100644
--- a/src/openvpn/socks.h
+++ b/src/openvpn/socks.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index a7658dd..06621bd 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -19,8 +19,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 0a43ea1..b952cd9 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 1cf9e1d..8023fed 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index e9e50da..90c0086 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index a4bb772..22e777b 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -19,8 +19,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 9f124cd..fba766b 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 74d7b43..62fef42 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -19,8 +19,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
index 6159264..b01cd87 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 4c11cd4..1c1649f 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index f26b44e..966bb44 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index bfd405f..e730e33 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 #ifdef HAVE_CONFIG_H
 #include "config.h"
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index 98a39d3..1e9f4e9 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
index d3d7b2c..6e00630 100644
--- a/src/openvpn/ssl_util.c
+++ b/src/openvpn/ssl_util.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 #ifdef HAVE_CONFIG_H
 #include "config.h"
diff --git a/src/openvpn/ssl_util.h b/src/openvpn/ssl_util.h
index e50f899..189b1d0 100644
--- a/src/openvpn/ssl_util.h
+++ b/src/openvpn/ssl_util.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 41635c8..82337cf 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 9a30db0..76f1e24 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_back=
end.h
index eb80cc8..03f591c 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
index 25ad09c..43bbde5 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/ssl_verify_mbedtls.h b/src/openvpn/ssl_verify_mbed=
tls.h
index ff21157..3e380a6 100644
--- a/src/openvpn/ssl_verify_mbedtls.h
+++ b/src/openvpn/ssl_verify_mbedtls.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 1546815..0c206e3 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/ssl_verify_openssl.h b/src/openvpn/ssl_verify_open=
ssl.h
index 00c106d..7577cb2 100644
--- a/src/openvpn/ssl_verify_openssl.h
+++ b/src/openvpn/ssl_verify_openssl.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index 4b0e516..1f5e67a 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/status.h b/src/openvpn/status.h
index eaed22a..ddbaeef 100644
--- a/src/openvpn/status.h
+++ b/src/openvpn/status.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef STATUS_H
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 00d7685..e77f313 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef SYSHEAD_H
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 67e19382..b0c4291 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
index 42545d1..c8bd384 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /**
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index d15d9eb6..a96a305 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 5407e47..c53fdc0 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef TUN_H
diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c
index 50ef765..ac12070 100644
--- a/src/openvpn/tun_afunix.c
+++ b/src/openvpn/tun_afunix.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/tun_afunix.h b/src/openvpn/tun_afunix.h
index 21ae676..faca142 100644
--- a/src/openvpn/tun_afunix.h
+++ b/src/openvpn/tun_afunix.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef AFUNIX_TUN_H
diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index d0beb48..5cc23f4 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/vlan.h b/src/openvpn/vlan.h
index f6cf385..7602585 100644
--- a/src/openvpn/vlan.h
+++ b/src/openvpn/vlan.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef VLAN_H
diff --git a/src/openvpn/wfp_block.c b/src/openvpn/wfp_block.c
index 2f13001..ce5cef2 100644
--- a/src/openvpn/wfp_block.c
+++ b/src/openvpn/wfp_block.c
@@ -19,8 +19,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/wfp_block.h b/src/openvpn/wfp_block.h
index fc5ec7e..6de39f5 100644
--- a/src/openvpn/wfp_block.h
+++ b/src/openvpn/wfp_block.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef _WIN32
diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32-util.c
index dd55743..c23d066 100644
--- a/src/openvpn/win32-util.c
+++ b/src/openvpn/win32-util.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */
=20
 /*
diff --git a/src/openvpn/win32-util.h b/src/openvpn/win32-util.h
index bd7c03a..df4f8b3 100644
--- a/src/openvpn/win32-util.h
+++ b/src/openvpn/win32-util.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef _WIN32
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 8d6f9c3..0524c57 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 4b07d9e..34d18c6 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef _WIN32
diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index 84c6329..111596e 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef XKEY_COMMON_H_
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index b5ed73c..487bfe6 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index deaca38..edd64d3 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am
index b463531..8dc3749 100644
--- a/src/openvpnmsica/Makefile.am
+++ b/src/openvpnmsica/Makefile.am
@@ -14,8 +14,7 @@
 #  GNU General Public License for more details.
 #
 #  You should have received a copy of the GNU General Public License along
-#  with this program; if not, write to the Free Software Foundation, Inc.,
-#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#  with this program; if not, see <https://www.gnu.org/licenses/>.
 #

 include $(top_srcdir)/ltrc.inc
diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c
index 6f14a5c..7121c02 100644
--- a/src/openvpnmsica/dllmain.c
+++ b/src/openvpnmsica/dllmain.c
@@ -14,8 +14,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpnmsica/msica_arg.c b/src/openvpnmsica/msica_arg.c
index 0f5b2fb..46bef2b 100644
--- a/src/openvpnmsica/msica_arg.c
+++ b/src/openvpnmsica/msica_arg.c
@@ -14,8 +14,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpnmsica/msica_arg.h b/src/openvpnmsica/msica_arg.h
index 2a3e931..c8f7595 100644
--- a/src/openvpnmsica/msica_arg.h
+++ b/src/openvpnmsica/msica_arg.h
@@ -14,8 +14,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef MSICA_ARG_H
diff --git a/src/openvpnmsica/msiex.c b/src/openvpnmsica/msiex.c
index c0f5853..3529e9a 100644
--- a/src/openvpnmsica/msiex.c
+++ b/src/openvpnmsica/msiex.c
@@ -14,8 +14,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpnmsica/msiex.h b/src/openvpnmsica/msiex.h
index ab029cc..d9afeb5 100644
--- a/src/openvpnmsica/msiex.h
+++ b/src/openvpnmsica/msiex.h
@@ -14,8 +14,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef MSIHLP_H
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsic=
a.c
index 003da6e..8d860e2 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -14,8 +14,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsic=
a.h
index b4e3aa8..d07554f 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -14,8 +14,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef MSICA_H
diff --git a/src/openvpnmsica/openvpnmsica_resources.rc b/src/openvpnmsica/=
openvpnmsica_resources.rc
index 0bf7330..d4e0274 100644
--- a/src/openvpnmsica/openvpnmsica_resources.rc
+++ b/src/openvpnmsica/openvpnmsica_resources.rc
@@ -13,8 +13,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index fe360fa..5543c37 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #include "service.h"
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 628a96b..bc63296 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */


diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index bfbe466..8989e60 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef _SERVICE_H
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 9231417..6ed5bea 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #include "validate.h"
diff --git a/src/openvpnserv/validate.h b/src/openvpnserv/validate.h
index 3ef577b..bde1892 100644
--- a/src/openvpnserv/validate.h
+++ b/src/openvpnserv/validate.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */
=20
 #ifndef VALIDATE_H
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pa=
m.c
index 7264f95..bff4767 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c
index ab5e17e..6524051 100644
--- a/src/plugins/auth-pam/utils.c
+++ b/src/plugins/auth-pam/utils.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/plugins/auth-pam/utils.h b/src/plugins/auth-pam/utils.h
index 844d2d1..0b90aee 100644
--- a/src/plugins/auth-pam/utils.h
+++ b/src/plugins/auth-pam/utils.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef _PLUGIN_AUTH_PAM_UTILS__H
diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down=
-root.c
index 2c0faf4..5f595fd 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /*
diff --git a/src/tapctl/Makefile.am b/src/tapctl/Makefile.am
index 86c8dc1..07fd714 100644
--- a/src/tapctl/Makefile.am
+++ b/src/tapctl/Makefile.am
@@ -14,8 +14,7 @@
 #  GNU General Public License for more details.
 #
 #  You should have received a copy of the GNU General Public License along
-#  with this program; if not, write to the Free Software Foundation, Inc.,
-#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#  with this program; if not, see <https://www.gnu.org/licenses/>.
 #

 include $(top_srcdir)/ltrc.inc
diff --git a/src/tapctl/basic.h b/src/tapctl/basic.h
index 3814db1..571ae62 100644
--- a/src/tapctl/basic.h
+++ b/src/tapctl/basic.h
@@ -15,8 +15,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */
=20
 #ifndef BASIC_H
diff --git a/src/tapctl/error.c b/src/tapctl/error.c
index 10c89d5..9f5094e 100644
--- a/src/tapctl/error.c
+++ b/src/tapctl/error.c
@@ -15,8 +15,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #include "error.h"
diff --git a/src/tapctl/error.h b/src/tapctl/error.h
index 42c175e..3da5674 100644
--- a/src/tapctl/error.h
+++ b/src/tapctl/error.h
@@ -15,8 +15,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef ERROR_H
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 58ab8cc..82caeaf 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -15,8 +15,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 39b43ac..96f09ee 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -14,8 +14,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
index 1ca512a..a0b0561 100644
--- a/src/tapctl/tap.h
+++ b/src/tapctl/tap.h
@@ -14,8 +14,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */
=20
 #ifndef TAP_H
diff --git a/src/tapctl/tapctl_resources.rc b/src/tapctl/tapctl_resources.rc
index f2a1ae0..f84fd6d 100644
--- a/src/tapctl/tapctl_resources.rc
+++ b/src/tapctl/tapctl_resources.rc
@@ -13,8 +13,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/tests/ntlm_support.c b/tests/ntlm_support.c
index f5eba88..3960cc5 100644
--- a/tests/ntlm_support.c
+++ b/tests/ntlm_support.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/tests/t_cltsrv.sh b/tests/t_cltsrv.sh
index 4a8643a..6b7df65 100755
--- a/tests/t_cltsrv.sh
+++ b/tests/t_cltsrv.sh
@@ -14,9 +14,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-# 02110-1301, USA.
+# along with this program; if not, see <https://www.gnu.org/licenses/>.

 set -e
 srcdir=3D"${srcdir:-.}"
diff --git a/tests/t_lpback.sh b/tests/t_lpback.sh
index 68df2a6..8ab3973 100755
--- a/tests/t_lpback.sh
+++ b/tests/t_lpback.sh
@@ -15,9 +15,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-# 02110-1301, USA.
+# along with this program; if not, see <https://www.gnu.org/licenses/>.

 set -eu
 top_builddir=3D"${top_builddir:-..}"
diff --git a/tests/unit_tests/openvpn/cert_data.h b/tests/unit_tests/openvp=
n/cert_data.h
index bbf3736..638af39 100644
--- a/tests/unit_tests/openvpn/cert_data.h
+++ b/tests/unit_tests/openvpn/cert_data.h
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef CERT_DATA_H
diff --git a/tests/unit_tests/openvpn/mock_get_random.c b/tests/unit_tests/=
openvpn/mock_get_random.c
index dfc7287..77db18e 100644
--- a/tests/unit_tests/openvpn/mock_get_random.c
+++ b/tests/unit_tests/openvpn/mock_get_random.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #include <stdarg.h>
diff --git a/tests/unit_tests/openvpn/mock_management.c b/tests/unit_tests/=
openvpn/mock_management.c
index c3e38b9..9674b45 100644
--- a/tests/unit_tests/openvpn/mock_management.c
+++ b/tests/unit_tests/openvpn/mock_management.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /* Minimal set of mocked management function/globals to get unit tests to
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn=
/mock_msg.c
index b6ec744..5407561 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/tests/unit_tests/openvpn/mock_msg.h b/tests/unit_tests/openvpn=
/mock_msg.h
index bc2ee5d..40d7609 100644
--- a/tests/unit_tests/openvpn/mock_msg.h
+++ b/tests/unit_tests/openvpn/mock_msg.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifndef MOCK_MSG_H
diff --git a/tests/unit_tests/openvpn/mock_ssl_dependencies.c b/tests/unit_=
tests/openvpn/mock_ssl_dependencies.c
index 5cfe8d0..2a562fc 100644
--- a/tests/unit_tests/openvpn/mock_ssl_dependencies.c
+++ b/tests/unit_tests/openvpn/mock_ssl_dependencies.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 /* Minimal set of mocked function/globals to get unit tests to
diff --git a/tests/unit_tests/openvpn/mock_win32_execve.c b/tests/unit_test=
s/openvpn/mock_win32_execve.c
index 26f8a84..0666fe8 100644
--- a/tests/unit_tests/openvpn/mock_win32_execve.c
+++ b/tests/unit_tests/openvpn/mock_win32_execve.c
@@ -19,8 +19,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #include "config.h"
diff --git a/tests/unit_tests/openvpn/pkey_test_utils.c b/tests/unit_tests/=
openvpn/pkey_test_utils.c
index 9a044ec..56608ea 100644
--- a/tests/unit_tests/openvpn/pkey_test_utils.c
+++ b/tests/unit_tests/openvpn/pkey_test_utils.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/=
openvpn/test_auth_token.c
index be3b2b7..960422c 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/open=
vpn/test_buffer.c
index 3a1007a..4b3aaf8 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/open=
vpn/test_common.h
index 52503c6..2f2207a 100644
--- a/tests/unit_tests/openvpn/test_common.h
+++ b/tests/unit_tests/openvpn/test_common.h
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #include <stdio.h>
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index 5b583c7..1c3b146 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/o=
penvpn/test_cryptoapi.c
index 9225b4d..072cc78 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c
index 0981a1a..fb46e99 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn=
/test_ncp.c
index 9c40f5c..941216a 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/o=
penvpn/test_packet_id.c
index 312a6b3d..084db5e 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -18,8 +18,7 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  distribution); if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/open=
vpn/test_pkcs11.c
index adad40b..591a457 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c
index ebffabe..46206fe 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/op=
envpn/test_provider.c
index fd38d3b..a8aea0c 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index 2a05c4f..c758f87 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/o=
penvpn/test_tls_crypt.c
index cc415c8..1b5eb27 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */
=20
 #ifdef HAVE_CONFIG_H
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
index 400c0f4..74f67a7 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -18,8 +18,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

 #ifdef HAVE_CONFIG_H

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1124?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic3959970fa9ab993e98d4b38c025fd0efc7b92f2
Gerrit-Change-Number: 1124
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--E8vzTfyB2Fk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1124?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Update GPL header in all source files to current rec=
ommended version<br><br>This removes the postal address of the FSF and repl=
aces<br>it with their URL.<br><br>Mostly generated with<br>sed -i -e &#39;s=
@...2901... not, write to the Free Software Foundation, Inc.,\<br>         =
   @if not, see &lt;https://www.gnu.org/licenses/&gt;.@&#39;<br>sed -i -e &=
#39;/51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA/d&#39;<br>s=
ed -i -e &#39;/59 Temple Place, Suite 330, Boston, MA  02111-1307  USA/d&#3=
9;<br><br>With some manual fix-ups afterwards.<br><br>Change-Id: Ic3959970f=
a9ab993e98d4b38c025fd0efc7b92f2<br>Signed-off-by: Frank Lichtenheld &lt;fra=
nk@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Mess=
age-Id: &lt;20250803145126.23494-1-gert@...1296...&gt;<br>URL: https://www.=
mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32481.html<br>Signe=
d-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M Makefile.am<br>M=
 compat.m4<br>M configure.ac<br>M contrib/cmake/git-version.py<br>M contrib=
/cmake/parse-version.m4.py<br>M dev-tools/gen-release-tarballs.sh<br>M dev-=
tools/gerrit-send-mail.py<br>M dev-tools/reformat-all.sh<br>M dev-tools/upd=
ate-copyright.sh<br>M doc/doxygen/doc_compression.h<br>M doc/doxygen/doc_co=
ntrol_processor.h<br>M doc/doxygen/doc_control_tls.h<br>M doc/doxygen/doc_d=
ata_control.h<br>M doc/doxygen/doc_data_crypto.h<br>M doc/doxygen/doc_event=
loop.h<br>M doc/doxygen/doc_external_multiplexer.h<br>M doc/doxygen/doc_fra=
gmentation.h<br>M doc/doxygen/doc_internal_multiplexer.h<br>M doc/doxygen/d=
oc_key_generation.h<br>M doc/doxygen/doc_mainpage.h<br>M doc/doxygen/doc_me=
mory_management.h<br>M doc/doxygen/doc_protocol_overview.h<br>M doc/doxygen=
/doc_reliable.h<br>M doc/doxygen/doc_tunnel_state.h<br>M include/openvpn-ms=
g.h<br>M include/openvpn-plugin.h.in<br>M sample/sample-plugins/client-conn=
ect/sample-client-connect.c<br>M sample/sample-plugins/defer/multi-auth.c<b=
r>M sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexpor=
ter.c<br>M sample/sample-plugins/log/log.c<br>M sample/sample-plugins/log/l=
og_v3.c<br>M sample/sample-plugins/simple/base64.c<br>M sample/sample-plugi=
ns/simple/simple.c<br>M src/compat/compat-basename.c<br>M src/compat/compat=
-daemon.c<br>M src/compat/compat-dirname.c<br>M src/compat/compat-gettimeof=
day.c<br>M src/compat/compat-strsep.c<br>M src/compat/compat.h<br>M src/ope=
nvpn/argv.c<br>M src/openvpn/argv.h<br>M src/openvpn/auth_token.h<br>M src/=
openvpn/basic.h<br>M src/openvpn/buffer.c<br>M src/openvpn/buffer.h<br>M sr=
c/openvpn/circ_list.h<br>M src/openvpn/clinat.c<br>M src/openvpn/clinat.h<b=
r>M src/openvpn/common.h<br>M src/openvpn/comp-lz4.c<br>M src/openvpn/comp-=
lz4.h<br>M src/openvpn/comp.c<br>M src/openvpn/comp.h<br>M src/openvpn/comp=
stub.c<br>M src/openvpn/console.c<br>M src/openvpn/console.h<br>M src/openv=
pn/console_builtin.c<br>M src/openvpn/console_systemd.c<br>M src/openvpn/cr=
ypto.c<br>M src/openvpn/crypto.h<br>M src/openvpn/crypto_backend.h<br>M src=
/openvpn/crypto_epoch.c<br>M src/openvpn/crypto_epoch.h<br>M src/openvpn/cr=
ypto_mbedtls.c<br>M src/openvpn/crypto_mbedtls.h<br>M src/openvpn/crypto_op=
enssl.c<br>M src/openvpn/crypto_openssl.h<br>M src/openvpn/dco.c<br>M src/o=
penvpn/dco.h<br>M src/openvpn/dco_freebsd.c<br>M src/openvpn/dco_freebsd.h<=
br>M src/openvpn/dco_internal.h<br>M src/openvpn/dco_linux.c<br>M src/openv=
pn/dco_linux.h<br>M src/openvpn/dco_win.c<br>M src/openvpn/dco_win.h<br>M s=
rc/openvpn/dhcp.c<br>M src/openvpn/dhcp.h<br>M src/openvpn/dns.c<br>M src/o=
penvpn/dns.h<br>M src/openvpn/env_set.c<br>M src/openvpn/env_set.h<br>M src=
/openvpn/errlevel.h<br>M src/openvpn/error.c<br>M src/openvpn/error.h<br>M =
src/openvpn/event.c<br>M src/openvpn/event.h<br>M src/openvpn/fdmisc.c<br>M=
 src/openvpn/fdmisc.h<br>M src/openvpn/forward.c<br>M src/openvpn/forward.h=
<br>M src/openvpn/fragment.c<br>M src/openvpn/fragment.h<br>M src/openvpn/g=
remlin.c<br>M src/openvpn/gremlin.h<br>M src/openvpn/helper.c<br>M src/open=
vpn/helper.h<br>M src/openvpn/httpdigest.c<br>M src/openvpn/httpdigest.h<br=
>M src/openvpn/init.c<br>M src/openvpn/init.h<br>M src/openvpn/integer.h<br=
>M src/openvpn/interval.c<br>M src/openvpn/interval.h<br>M src/openvpn/list=
.c<br>M src/openvpn/list.h<br>M src/openvpn/lzo.c<br>M src/openvpn/lzo.h<br=
>M src/openvpn/manage.c<br>M src/openvpn/manage.h<br>M src/openvpn/mbedtls_=
compat.h<br>M src/openvpn/mbuf.c<br>M src/openvpn/mbuf.h<br>M src/openvpn/m=
emdbg.h<br>M src/openvpn/misc.c<br>M src/openvpn/misc.h<br>M src/openvpn/mr=
oute.c<br>M src/openvpn/mroute.h<br>M src/openvpn/mss.c<br>M src/openvpn/ms=
s.h<br>M src/openvpn/mstats.c<br>M src/openvpn/mstats.h<br>M src/openvpn/mt=
cp.c<br>M src/openvpn/mtcp.h<br>M src/openvpn/mtu.c<br>M src/openvpn/mtu.h<=
br>M src/openvpn/mudp.c<br>M src/openvpn/mudp.h<br>M src/openvpn/multi.c<br=
>M src/openvpn/multi.h<br>M src/openvpn/multi_io.c<br>M src/openvpn/multi_i=
o.h<br>M src/openvpn/networking.h<br>M src/openvpn/networking_iproute2.c<br=
>M src/openvpn/networking_iproute2.h<br>M src/openvpn/networking_sitnl.c<br=
>M src/openvpn/networking_sitnl.h<br>M src/openvpn/ntlm.c<br>M src/openvpn/=
occ.c<br>M src/openvpn/occ.h<br>M src/openvpn/openssl_compat.h<br>M src/ope=
nvpn/openvpn.c<br>M src/openvpn/openvpn.h<br>M src/openvpn/options.c<br>M s=
rc/openvpn/options.h<br>M src/openvpn/options_util.c<br>M src/openvpn/optio=
ns_util.h<br>M src/openvpn/otime.c<br>M src/openvpn/otime.h<br>M src/openvp=
n/ovpn_dco_win.h<br>M src/openvpn/packet_id.c<br>M src/openvpn/packet_id.h<=
br>M src/openvpn/perf.c<br>M src/openvpn/perf.h<br>M src/openvpn/ping.c<br>=
M src/openvpn/ping.h<br>M src/openvpn/pkcs11.c<br>M src/openvpn/pkcs11.h<br=
>M src/openvpn/pkcs11_backend.h<br>M src/openvpn/pkcs11_mbedtls.c<br>M src/=
openvpn/pkcs11_openssl.c<br>M src/openvpn/platform.c<br>M src/openvpn/platf=
orm.h<br>M src/openvpn/plugin.c<br>M src/openvpn/plugin.h<br>M src/openvpn/=
pool.c<br>M src/openvpn/pool.h<br>M src/openvpn/proto.c<br>M src/openvpn/pr=
oto.h<br>M src/openvpn/proxy.c<br>M src/openvpn/proxy.h<br>M src/openvpn/ps=
.c<br>M src/openvpn/ps.h<br>M src/openvpn/push.c<br>M src/openvpn/push.h<br=
>M src/openvpn/pushlist.h<br>M src/openvpn/reflect_filter.c<br>M src/openvp=
n/reflect_filter.h<br>M src/openvpn/reliable.c<br>M src/openvpn/reliable.h<=
br>M src/openvpn/route.c<br>M src/openvpn/route.h<br>M src/openvpn/run_comm=
and.c<br>M src/openvpn/run_command.h<br>M src/openvpn/schedule.c<br>M src/o=
penvpn/schedule.h<br>M src/openvpn/session_id.c<br>M src/openvpn/session_id=
.h<br>M src/openvpn/shaper.c<br>M src/openvpn/shaper.h<br>M src/openvpn/sig=
.c<br>M src/openvpn/sig.h<br>M src/openvpn/socket.c<br>M src/openvpn/socket=
.h<br>M src/openvpn/socks.c<br>M src/openvpn/socks.h<br>M src/openvpn/ssl.c=
<br>M src/openvpn/ssl.h<br>M src/openvpn/ssl_backend.h<br>M src/openvpn/ssl=
_common.h<br>M src/openvpn/ssl_mbedtls.c<br>M src/openvpn/ssl_mbedtls.h<br>=
M src/openvpn/ssl_ncp.c<br>M src/openvpn/ssl_ncp.h<br>M src/openvpn/ssl_ope=
nssl.c<br>M src/openvpn/ssl_openssl.h<br>M src/openvpn/ssl_pkt.c<br>M src/o=
penvpn/ssl_pkt.h<br>M src/openvpn/ssl_util.c<br>M src/openvpn/ssl_util.h<br=
>M src/openvpn/ssl_verify.c<br>M src/openvpn/ssl_verify.h<br>M src/openvpn/=
ssl_verify_backend.h<br>M src/openvpn/ssl_verify_mbedtls.c<br>M src/openvpn=
/ssl_verify_mbedtls.h<br>M src/openvpn/ssl_verify_openssl.c<br>M src/openvp=
n/ssl_verify_openssl.h<br>M src/openvpn/status.c<br>M src/openvpn/status.h<=
br>M src/openvpn/syshead.h<br>M src/openvpn/tls_crypt.c<br>M src/openvpn/tl=
s_crypt.h<br>M src/openvpn/tun.c<br>M src/openvpn/tun.h<br>M src/openvpn/tu=
n_afunix.c<br>M src/openvpn/tun_afunix.h<br>M src/openvpn/vlan.c<br>M src/o=
penvpn/vlan.h<br>M src/openvpn/wfp_block.c<br>M src/openvpn/wfp_block.h<br>=
M src/openvpn/win32-util.c<br>M src/openvpn/win32-util.h<br>M src/openvpn/w=
in32.c<br>M src/openvpn/win32.h<br>M src/openvpn/xkey_common.h<br>M src/ope=
nvpn/xkey_helper.c<br>M src/openvpn/xkey_provider.c<br>M src/openvpnmsica/M=
akefile.am<br>M src/openvpnmsica/dllmain.c<br>M src/openvpnmsica/msica_arg.=
c<br>M src/openvpnmsica/msica_arg.h<br>M src/openvpnmsica/msiex.c<br>M src/=
openvpnmsica/msiex.h<br>M src/openvpnmsica/openvpnmsica.c<br>M src/openvpnm=
sica/openvpnmsica.h<br>M src/openvpnmsica/openvpnmsica_resources.rc<br>M sr=
c/openvpnserv/common.c<br>M src/openvpnserv/interactive.c<br>M src/openvpns=
erv/service.h<br>M src/openvpnserv/validate.c<br>M src/openvpnserv/validate=
.h<br>M src/plugins/auth-pam/auth-pam.c<br>M src/plugins/auth-pam/utils.c<b=
r>M src/plugins/auth-pam/utils.h<br>M src/plugins/down-root/down-root.c<br>=
M src/tapctl/Makefile.am<br>M src/tapctl/basic.h<br>M src/tapctl/error.c<br=
>M src/tapctl/error.h<br>M src/tapctl/main.c<br>M src/tapctl/tap.c<br>M src=
/tapctl/tap.h<br>M src/tapctl/tapctl_resources.rc<br>M tests/ntlm_support.c=
<br>M tests/t_cltsrv.sh<br>M tests/t_lpback.sh<br>M tests/unit_tests/openvp=
n/cert_data.h<br>M tests/unit_tests/openvpn/mock_get_random.c<br>M tests/un=
it_tests/openvpn/mock_management.c<br>M tests/unit_tests/openvpn/mock_msg.c=
<br>M tests/unit_tests/openvpn/mock_msg.h<br>M tests/unit_tests/openvpn/moc=
k_ssl_dependencies.c<br>M tests/unit_tests/openvpn/mock_win32_execve.c<br>M=
 tests/unit_tests/openvpn/pkey_test_utils.c<br>M tests/unit_tests/openvpn/t=
est_auth_token.c<br>M tests/unit_tests/openvpn/test_buffer.c<br>M tests/uni=
t_tests/openvpn/test_common.h<br>M tests/unit_tests/openvpn/test_crypto.c<b=
r>M tests/unit_tests/openvpn/test_cryptoapi.c<br>M tests/unit_tests/openvpn=
/test_misc.c<br>M tests/unit_tests/openvpn/test_ncp.c<br>M tests/unit_tests=
/openvpn/test_packet_id.c<br>M tests/unit_tests/openvpn/test_pkcs11.c<br>M =
tests/unit_tests/openvpn/test_pkt.c<br>M tests/unit_tests/openvpn/test_prov=
ider.c<br>M tests/unit_tests/openvpn/test_ssl.c<br>M tests/unit_tests/openv=
pn/test_tls_crypt.c<br>M tests/unit_tests/openvpn/test_user_pass.c<br>288 f=
iles changed, 288 insertions(+), 578 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/24/1124/3</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/Makefile.am b/Makefile.am</span><br><span>index 8a28149..a62200d 1006=
44</span><br><span>--- a/Makefile.am</span><br><span>+++ b/Makefile.am</spa=
n><br><span>@@ -19,8 +19,7 @@</span><br><span> #  GNU General Public Licens=
e for more details.</span><br><span> #</span><br><span> #  You should have =
received a copy of the GNU General Public License along</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#  with this program; if not, write to th=
e Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  with this program=
; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span> #</sp=
an><br><span> </span><br><span> ACLOCAL_AMFLAGS =3D -I m4</span><br><span>d=
iff --git a/compat.m4 b/compat.m4</span><br><span>index 8fa9abe..2cf9844 10=
0644</span><br><span>--- a/compat.m4</span><br><span>+++ b/compat.m4</span>=
<br><span>@@ -17,8 +17,7 @@</span><br><span> dnl  GNU General Public Licens=
e for more details.</span><br><span> dnl</span><br><span> dnl  You should h=
ave received a copy of the GNU General Public License along</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-dnl  with this program; if not, write=
 to the Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-dnl  51 Franklin Street, Fifth Floor, Boston, MA 02110-13=
01 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dnl  with th=
is program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><s=
pan> </span><br><span> dnl Compatibility layer for &lt;autoconf-2.60 &lt;au=
tomake-1.10</span><br><span> dnl REMOVE THIS IN FUTURE!</span><br><span>dif=
f --git a/configure.ac b/configure.ac</span><br><span>index 66cb79b..705987=
1 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/configure=
.ac</span><br><span>@@ -18,8 +18,7 @@</span><br><span> dnl  GNU General Pub=
lic License for more details.</span><br><span> dnl</span><br><span> dnl  Yo=
u should have received a copy of the GNU General Public License along</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-dnl  with this program; if =
not, write to the Free Software Foundation, Inc.,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-dnl  51 Franklin Street, Fifth Floor, Boston, M=
A 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dn=
l  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</s=
pan><br><span> </span><br><span> dnl Process this file with autoconf to pro=
duce a configure script.</span><br><span> </span><br><span>diff --git a/con=
trib/cmake/git-version.py b/contrib/cmake/git-version.py</span><br><span>in=
dex a89b039..fc390f3 100644</span><br><span>--- a/contrib/cmake/git-version=
.py</span><br><span>+++ b/contrib/cmake/git-version.py</span><br><span>@@ -=
18,8 +18,7 @@</span><br><span> #  GNU General Public License for more detai=
ls.</span><br><span> #</span><br><span> #  You should have received a copy =
of the GNU General Public License along</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#  with this program; if not, write to the Free Software =
Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  5=
1 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#  with this program; if not, see &l=
t;https://www.gnu.org/licenses/&gt;.</span><br><span> #</span><br><span> </=
span><br><span> # Usage: ./git-version.py [directory]</span><br><span>diff =
--git a/contrib/cmake/parse-version.m4.py b/contrib/cmake/parse-version.m4.=
py</span><br><span>index 6297b92..8c95ffc 100644</span><br><span>--- a/cont=
rib/cmake/parse-version.m4.py</span><br><span>+++ b/contrib/cmake/parse-ver=
sion.m4.py</span><br><span>@@ -18,8 +18,7 @@</span><br><span> #  GNU Genera=
l Public License for more details.</span><br><span> #</span><br><span> #  Y=
ou should have received a copy of the GNU General Public License along</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#  with this program; if n=
ot, write to the Free Software Foundation, Inc.,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#  51 Franklin Street, Fifth Floor, Boston, MA 0=
2110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  wi=
th this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><=
br><span> #</span><br><span> </span><br><span> # Usage: ./parse-version.m4.=
py m4file [directory]</span><br><span>diff --git a/dev-tools/gen-release-ta=
rballs.sh b/dev-tools/gen-release-tarballs.sh</span><br><span>index 6262dd4=
..7b97aa6 100755</span><br><span>--- a/dev-tools/gen-release-tarballs.sh</s=
pan><br><span>+++ b/dev-tools/gen-release-tarballs.sh</span><br><span>@@ -1=
4,8 +14,7 @@</span><br><span> # GNU General Public License for more details=
.</span><br><span> #</span><br><span> # You should have received a copy of =
the GNU General Public License</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-# along with this program; if not, write to the Free Software</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-# Foundation, Inc., 51 Fra=
nklin Street, Fifth Floor, Boston, MA  02110-1301, USA.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# along with this program; if not, see =
&lt;https://www.gnu.org/licenses/&gt;.</span><br><span> #</span><br><span> =
set -u</span><br><span> </span><br><span>diff --git a/dev-tools/gerrit-send=
-mail.py b/dev-tools/gerrit-send-mail.py</span><br><span>index ec1b2bc..0b4=
9ae9 100755</span><br><span>--- a/dev-tools/gerrit-send-mail.py</span><br><=
span>+++ b/dev-tools/gerrit-send-mail.py</span><br><span>@@ -13,8 +13,7 @@<=
/span><br><span> #  GNU General Public License for more details.</span><br>=
<span> #</span><br><span> #  You should have received a copy of the GNU Gen=
eral Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#  with this program; if not, write to the Free Software Foundation, In=
c.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  51 Franklin Str=
eet, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#  with this program; if not, see &lt;https://www.=
gnu.org/licenses/&gt;.</span><br><span> </span><br><span> # Extract a patch=
 from Gerrit and transform it in a file suitable as input</span><br><span> =
# for git send-email.</span><br><span>diff --git a/dev-tools/reformat-all.s=
h b/dev-tools/reformat-all.sh</span><br><span>index 02421c1..0a31a83 100755=
</span><br><span>--- a/dev-tools/reformat-all.sh</span><br><span>+++ b/dev-=
tools/reformat-all.sh</span><br><span>@@ -15,8 +15,7 @@</span><br><span> # =
GNU General Public License for more details.</span><br><span> #</span><br><=
span> # You should have received a copy of the GNU General Public License</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-# along with this progr=
am; if not, write to the Free Software</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Bosto=
n, MA  02110-1301, USA.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# along with this program; if not, see &lt;https://www.gnu.org/licenses=
/&gt;.</span><br><span> #</span><br><span> </span><br><span> tstamp=3D&quot=
;$(date +%Y%m%d-%H%M%S)&quot;</span><br><span>diff --git a/dev-tools/update=
-copyright.sh b/dev-tools/update-copyright.sh</span><br><span>index f6c8cdf=
..d19343f 100755</span><br><span>--- a/dev-tools/update-copyright.sh</span>=
<br><span>+++ b/dev-tools/update-copyright.sh</span><br><span>@@ -16,8 +16,=
7 @@</span><br><span> # GNU General Public License for more details.</span>=
<br><span> #</span><br><span> # You should have received a copy of the GNU =
General Public License</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-# along with this program; if not, write to the Free Software</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-# Foundation, Inc., 51 Franklin St=
reet, Fifth Floor, Boston, MA  02110-1301, USA.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# along with this program; if not, see &lt;http=
s://www.gnu.org/licenses/&gt;.</span><br><span> #</span><br><span> </span><=
br><span> # Basic shell sanity</span><br><span>diff --git a/doc/doxygen/doc=
_compression.h b/doc/doxygen/doc_compression.h</span><br><span>index c5678b=
e..d5a1bd9 100644</span><br><span>--- a/doc/doxygen/doc_compression.h</span=
><br><span>+++ b/doc/doxygen/doc_compression.h</span><br><span>@@ -18,8 +18=
,7 @@</span><br><span>  *  GNU General Public License for more details.</sp=
an><br><span>  *</span><br><span>  *  You should have received a copy of th=
e GNU General Public License along</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *  with this program; if not, write to the Free Software Foun=
dation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 F=
ranklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;=
https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </=
span><br><span> /**</span><br><span>diff --git a/doc/doxygen/doc_control_pr=
ocessor.h b/doc/doxygen/doc_control_processor.h</span><br><span>index 3e9c5=
92..03549e2 100644</span><br><span>--- a/doc/doxygen/doc_control_processor.=
h</span><br><span>+++ b/doc/doxygen/doc_control_processor.h</span><br><span=
>@@ -18,8 +18,7 @@</span><br><span>  *  GNU General Public License for more=
 details.</span><br><span>  *</span><br><span>  *  You should have received=
 a copy of the GNU General Public License along</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Free =
Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if =
not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span>=
<br><span> </span><br><span> /**</span><br><span>diff --git a/doc/doxygen/d=
oc_control_tls.h b/doc/doxygen/doc_control_tls.h</span><br><span>index 3c92=
a76..c6bbfe6 100644</span><br><span>--- a/doc/doxygen/doc_control_tls.h</sp=
an><br><span>+++ b/doc/doxygen/doc_control_tls.h</span><br><span>@@ -18,8 +=
18,7 @@</span><br><span>  *  GNU General Public License for more details.</=
span><br><span>  *</span><br><span>  *  You should have received a copy of =
the GNU General Public License along</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *  with this program; if not, write to the Free Software Fo=
undation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51=
 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &l=
t;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> =
</span><br><span> /**</span><br><span>diff --git a/doc/doxygen/doc_data_con=
trol.h b/doc/doxygen/doc_data_control.h</span><br><span>index ccb0117..0101=
55b 100644</span><br><span>--- a/doc/doxygen/doc_data_control.h</span><br><=
span>+++ b/doc/doxygen/doc_data_control.h</span><br><span>@@ -18,8 +18,7 @@=
</span><br><span>  *  GNU General Public License for more details.</span><b=
r><span>  *</span><br><span>  *  You should have received a copy of the GNU=
 General Public License along</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *  with this program; if not, write to the Free Software Foundatio=
n, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Frankl=
in Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https=
://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span>=
<br><span> /**</span><br><span>diff --git a/doc/doxygen/doc_data_crypto.h b=
/doc/doxygen/doc_data_crypto.h</span><br><span>index 165ce44..b2e50ab 10064=
4</span><br><span>--- a/doc/doxygen/doc_data_crypto.h</span><br><span>+++ b=
/doc/doxygen/doc_data_crypto.h</span><br><span>@@ -18,8 +18,7 @@</span><br>=
<span>  *  GNU General Public License for more details.</span><br><span>  *=
</span><br><span>  *  You should have received a copy of the GNU General Pu=
blic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
 with this program; if not, write to the Free Software Foundation, Inc.,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, =
Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.=
org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> =
/**</span><br><span>diff --git a/doc/doxygen/doc_eventloop.h b/doc/doxygen/=
doc_eventloop.h</span><br><span>index 48d0c50..ec60afb 100644</span><br><sp=
an>--- a/doc/doxygen/doc_eventloop.h</span><br><span>+++ b/doc/doxygen/doc_=
eventloop.h</span><br><span>@@ -18,8 +18,7 @@</span><br><span>  *  GNU Gene=
ral Public License for more details.</span><br><span>  *</span><br><span>  =
*  You should have received a copy of the GNU General Public License along<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program;=
 if not, write to the Free Software Foundation, Inc.,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston=
, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.<=
/span><br><span>  */</span><br><span> </span><br><span> /**</span><br><span=
>diff --git a/doc/doxygen/doc_external_multiplexer.h b/doc/doxygen/doc_exte=
rnal_multiplexer.h</span><br><span>index 61b2d8f..15ae8bb 100644</span><br>=
<span>--- a/doc/doxygen/doc_external_multiplexer.h</span><br><span>+++ b/do=
c/doxygen/doc_external_multiplexer.h</span><br><span>@@ -18,8 +18,7 @@</spa=
n><br><span>  *  GNU General Public License for more details.</span><br><sp=
an>  *</span><br><span>  *  You should have received a copy of the GNU Gene=
ral Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *  with this program; if not, write to the Free Software Foundation, In=
c.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin St=
reet, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://ww=
w.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><=
span> /**</span><br><span>diff --git a/doc/doxygen/doc_fragmentation.h b/do=
c/doxygen/doc_fragmentation.h</span><br><span>index 03b6310..02d8cb2 100644=
</span><br><span>--- a/doc/doxygen/doc_fragmentation.h</span><br><span>+++ =
b/doc/doxygen/doc_fragmentation.h</span><br><span>@@ -18,8 +18,7 @@</span><=
br><span>  *  GNU General Public License for more details.</span><br><span>=
  *</span><br><span>  *  You should have received a copy of the GNU General=
 Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *  with this program; if not, write to the Free Software Foundation, Inc.,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Stree=
t, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.g=
nu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><spa=
n> /**</span><br><span>diff --git a/doc/doxygen/doc_internal_multiplexer.h =
b/doc/doxygen/doc_internal_multiplexer.h</span><br><span>index 0085fbf..3da=
2df8 100644</span><br><span>--- a/doc/doxygen/doc_internal_multiplexer.h</s=
pan><br><span>+++ b/doc/doxygen/doc_internal_multiplexer.h</span><br><span>=
@@ -18,8 +18,7 @@</span><br><span>  *  GNU General Public License for more =
details.</span><br><span>  *</span><br><span>  *  You should have received =
a copy of the GNU General Public License along</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Free S=
oftware Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if n=
ot, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><=
br><span> </span><br><span> /**</span><br><span>diff --git a/doc/doxygen/do=
c_key_generation.h b/doc/doxygen/doc_key_generation.h</span><br><span>index=
 91c7a5a..766f433 100644</span><br><span>--- a/doc/doxygen/doc_key_generati=
on.h</span><br><span>+++ b/doc/doxygen/doc_key_generation.h</span><br><span=
>@@ -18,8 +18,7 @@</span><br><span>  *  GNU General Public License for more=
 details.</span><br><span>  *</span><br><span>  *  You should have received=
 a copy of the GNU General Public License along</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Free =
Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if =
not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span>=
<br><span> </span><br><span> /**</span><br><span>diff --git a/doc/doxygen/d=
oc_mainpage.h b/doc/doxygen/doc_mainpage.h</span><br><span>index 7b1b80e..2=
5fd40e 100644</span><br><span>--- a/doc/doxygen/doc_mainpage.h</span><br><s=
pan>+++ b/doc/doxygen/doc_mainpage.h</span><br><span>@@ -18,8 +18,7 @@</spa=
n><br><span>  *  GNU General Public License for more details.</span><br><sp=
an>  *</span><br><span>  *  You should have received a copy of the GNU Gene=
ral Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *  with this program; if not, write to the Free Software Foundation, In=
c.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin St=
reet, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://ww=
w.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><=
span> /**</span><br><span>diff --git a/doc/doxygen/doc_memory_management.h =
b/doc/doxygen/doc_memory_management.h</span><br><span>index 27d9188..5e9a93=
0 100644</span><br><span>--- a/doc/doxygen/doc_memory_management.h</span><b=
r><span>+++ b/doc/doxygen/doc_memory_management.h</span><br><span>@@ -18,8 =
+18,7 @@</span><br><span>  *  GNU General Public License for more details.<=
/span><br><span>  *</span><br><span>  *  You should have received a copy of=
 the GNU General Public License along</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- *  with this program; if not, write to the Free Software F=
oundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  5=
1 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &=
lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span>=
 </span><br><span> /**</span><br><span>diff --git a/doc/doxygen/doc_protoco=
l_overview.h b/doc/doxygen/doc_protocol_overview.h</span><br><span>index 65=
a9c85..a6e9369 100644</span><br><span>--- a/doc/doxygen/doc_protocol_overvi=
ew.h</span><br><span>+++ b/doc/doxygen/doc_protocol_overview.h</span><br><s=
pan>@@ -18,8 +18,7 @@</span><br><span>  *  GNU General Public License for m=
ore details.</span><br><span>  *</span><br><span>  *  You should have recei=
ved a copy of the GNU General Public License along</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Fr=
ee Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; =
if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</sp=
an><br><span> </span><br><span> /**</span><br><span>diff --git a/doc/doxyge=
n/doc_reliable.h b/doc/doxygen/doc_reliable.h</span><br><span>index 5718699=
..e9a8b06 100644</span><br><span>--- a/doc/doxygen/doc_reliable.h</span><br=
><span>+++ b/doc/doxygen/doc_reliable.h</span><br><span>@@ -18,8 +18,7 @@</=
span><br><span>  *  GNU General Public License for more details.</span><br>=
<span>  *</span><br><span>  *  You should have received a copy of the GNU G=
eneral Public License along</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *  with this program; if not, write to the Free Software Foundation,=
 Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin=
 Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https:/=
/www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><b=
r><span> /**</span><br><span>diff --git a/doc/doxygen/doc_tunnel_state.h b/=
doc/doxygen/doc_tunnel_state.h</span><br><span>index cbc1fa2..04a48f3 10064=
4</span><br><span>--- a/doc/doxygen/doc_tunnel_state.h</span><br><span>+++ =
b/doc/doxygen/doc_tunnel_state.h</span><br><span>@@ -18,8 +18,7 @@</span><b=
r><span>  *  GNU General Public License for more details.</span><br><span> =
 *</span><br><span>  *  You should have received a copy of the GNU General =
Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*  with this program; if not, write to the Free Software Foundation, Inc.,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street=
, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gn=
u.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span=
> /**</span><br><span>diff --git a/include/openvpn-msg.h b/include/openvpn-=
msg.h</span><br><span>index e0d0bb0..106a274 100644</span><br><span>--- a/i=
nclude/openvpn-msg.h</span><br><span>+++ b/include/openvpn-msg.h</span><br>=
<span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License for=
 more details.</span><br><span>  *</span><br><span>  *  You should have rec=
eived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to the=
 Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progra=
m; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */<=
/span><br><span> </span><br><span> #ifndef OPENVPN_MSG_H_</span><br><span>d=
iff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in</span=
><br><span>index 4d270da..0bf88fc 100644</span><br><span>--- a/include/open=
vpn-plugin.h.in</span><br><span>+++ b/include/openvpn-plugin.h.in</span><br=
><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License fo=
r more details.</span><br><span>  *</span><br><span>  *  You should have re=
ceived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to the=
 Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progra=
m; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */<=
/span><br><span> </span><br><span> #ifndef OPENVPN_PLUGIN_H_</span><br><spa=
n>diff --git a/sample/sample-plugins/client-connect/sample-client-connect.c=
 b/sample/sample-plugins/client-connect/sample-client-connect.c</span><br><=
span>index 5194270..3dda782 100644</span><br><span>--- a/sample/sample-plug=
ins/client-connect/sample-client-connect.c</span><br><span>+++ b/sample/sam=
ple-plugins/client-connect/sample-client-connect.c</span><br><span>@@ -17,8=
 +17,7 @@</span><br><span>  *  GNU General Public License for more details.=
</span><br><span>  *</span><br><span>  *  You should have received a copy o=
f the GNU General Public License along</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *  with this program; if not, write to the Free Software =
Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see =
&lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span=
> </span><br><span> /*</span><br><span>diff --git a/sample/sample-plugins/d=
efer/multi-auth.c b/sample/sample-plugins/defer/multi-auth.c</span><br><spa=
n>index c458346..9a2cb13 100644</span><br><span>--- a/sample/sample-plugins=
/defer/multi-auth.c</span><br><span>+++ b/sample/sample-plugins/defer/multi=
-auth.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General =
Public License for more details.</span><br><span>  *</span><br><span>  *  Y=
ou should have received a copy of the GNU General Public License along</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if =
not, write to the Free Software Foundation, Inc.,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA=
 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</spa=
n><br><span>  */</span><br><span> </span><br><span> /*</span><br><span>diff=
 --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterial=
exporter.c b/sample/sample-plugins/keying-material-exporter-demo/keyingmate=
rialexporter.c</span><br><span>index f1f8868..b73144f 100644</span><br><spa=
n>--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmateriale=
xporter.c</span><br><span>+++ b/sample/sample-plugins/keying-material-expor=
ter-demo/keyingmaterialexporter.c</span><br><span>@@ -17,8 +17,7 @@</span><=
br><span>  *  GNU General Public License for more details.</span><br><span>=
  *</span><br><span>  *  You should have received a copy of the GNU General=
 Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *  with this program; if not, write to the Free Software Foundation, Inc.,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Stree=
t, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.g=
nu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><spa=
n> /*</span><br><span>diff --git a/sample/sample-plugins/log/log.c b/sample=
/sample-plugins/log/log.c</span><br><span>index b304f16..63d714f 100644</sp=
an><br><span>--- a/sample/sample-plugins/log/log.c</span><br><span>+++ b/sa=
mple/sample-plugins/log/log.c</span><br><span>@@ -17,8 +17,7 @@</span><br><=
span>  *  GNU General Public License for more details.</span><br><span>  *<=
/span><br><span>  *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
with this program; if not, write to the Free Software Foundation, Inc.,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, F=
ifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.o=
rg/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> /=
*</span><br><span>diff --git a/sample/sample-plugins/log/log_v3.c b/sample/=
sample-plugins/log/log_v3.c</span><br><span>index a024027..02cdda8 100644</=
span><br><span>--- a/sample/sample-plugins/log/log_v3.c</span><br><span>+++=
 b/sample/sample-plugins/log/log_v3.c</span><br><span>@@ -18,8 +18,7 @@</sp=
an><br><span>  *  GNU General Public License for more details.</span><br><s=
pan>  *</span><br><span>  *  You should have received a copy of the GNU Gen=
eral Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *  with this program; if not, write to the Free Software Foundation, I=
nc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin S=
treet, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://w=
ww.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br>=
<span> /*</span><br><span>diff --git a/sample/sample-plugins/simple/base64.=
c b/sample/sample-plugins/simple/base64.c</span><br><span>index e1cc791..b6=
c0c97 100644</span><br><span>--- a/sample/sample-plugins/simple/base64.c</s=
pan><br><span>+++ b/sample/sample-plugins/simple/base64.c</span><br><span>@=
@ -18,8 +18,7 @@</span><br><span>  *</span><br><span>  *  You should have r=
eceived a copy of the GNU General Public License</span><br><span>  *  along=
 with this program (see the file COPYING included with this</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *  distribution); if not, write to t=
he Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  distribution); if =
not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span>=
<br><span> </span><br><span> #include &lt;stdio.h&gt;</span><br><span>diff =
--git a/sample/sample-plugins/simple/simple.c b/sample/sample-plugins/simpl=
e/simple.c</span><br><span>index 2c096e2..ed5bce5 100644</span><br><span>--=
- a/sample/sample-plugins/simple/simple.c</span><br><span>+++ b/sample/samp=
le-plugins/simple/simple.c</span><br><span>@@ -17,8 +17,7 @@</span><br><spa=
n>  *  GNU General Public License for more details.</span><br><span>  *</sp=
an><br><span>  *  You should have received a copy of the GNU General Public=
 License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  wit=
h this program; if not, write to the Free Software Foundation, Inc.,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fift=
h Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.org/=
licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> /*</=
span><br><span>diff --git a/src/compat/compat-basename.c b/src/compat/compa=
t-basename.c</span><br><span>index abb4f49..18944f6 100644</span><br><span>=
--- a/src/compat/compat-basename.c</span><br><span>+++ b/src/compat/compat-=
basename.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU Gener=
al Public License for more details.</span><br><span>  *</span><br><span>  *=
  You should have received a copy of the GNU General Public License along</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; =
if not, write to the Free Software Foundation, Inc.,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston=
, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.<=
/span><br><span>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_=
H</span><br><span>diff --git a/src/compat/compat-daemon.c b/src/compat/comp=
at-daemon.c</span><br><span>index 5c6d740..8eb76ee 100644</span><br><span>-=
-- a/src/compat/compat-daemon.c</span><br><span>+++ b/src/compat/compat-dae=
mon.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Pu=
blic License for more details.</span><br><span>  *</span><br><span>  *  You=
 should have received a copy of the GNU General Public License along</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if no=
t, write to the Free Software Foundation, Inc.,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 0=
2110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  w=
ith this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span>=
<br><span>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</spa=
n><br><span>diff --git a/src/compat/compat-dirname.c b/src/compat/compat-di=
rname.c</span><br><span>index c131dee..17de8ad 100644</span><br><span>--- a=
/src/compat/compat-dirname.c</span><br><span>+++ b/src/compat/compat-dirnam=
e.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Publ=
ic License for more details.</span><br><span>  *</span><br><span>  *  You s=
hould have received a copy of the GNU General Public License along</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not,=
 write to the Free Software Foundation, Inc.,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 021=
10-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  wit=
h this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><b=
r><span>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span>=
<br><span>diff --git a/src/compat/compat-gettimeofday.c b/src/compat/compat=
-gettimeofday.c</span><br><span>index 997f360..de53cb5 100644</span><br><sp=
an>--- a/src/compat/compat-gettimeofday.c</span><br><span>+++ b/src/compat/=
compat-gettimeofday.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *=
  GNU General Public License for more details.</span><br><span>  *</span><b=
r><span>  *  You should have received a copy of the GNU General Public Lice=
nse along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with thi=
s program; if not, write to the Free Software Foundation, Inc.,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Flo=
or, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.org/licen=
ses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> #ifdef HA=
VE_CONFIG_H</span><br><span>diff --git a/src/compat/compat-strsep.c b/src/c=
ompat/compat-strsep.c</span><br><span>index 25eae0c..3efe0bf 100644</span><=
br><span>--- a/src/compat/compat-strsep.c</span><br><span>+++ b/src/compat/=
compat-strsep.c</span><br><span>@@ -18,8 +18,7 @@</span><br><span>  *  GNU =
General Public License for more details.</span><br><span>  *</span><br><spa=
n>  *  You should have received a copy of the GNU General Public License al=
ong</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this prog=
ram; if not, write to the Free Software Foundation, Inc.,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Bo=
ston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&g=
t;.</span><br><span>  */</span><br><span> </span><br><span> #ifdef HAVE_CON=
FIG_H</span><br><span>diff --git a/src/compat/compat.h b/src/compat/compat.=
h</span><br><span>index 026974a..6532b86 100644</span><br><span>--- a/src/c=
ompat/compat.h</span><br><span>+++ b/src/compat/compat.h</span><br><span>@@=
 -17,8 +17,7 @@</span><br><span>  *  GNU General Public License for more de=
tails.</span><br><span>  *</span><br><span>  *  You should have received a =
copy of the GNU General Public License along</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Free Sof=
tware Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not=
, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br=
><span> </span><br><span> #ifndef COMPAT_H</span><br><span>diff --git a/src=
/openvpn/argv.c b/src/openvpn/argv.c</span><br><span>index 95215c0..34266d4=
 100644</span><br><span>--- a/src/openvpn/argv.c</span><br><span>+++ b/src/=
openvpn/argv.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU G=
eneral Public License for more details.</span><br><span>  *</span><br><span=
>  *  You should have received a copy of the GNU General Public License alo=
ng</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this progr=
am; if not, write to the Free Software Foundation, Inc.,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Bos=
ton, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt=
;.</span><br><span>  *</span><br><span>  *</span><br><span>  *  A printf-li=
ke function (that only recognizes a subset of standard printf</span><br><sp=
an>diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h</span><br><span>ind=
ex 098a1cb..f694760 100644</span><br><span>--- a/src/openvpn/argv.h</span><=
br><span>+++ b/src/openvpn/argv.h</span><br><span>@@ -17,8 +17,7 @@</span><=
br><span>  *  GNU General Public License for more details.</span><br><span>=
  *</span><br><span>  *  You should have received a copy of the GNU General=
 Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *  with this program; if not, write to the Free Software Foundation, Inc.,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Stree=
t, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.g=
nu.org/licenses/&gt;.</span><br><span>  *</span><br><span>  *</span><br><sp=
an>  *  A printf-like function (that only recognizes a subset of standard p=
rintf</span><br><span>diff --git a/src/openvpn/auth_token.h b/src/openvpn/a=
uth_token.h</span><br><span>index 5859905..3d56ee6 100644</span><br><span>-=
-- a/src/openvpn/auth_token.h</span><br><span>+++ b/src/openvpn/auth_token.=
h</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public=
 License for more details.</span><br><span>  *</span><br><span>  *  You sho=
uld have received a copy of the GNU General Public License along</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, w=
rite to the Free Software Foundation, Inc.,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110=
-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with =
this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br>=
<span>  */</span><br><span> #ifndef AUTH_TOKEN_H</span><br><span> #define A=
UTH_TOKEN_H</span><br><span>diff --git a/src/openvpn/basic.h b/src/openvpn/=
basic.h</span><br><span>index f603ecc..47a86d9 100644</span><br><span>--- a=
/src/openvpn/basic.h</span><br><span>+++ b/src/openvpn/basic.h</span><br><s=
pan>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License for m=
ore details.</span><br><span>  *</span><br><span>  *  You should have recei=
ved a copy of the GNU General Public License along</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Fr=
ee Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; =
if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</sp=
an><br><span> </span><br><span> #ifndef BASIC_H</span><br><span>diff --git =
a/src/openvpn/buffer.c b/src/openvpn/buffer.c</span><br><span>index dd6044b=
..5940ad9 100644</span><br><span>--- a/src/openvpn/buffer.c</span><br><span=
>+++ b/src/openvpn/buffer.c</span><br><span>@@ -17,8 +17,7 @@</span><br><sp=
an>  *  GNU General Public License for more details.</span><br><span>  *</s=
pan><br><span>  *  You should have received a copy of the GNU General Publi=
c License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  wi=
th this program; if not, write to the Free Software Foundation, Inc.,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fif=
th Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.org=
/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> #if=
def HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/buffer.h b/src/o=
penvpn/buffer.h</span><br><span>index 5f2ad5d..0d5c30d 100644</span><br><sp=
an>--- a/src/openvpn/buffer.h</span><br><span>+++ b/src/openvpn/buffer.h</s=
pan><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public Lic=
ense for more details.</span><br><span>  *</span><br><span>  *  You should =
have received a copy of the GNU General Public License along</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write=
 to the Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-130=
1 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this=
 program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><spa=
n>  */</span><br><span> </span><br><span> #ifndef BUFFER_H</span><br><span>=
diff --git a/src/openvpn/circ_list.h b/src/openvpn/circ_list.h</span><br><s=
pan>index 0189c8b..cdbc8ef 100644</span><br><span>--- a/src/openvpn/circ_li=
st.h</span><br><span>+++ b/src/openvpn/circ_list.h</span><br><span>@@ -17,8=
 +17,7 @@</span><br><span>  *  GNU General Public License for more details.=
</span><br><span>  *</span><br><span>  *  You should have received a copy o=
f the GNU General Public License along</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *  with this program; if not, write to the Free Software =
Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see =
&lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span=
> </span><br><span> #ifndef CIRC_LIST_H</span><br><span>diff --git a/src/op=
envpn/clinat.c b/src/openvpn/clinat.c</span><br><span>index f040724..f120a5=
4 100644</span><br><span>--- a/src/openvpn/clinat.c</span><br><span>+++ b/s=
rc/openvpn/clinat.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  =
GNU General Public License for more details.</span><br><span>  *</span><br>=
<span>  *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this =
program; if not, write to the Free Software Foundation, Inc.,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor=
, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  with this program; if not, see &lt;https://www.gnu.org/license=
s/&gt;.</span><br><span>  */</span><br><span> </span><br><span> #ifdef HAVE=
_CONFIG_H</span><br><span>diff --git a/src/openvpn/clinat.h b/src/openvpn/c=
linat.h</span><br><span>index 334b3f2..d565a49 100644</span><br><span>--- a=
/src/openvpn/clinat.h</span><br><span>+++ b/src/openvpn/clinat.h</span><br>=
<span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License for=
 more details.</span><br><span>  *</span><br><span>  *  You should have rec=
eived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to the=
 Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progra=
m; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */<=
/span><br><span> </span><br><span> #if !defined(CLINAT_H)</span><br><span>d=
iff --git a/src/openvpn/common.h b/src/openvpn/common.h</span><br><span>ind=
ex 5d4cf2e..d7f5d959 100644</span><br><span>--- a/src/openvpn/common.h</spa=
n><br><span>+++ b/src/openvpn/common.h</span><br><span>@@ -17,8 +17,7 @@</s=
pan><br><span>  *  GNU General Public License for more details.</span><br><=
span>  *</span><br><span>  *  You should have received a copy of the GNU Ge=
neral Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *  with this program; if not, write to the Free Software Foundation, =
Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin =
Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://=
www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br=
><span> #ifndef COMMON_H</span><br><span>diff --git a/src/openvpn/comp-lz4.=
c b/src/openvpn/comp-lz4.c</span><br><span>index ab37164..425b1d9 100644</s=
pan><br><span>--- a/src/openvpn/comp-lz4.c</span><br><span>+++ b/src/openvp=
n/comp-lz4.c</span><br><span>@@ -18,8 +18,7 @@</span><br><span>  *  GNU Gen=
eral Public License for more details.</span><br><span>  *</span><br><span> =
 *  You should have received a copy of the GNU General Public License along=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program=
; if not, write to the Free Software Foundation, Inc.,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Bosto=
n, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.=
</span><br><span>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG=
_H</span><br><span>diff --git a/src/openvpn/comp-lz4.h b/src/openvpn/comp-l=
z4.h</span><br><span>index 09d0dc7..fb22c12 100644</span><br><span>--- a/sr=
c/openvpn/comp-lz4.h</span><br><span>+++ b/src/openvpn/comp-lz4.h</span><br=
><span>@@ -18,8 +18,7 @@</span><br><span>  *  GNU General Public License fo=
r more details.</span><br><span>  *</span><br><span>  *  You should have re=
ceived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to the=
 Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progra=
m; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */<=
/span><br><span> </span><br><span> #ifndef OPENVPN_COMP_LZ4_H</span><br><sp=
an>diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c</span><br><span>ind=
ex b2aa07e..afea948 100644</span><br><span>--- a/src/openvpn/comp.c</span><=
br><span>+++ b/src/openvpn/comp.c</span><br><span>@@ -17,8 +17,7 @@</span><=
br><span>  *  GNU General Public License for more details.</span><br><span>=
  *</span><br><span>  *  You should have received a copy of the GNU General=
 Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *  with this program; if not, write to the Free Software Foundation, Inc.,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Stree=
t, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.g=
nu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><spa=
n> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/comp.h b/s=
rc/openvpn/comp.h</span><br><span>index 0bb0d32..a1c885b 100644</span><br><=
span>--- a/src/openvpn/comp.h</span><br><span>+++ b/src/openvpn/comp.h</spa=
n><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public Licen=
se for more details.</span><br><span>  *</span><br><span>  *  You should ha=
ve received a copy of the GNU General Public License along</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write t=
o the Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 =
USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this p=
rogram; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>=
  */</span><br><span> </span><br><span> /*</span><br><span>diff --git a/src=
/openvpn/compstub.c b/src/openvpn/compstub.c</span><br><span>index 109d691.=
.853e9ee 100644</span><br><span>--- a/src/openvpn/compstub.c</span><br><spa=
n>+++ b/src/openvpn/compstub.c</span><br><span>@@ -17,8 +17,7 @@</span><br>=
<span>  *  GNU General Public License for more details.</span><br><span>  *=
</span><br><span>  *  You should have received a copy of the GNU General Pu=
blic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
 with this program; if not, write to the Free Software Foundation, Inc.,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, =
Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.=
org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> =
#ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/console.c b/s=
rc/openvpn/console.c</span><br><span>index 617e146..7cc4fff 100644</span><b=
r><span>--- a/src/openvpn/console.c</span><br><span>+++ b/src/openvpn/conso=
le.c</span><br><span>@@ -19,8 +19,7 @@</span><br><span>  *  GNU General Pub=
lic License for more details.</span><br><span>  *</span><br><span>  *  You =
should have received a copy of the GNU General Public License along</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not=
, write to the Free Software Foundation, Inc.,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02=
110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  wi=
th this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><=
br><span>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span=
><br><span>diff --git a/src/openvpn/console.h b/src/openvpn/console.h</span=
><br><span>index 589f778..3e99776 100644</span><br><span>--- a/src/openvpn/=
console.h</span><br><span>+++ b/src/openvpn/console.h</span><br><span>@@ -1=
9,8 +19,7 @@</span><br><span>  *  GNU General Public License for more detai=
ls.</span><br><span>  *</span><br><span>  *  You should have received a cop=
y of the GNU General Public License along</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *  with this program; if not, write to the Free Softwa=
re Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, s=
ee &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><s=
pan> </span><br><span> #ifndef CONSOLE_H</span><br><span>diff --git a/src/o=
penvpn/console_builtin.c b/src/openvpn/console_builtin.c</span><br><span>in=
dex ba61d3f..b6db701 100644</span><br><span>--- a/src/openvpn/console_built=
in.c</span><br><span>+++ b/src/openvpn/console_builtin.c</span><br><span>@@=
 -19,8 +19,7 @@</span><br><span>  *  GNU General Public License for more de=
tails.</span><br><span>  *</span><br><span>  *  You should have received a =
copy of the GNU General Public License along</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Free Sof=
tware Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not=
, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br=
><span> </span><br><span> /*</span><br><span>diff --git a/src/openvpn/conso=
le_systemd.c b/src/openvpn/console_systemd.c</span><br><span>index 91ebb35.=
.36103b2 100644</span><br><span>--- a/src/openvpn/console_systemd.c</span><=
br><span>+++ b/src/openvpn/console_systemd.c</span><br><span>@@ -18,8 +18,7=
 @@</span><br><span>  *  GNU General Public License for more details.</span=
><br><span>  *</span><br><span>  *  You should have received a copy of the =
GNU General Public License along</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  with this program; if not, write to the Free Software Founda=
tion, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Fra=
nklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;ht=
tps://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </sp=
an><br><span> /**</span><br><span>diff --git a/src/openvpn/crypto.c b/src/o=
penvpn/crypto.c</span><br><span>index 7564f82..1c1be46 100644</span><br><sp=
an>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn/crypto.c</s=
pan><br><span>@@ -18,8 +18,7 @@</span><br><span>  *  GNU General Public Lic=
ense for more details.</span><br><span>  *</span><br><span>  *  You should =
have received a copy of the GNU General Public License along</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write=
 to the Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-130=
1 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this=
 program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><spa=
n>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><s=
pan>diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h</span><br><spa=
n>index 68ad901..b6f3549 100644</span><br><span>--- a/src/openvpn/crypto.h<=
/span><br><span>+++ b/src/openvpn/crypto.h</span><br><span>@@ -18,8 +18,7 @=
@</span><br><span>  *  GNU General Public License for more details.</span><=
br><span>  *</span><br><span>  *  You should have received a copy of the GN=
U General Public License along</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- *  with this program; if not, write to the Free Software Foundati=
on, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Frank=
lin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;ht=
tps://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </sp=
an><br><span> /**</span><br><span>diff --git a/src/openvpn/crypto_backend.h=
 b/src/openvpn/crypto_backend.h</span><br><span>index 8bb7f47..df5bc4d 1006=
44</span><br><span>--- a/src/openvpn/crypto_backend.h</span><br><span>+++ b=
/src/openvpn/crypto_backend.h</span><br><span>@@ -18,8 +18,7 @@</span><br><=
span>  *  GNU General Public License for more details.</span><br><span>  *<=
/span><br><span>  *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
with this program; if not, write to the Free Software Foundation, Inc.,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, F=
ifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.o=
rg/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> /=
**</span><br><span>diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/cr=
ypto_epoch.c</span><br><span>index 14727c7..741ad23 100644</span><br><span>=
--- a/src/openvpn/crypto_epoch.c</span><br><span>+++ b/src/openvpn/crypto_e=
poch.c</span><br><span>@@ -19,8 +19,7 @@</span><br><span>  *  GNU General P=
ublic License for more details.</span><br><span>  *</span><br><span>  *  Yo=
u should have received a copy of the GNU General Public License along</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if n=
ot, write to the Free Software Foundation, Inc.,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA =
02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span=
><br><span>  */</span><br><span> </span><br><span> </span><br><span>diff --=
git a/src/openvpn/crypto_epoch.h b/src/openvpn/crypto_epoch.h</span><br><sp=
an>index c16f966..ff5974e 100644</span><br><span>--- a/src/openvpn/crypto_e=
poch.h</span><br><span>+++ b/src/openvpn/crypto_epoch.h</span><br><span>@@ =
-19,8 +19,7 @@</span><br><span>  *  GNU General Public License for more det=
ails.</span><br><span>  *</span><br><span>  *  You should have received a c=
opy of the GNU General Public License along</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *  with this program; if not, write to the Free Soft=
ware Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not,=
 see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br>=
<span> </span><br><span> #ifndef CRYPTO_EPOCH_H</span><br><span>diff --git =
a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c</span><br><sp=
an>index 1f3dcba..0950f6b 100644</span><br><span>--- a/src/openvpn/crypto_m=
bedtls.c</span><br><span>+++ b/src/openvpn/crypto_mbedtls.c</span><br><span=
>@@ -18,8 +18,7 @@</span><br><span>  *  GNU General Public License for more=
 details.</span><br><span>  *</span><br><span>  *  You should have received=
 a copy of the GNU General Public License along</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Free =
Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if =
not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span>=
<br><span> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/c=
rypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h</span><br><span>index 6575ba=
d..620732e 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls.h</span>=
<br><span>+++ b/src/openvpn/crypto_mbedtls.h</span><br><span>@@ -18,8 +18,7=
 @@</span><br><span>  *  GNU General Public License for more details.</span=
><br><span>  *</span><br><span>  *  You should have received a copy of the =
GNU General Public License along</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  with this program; if not, write to the Free Software Founda=
tion, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Fra=
nklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;ht=
tps://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </sp=
an><br><span> /**</span><br><span>diff --git a/src/openvpn/crypto_openssl.c=
 b/src/openvpn/crypto_openssl.c</span><br><span>index 88b3580..2e7bd63 1006=
44</span><br><span>--- a/src/openvpn/crypto_openssl.c</span><br><span>+++ b=
/src/openvpn/crypto_openssl.c</span><br><span>@@ -18,8 +18,7 @@</span><br><=
span>  *  GNU General Public License for more details.</span><br><span>  *<=
/span><br><span>  *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
with this program; if not, write to the Free Software Foundation, Inc.,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, F=
ifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.o=
rg/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> /=
**</span><br><span>diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/=
crypto_openssl.h</span><br><span>index 85f53f6..9680c18 100644</span><br><s=
pan>--- a/src/openvpn/crypto_openssl.h</span><br><span>+++ b/src/openvpn/cr=
ypto_openssl.h</span><br><span>@@ -18,8 +18,7 @@</span><br><span>  *  GNU G=
eneral Public License for more details.</span><br><span>  *</span><br><span=
>  *  You should have received a copy of the GNU General Public License alo=
ng</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this progr=
am; if not, write to the Free Software Foundation, Inc.,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Bos=
ton, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt=
;.</span><br><span>  */</span><br><span> </span><br><span> /**</span><br><s=
pan>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>inde=
x 98cbb72..df70e87 100644</span><br><span>--- a/src/openvpn/dco.c</span><br=
><span>+++ b/src/openvpn/dco.c</span><br><span>@@ -20,8 +20,7 @@</span><br>=
<span>  *</span><br><span>  *  You should have received a copy of the GNU G=
eneral Public License</span><br><span>  *  along with this program (see the=
 file COPYING included with this</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  distribution); if not, write to the Free Software Foundation=
, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  59 Temple =
Place, Suite 330, Boston, MA  02111-1307  USA</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  distribution); if not, see &lt;https://www.gn=
u.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span=
> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/dco.h b/src=
/openvpn/dco.h</span><br><span>index 2ce0eb1..95abf71 100644</span><br><spa=
n>--- a/src/openvpn/dco.h</span><br><span>+++ b/src/openvpn/dco.h</span><br=
><span>@@ -20,8 +20,7 @@</span><br><span>  *</span><br><span>  *  You shoul=
d have received a copy of the GNU General Public License</span><br><span>  =
*  along with this program (see the file COPYING included with this</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *  distribution); if not, wr=
ite to the Free Software Foundation, Inc.,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *  59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  distributi=
on); if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  *=
/</span><br><span> #ifndef DCO_H</span><br><span> #define DCO_H</span><br><=
span>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</sp=
an><br><span>index 488665f..04c1e3d 100644</span><br><span>--- a/src/openvp=
n/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><=
span>@@ -14,8 +14,7 @@</span><br><span>  *</span><br><span>  *  You should =
have received a copy of the GNU General Public License</span><br><span>  * =
 along with this program (see the file COPYING included with this</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *  distribution); if not, writ=
e to the Free Software Foundation, Inc.,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  =
USA</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  distribution=
); if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */<=
/span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>dif=
f --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h</span><br><=
span>index 69c2d05..cbb1dda 100644</span><br><span>--- a/src/openvpn/dco_fr=
eebsd.h</span><br><span>+++ b/src/openvpn/dco_freebsd.h</span><br><span>@@ =
-14,8 +14,7 @@</span><br><span>  *</span><br><span>  *  You should have rec=
eived a copy of the GNU General Public License</span><br><span>  *  along w=
ith this program (see the file COPYING included with this</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *  distribution); if not, write to the=
 Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  distribution); if no=
t, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><b=
r><span> #ifndef DCO_FREEBSD_H</span><br><span> #define DCO_FREEBSD_H</span=
><br><span>diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_intern=
al.h</span><br><span>index 27d03ef..96aa281 100644</span><br><span>--- a/sr=
c/openvpn/dco_internal.h</span><br><span>+++ b/src/openvpn/dco_internal.h</=
span><br><span>@@ -19,8 +19,7 @@</span><br><span>  *</span><br><span>  *  Y=
ou should have received a copy of the GNU General Public License</span><br>=
<span>  *  along with this program (see the file COPYING included with this=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  distribution); if=
 not, write to the Free Software Foundation, Inc.,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *  59 Temple Place, Suite 330, Boston, MA  02=
111-1307  USA</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  di=
stribution); if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><=
span>  */</span><br><span> #ifndef DCO_INTERNAL_H</span><br><span> #define =
DCO_INTERNAL_H</span><br><span>diff --git a/src/openvpn/dco_linux.c b/src/o=
penvpn/dco_linux.c</span><br><span>index 9ad3d51..ab59e3e 100644</span><br>=
<span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_l=
inux.c</span><br><span>@@ -16,8 +16,7 @@</span><br><span>  *</span><br><spa=
n>  *  You should have received a copy of the GNU General Public License</s=
pan><br><span>  *  along with this program (see the file COPYING included w=
ith this</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  distribut=
ion); if not, write to the Free Software Foundation, Inc.,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *  59 Temple Place, Suite 330, Boston=
, MA  02111-1307  USA</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  distribution); if not, see &lt;https://www.gnu.org/licenses/&gt;.</sp=
an><br><span>  */</span><br><span> </span><br><span> </span><br><span>diff =
--git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h</span><br><span>i=
ndex cc14f45..9f15199 100644</span><br><span>--- a/src/openvpn/dco_linux.h<=
/span><br><span>+++ b/src/openvpn/dco_linux.h</span><br><span>@@ -16,8 +16,=
7 @@</span><br><span>  *</span><br><span>  *  You should have received a co=
py of the GNU General Public License</span><br><span>  *  along with this p=
rogram (see the file COPYING included with this</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *  distribution); if not, write to the Free Soft=
ware Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  distribution); if not, see &lt=
;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> #=
ifndef DCO_LINUX_H</span><br><span> #define DCO_LINUX_H</span><br><span>dif=
f --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br><span>ind=
ex 995b121..d227965 100644</span><br><span>--- a/src/openvpn/dco_win.c</spa=
n><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -15,8 +15,7 @@</=
span><br><span>  *</span><br><span>  *  You should have received a copy of =
the GNU General Public License</span><br><span>  *  along with this program=
 (see the file COPYING included with this</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *  distribution); if not, write to the Free Software F=
oundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  5=
9 Temple Place, Suite 330, Boston, MA  02111-1307  USA</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  distribution); if not, see &lt;https=
://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span>=
<br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/dc=
o_win.h b/src/openvpn/dco_win.h</span><br><span>index b9d93fa..7311de8 1006=
44</span><br><span>--- a/src/openvpn/dco_win.h</span><br><span>+++ b/src/op=
envpn/dco_win.h</span><br><span>@@ -15,8 +15,7 @@</span><br><span>  *</span=
><br><span>  *  You should have received a copy of the GNU General Public L=
icense</span><br><span>  *  along with this program (see the file COPYING i=
ncluded with this</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
distribution); if not, write to the Free Software Foundation, Inc.,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *  59 Temple Place, Suite 33=
0, Boston, MA  02111-1307  USA</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  distribution); if not, see &lt;https://www.gnu.org/licenses/=
&gt;.</span><br><span>  */</span><br><span> </span><br><span> #ifndef DCO_W=
IN_H</span><br><span>diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c</=
span><br><span>index da7a932..df01412 100644</span><br><span>--- a/src/open=
vpn/dhcp.c</span><br><span>+++ b/src/openvpn/dhcp.c</span><br><span>@@ -17,=
8 +17,7 @@</span><br><span>  *  GNU General Public License for more details=
.</span><br><span>  *</span><br><span>  *  You should have received a copy =
of the GNU General Public License along</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *  with this program; if not, write to the Free Software=
 Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see=
 &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><spa=
n> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/=
openvpn/dhcp.h b/src/openvpn/dhcp.h</span><br><span>index c578c6a..34f4513 =
100644</span><br><span>--- a/src/openvpn/dhcp.h</span><br><span>+++ b/src/o=
penvpn/dhcp.h</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU Ge=
neral Public License for more details.</span><br><span>  *</span><br><span>=
  *  You should have received a copy of the GNU General Public License alon=
g</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this progra=
m; if not, write to the Free Software Foundation, Inc.,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Bost=
on, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;=
.</span><br><span>  */</span><br><span> </span><br><span> #ifndef DHCP_H</s=
pan><br><span>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br>=
<span>index ea3d91b..2952a8a 100644</span><br><span>--- a/src/openvpn/dns.c=
</span><br><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -17,8 +17,7 @@<=
/span><br><span>  *  GNU General Public License for more details.</span><br=
><span>  *</span><br><span>  *  You should have received a copy of the GNU =
General Public License along</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *  with this program; if not, write to the Free Software Foundation=
, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Frankli=
n Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https:=
//www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><=
br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/dns=
.h b/src/openvpn/dns.h</span><br><span>index d33f64e..94c76e5 100644</span>=
<br><span>--- a/src/openvpn/dns.h</span><br><span>+++ b/src/openvpn/dns.h</=
span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public Li=
cense for more details.</span><br><span>  *</span><br><span>  *  You should=
 have received a copy of the GNU General Public License along</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, writ=
e to the Free Software Foundation, Inc.,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-13=
01 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><sp=
an>  */</span><br><span> </span><br><span> #ifndef DNS_H</span><br><span>di=
ff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c</span><br><span>in=
dex f20ee8a..7809237 100644</span><br><span>--- a/src/openvpn/env_set.c</sp=
an><br><span>+++ b/src/openvpn/env_set.c</span><br><span>@@ -20,8 +20,7 @@<=
/span><br><span>  *</span><br><span>  *  You should have received a copy of=
 the GNU General Public License</span><br><span>  *  along with this progra=
m (see the file COPYING included with this</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *  distribution); if not, write to the Free Software =
Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
59 Temple Place, Suite 330, Boston, MA  02111-1307  USA</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  distribution); if not, see &lt;http=
s://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span=
><br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/e=
nv_set.h b/src/openvpn/env_set.h</span><br><span>index 52c5312..63237a7 100=
644</span><br><span>--- a/src/openvpn/env_set.h</span><br><span>+++ b/src/o=
penvpn/env_set.h</span><br><span>@@ -18,8 +18,7 @@</span><br><span>  *</spa=
n><br><span>  *  You should have received a copy of the GNU General Public =
License</span><br><span>  *  along with this program (see the file COPYING =
included with this</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
 distribution); if not, write to the Free Software Foundation, Inc.,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *  59 Temple Place, Suite 3=
30, Boston, MA  02111-1307  USA</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  distribution); if not, see &lt;https://www.gnu.org/licenses=
/&gt;.</span><br><span>  */</span><br><span> </span><br><span> #ifndef ENV_=
SET_H</span><br><span>diff --git a/src/openvpn/errlevel.h b/src/openvpn/err=
level.h</span><br><span>index fc3e64a..e5e5b48 100644</span><br><span>--- a=
/src/openvpn/errlevel.h</span><br><span>+++ b/src/openvpn/errlevel.h</span>=
<br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License=
 for more details.</span><br><span>  *</span><br><span>  *  You should have=
 received a copy of the GNU General Public License along</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to =
the Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 US=
A.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this pro=
gram; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  =
*/</span><br><span> </span><br><span> #ifndef ERRLEVEL_H</span><br><span>di=
ff --git a/src/openvpn/error.c b/src/openvpn/error.c</span><br><span>index =
049cd92..22c339f 100644</span><br><span>--- a/src/openvpn/error.c</span><br=
><span>+++ b/src/openvpn/error.c</span><br><span>@@ -17,8 +17,7 @@</span><b=
r><span>  *  GNU General Public License for more details.</span><br><span> =
 *</span><br><span>  *  You should have received a copy of the GNU General =
Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*  with this program; if not, write to the Free Software Foundation, Inc.,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street=
, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gn=
u.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span=
> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/error.h b/s=
rc/openvpn/error.h</span><br><span>index e0a2730..cd0cac3 100644</span><br>=
<span>--- a/src/openvpn/error.h</span><br><span>+++ b/src/openvpn/error.h</=
span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public Li=
cense for more details.</span><br><span>  *</span><br><span>  *  You should=
 have received a copy of the GNU General Public License along</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, writ=
e to the Free Software Foundation, Inc.,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-13=
01 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><sp=
an>  */</span><br><span> </span><br><span> #ifndef ERROR_H</span><br><span>=
diff --git a/src/openvpn/event.c b/src/openvpn/event.c</span><br><span>inde=
x c3907b9..c773783 100644</span><br><span>--- a/src/openvpn/event.c</span><=
br><span>+++ b/src/openvpn/event.c</span><br><span>@@ -17,8 +17,7 @@</span>=
<br><span>  *  GNU General Public License for more details.</span><br><span=
>  *</span><br><span>  *  You should have received a copy of the GNU Genera=
l Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *  with this program; if not, write to the Free Software Foundation, Inc.=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Stre=
et, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.=
gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><sp=
an> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/event.h b=
/src/openvpn/event.h</span><br><span>index 389f80d..38178fc 100644</span><b=
r><span>--- a/src/openvpn/event.h</span><br><span>+++ b/src/openvpn/event.h=
</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public =
License for more details.</span><br><span>  *</span><br><span>  *  You shou=
ld have received a copy of the GNU General Public License along</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, wr=
ite to the Free Software Foundation, Inc.,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-=
1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with t=
his program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><=
span>  */</span><br><span> </span><br><span> #ifndef EVENT_H</span><br><spa=
n>diff --git a/src/openvpn/fdmisc.c b/src/openvpn/fdmisc.c</span><br><span>=
index 3d8654c..b8d9334 100644</span><br><span>--- a/src/openvpn/fdmisc.c</s=
pan><br><span>+++ b/src/openvpn/fdmisc.c</span><br><span>@@ -17,8 +17,7 @@<=
/span><br><span>  *  GNU General Public License for more details.</span><br=
><span>  *</span><br><span>  *  You should have received a copy of the GNU =
General Public License along</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *  with this program; if not, write to the Free Software Foundation=
, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Frankli=
n Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https:=
//www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><=
br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/fdm=
isc.h b/src/openvpn/fdmisc.h</span><br><span>index 17b6994..de0007a 100644<=
/span><br><span>--- a/src/openvpn/fdmisc.h</span><br><span>+++ b/src/openvp=
n/fdmisc.h</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU Gener=
al Public License for more details.</span><br><span>  *</span><br><span>  *=
  You should have received a copy of the GNU General Public License along</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; =
if not, write to the Free Software Foundation, Inc.,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston=
, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.<=
/span><br><span>  */</span><br><span> </span><br><span> #ifndef FD_MISC_H</=
span><br><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</=
span><br><span>index 475d142..d750ebf 100644</span><br><span>--- a/src/open=
vpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@=
@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License for more d=
etails.</span><br><span>  *</span><br><span>  *  You should have received a=
 copy of the GNU General Public License along</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Free So=
ftware Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if no=
t, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><b=
r><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git =
a/src/openvpn/forward.h b/src/openvpn/forward.h</span><br><span>index 2818f=
d1..abb45c0 100644</span><br><span>--- a/src/openvpn/forward.h</span><br><s=
pan>+++ b/src/openvpn/forward.h</span><br><span>@@ -17,8 +17,7 @@</span><br=
><span>  *  GNU General Public License for more details.</span><br><span>  =
*</span><br><span>  *  You should have received a copy of the GNU General P=
ublic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
  with this program; if not, write to the Free Software Foundation, Inc.,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street,=
 Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu=
.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span>=
 </span><br><span>diff --git a/src/openvpn/fragment.c b/src/openvpn/fragmen=
t.c</span><br><span>index 287eb9b..a7fbe09 100644</span><br><span>--- a/src=
/openvpn/fragment.c</span><br><span>+++ b/src/openvpn/fragment.c</span><br>=
<span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License for=
 more details.</span><br><span>  *</span><br><span>  *  You should have rec=
eived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to the=
 Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progra=
m; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */<=
/span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>dif=
f --git a/src/openvpn/fragment.h b/src/openvpn/fragment.h</span><br><span>i=
ndex cc96057..6120079 100644</span><br><span>--- a/src/openvpn/fragment.h</=
span><br><span>+++ b/src/openvpn/fragment.h</span><br><span>@@ -17,8 +17,7 =
@@</span><br><span>  *  GNU General Public License for more details.</span>=
<br><span>  *</span><br><span>  *  You should have received a copy of the G=
NU General Public License along</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- *  with this program; if not, write to the Free Software Foundat=
ion, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Fran=
klin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;ht=
tps://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </sp=
an><br><span> #ifndef FRAGMENT_H</span><br><span>diff --git a/src/openvpn/g=
remlin.c b/src/openvpn/gremlin.c</span><br><span>index b58defe..a3ecc8d 100=
644</span><br><span>--- a/src/openvpn/gremlin.c</span><br><span>+++ b/src/o=
penvpn/gremlin.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU=
 General Public License for more details.</span><br><span>  *</span><br><sp=
an>  *  You should have received a copy of the GNU General Public License a=
long</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this pro=
gram; if not, write to the Free Software Foundation, Inc.,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, B=
oston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&=
gt;.</span><br><span>  */</span><br><span> </span><br><span> /*</span><br><=
span>diff --git a/src/openvpn/gremlin.h b/src/openvpn/gremlin.h</span><br><=
span>index bf1cfea..3cbfb77 100644</span><br><span>--- a/src/openvpn/gremli=
n.h</span><br><span>+++ b/src/openvpn/gremlin.h</span><br><span>@@ -17,8 +1=
7,7 @@</span><br><span>  *  GNU General Public License for more details.</s=
pan><br><span>  *</span><br><span>  *  You should have received a copy of t=
he GNU General Public License along</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- *  with this program; if not, write to the Free Software Fou=
ndation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 =
Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt=
;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> <=
/span><br><span> #ifndef GREMLIN_H</span><br><span>diff --git a/src/openvpn=
/helper.c b/src/openvpn/helper.c</span><br><span>index 7cef9db..36b88f5 100=
644</span><br><span>--- a/src/openvpn/helper.c</span><br><span>+++ b/src/op=
envpn/helper.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU G=
eneral Public License for more details.</span><br><span>  *</span><br><span=
>  *  You should have received a copy of the GNU General Public License alo=
ng</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this progr=
am; if not, write to the Free Software Foundation, Inc.,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Bos=
ton, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt=
;.</span><br><span>  */</span><br><span> </span><br><span> #ifdef HAVE_CONF=
IG_H</span><br><span>diff --git a/src/openvpn/helper.h b/src/openvpn/helper=
.h</span><br><span>index ec5fe9e..0ce12dd 100644</span><br><span>--- a/src/=
openvpn/helper.h</span><br><span>+++ b/src/openvpn/helper.h</span><br><span=
>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License for more=
 details.</span><br><span>  *</span><br><span>  *  You should have received=
 a copy of the GNU General Public License along</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Free =
Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if =
not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span>=
<br><span> </span><br><span> /*</span><br><span>diff --git a/src/openvpn/ht=
tpdigest.c b/src/openvpn/httpdigest.c</span><br><span>index 8665402..be700b=
2 100644</span><br><span>--- a/src/openvpn/httpdigest.c</span><br><span>+++=
 b/src/openvpn/httpdigest.c</span><br><span>@@ -17,8 +17,7 @@</span><br><sp=
an>  *  GNU General Public License for more details.</span><br><span>  *</s=
pan><br><span>  *  You should have received a copy of the GNU General Publi=
c License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  wi=
th this program; if not, write to the Free Software Foundation, Inc.,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fif=
th Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.org=
/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> #if=
def HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/httpdigest.h b/s=
rc/openvpn/httpdigest.h</span><br><span>index 50cf451..ecdd6d3 100644</span=
><br><span>--- a/src/openvpn/httpdigest.h</span><br><span>+++ b/src/openvpn=
/httpdigest.h</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU Ge=
neral Public License for more details.</span><br><span>  *</span><br><span>=
  *  You should have received a copy of the GNU General Public License alon=
g</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this progra=
m; if not, write to the Free Software Foundation, Inc.,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Bost=
on, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;=
.</span><br><span>  */</span><br><span> </span><br><span> #if PROXY_DIGEST_=
AUTH</span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</=
span><br><span>index 3254cc6..32f20e1 100644</span><br><span>--- a/src/open=
vpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -17,=
8 +17,7 @@</span><br><span>  *  GNU General Public License for more details=
.</span><br><span>  *</span><br><span>  *  You should have received a copy =
of the GNU General Public License along</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *  with this program; if not, write to the Free Software=
 Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see=
 &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><spa=
n> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/=
openvpn/init.h b/src/openvpn/init.h</span><br><span>index 25078a6..081a295 =
100644</span><br><span>--- a/src/openvpn/init.h</span><br><span>+++ b/src/o=
penvpn/init.h</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU Ge=
neral Public License for more details.</span><br><span>  *</span><br><span>=
  *  You should have received a copy of the GNU General Public License alon=
g</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this progra=
m; if not, write to the Free Software Foundation, Inc.,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Bost=
on, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;=
.</span><br><span>  */</span><br><span> </span><br><span> #ifndef INIT_H</s=
pan><br><span>diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h</s=
pan><br><span>index c568036..4a95f4e 100644</span><br><span>--- a/src/openv=
pn/integer.h</span><br><span>+++ b/src/openvpn/integer.h</span><br><span>@@=
 -17,8 +17,7 @@</span><br><span>  *  GNU General Public License for more de=
tails.</span><br><span>  *</span><br><span>  *  You should have received a =
copy of the GNU General Public License along</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Free Sof=
tware Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not=
, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br=
><span> </span><br><span> #ifndef INTEGER_H</span><br><span>diff --git a/sr=
c/openvpn/interval.c b/src/openvpn/interval.c</span><br><span>index f1abeee=
..a2ac4f7 100644</span><br><span>--- a/src/openvpn/interval.c</span><br><sp=
an>+++ b/src/openvpn/interval.c</span><br><span>@@ -17,8 +17,7 @@</span><br=
><span>  *  GNU General Public License for more details.</span><br><span>  =
*</span><br><span>  *  You should have received a copy of the GNU General P=
ublic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
  with this program; if not, write to the Free Software Foundation, Inc.,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street,=
 Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu=
.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span>=
 #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/interval.h b=
/src/openvpn/interval.h</span><br><span>index 60030fd..420a1be 100644</span=
><br><span>--- a/src/openvpn/interval.h</span><br><span>+++ b/src/openvpn/i=
nterval.h</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU Genera=
l Public License for more details.</span><br><span>  *</span><br><span>  * =
 You should have received a copy of the GNU General Public License along</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; i=
f not, write to the Free Software Foundation, Inc.,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston=
, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.<=
/span><br><span>  */</span><br><span> </span><br><span> /*</span><br><span>=
diff --git a/src/openvpn/list.c b/src/openvpn/list.c</span><br><span>index =
1f33b5f..48e549f 100644</span><br><span>--- a/src/openvpn/list.c</span><br>=
<span>+++ b/src/openvpn/list.c</span><br><span>@@ -17,8 +17,7 @@</span><br>=
<span>  *  GNU General Public License for more details.</span><br><span>  *=
</span><br><span>  *  You should have received a copy of the GNU General Pu=
blic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
 with this program; if not, write to the Free Software Foundation, Inc.,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, =
Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.=
org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> =
#ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/list.h b/src/=
openvpn/list.h</span><br><span>index 783570f..77807c7 100644</span><br><spa=
n>--- a/src/openvpn/list.h</span><br><span>+++ b/src/openvpn/list.h</span><=
br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License =
for more details.</span><br><span>  *</span><br><span>  *  You should have =
received a copy of the GNU General Public License along</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to t=
he Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this prog=
ram; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  *=
/</span><br><span> </span><br><span> #ifndef LIST_H</span><br><span>diff --=
git a/src/openvpn/lzo.c b/src/openvpn/lzo.c</span><br><span>index 01db221..=
d5f60ca 100644</span><br><span>--- a/src/openvpn/lzo.c</span><br><span>+++ =
b/src/openvpn/lzo.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  =
GNU General Public License for more details.</span><br><span>  *</span><br>=
<span>  *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this =
program; if not, write to the Free Software Foundation, Inc.,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor=
, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  with this program; if not, see &lt;https://www.gnu.org/license=
s/&gt;.</span><br><span>  */</span><br><span> </span><br><span> /**</span><=
br><span>diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h</span><br><span=
>index 03da2af..c47db83 100644</span><br><span>--- a/src/openvpn/lzo.h</spa=
n><br><span>+++ b/src/openvpn/lzo.h</span><br><span>@@ -17,8 +17,7 @@</span=
><br><span>  *  GNU General Public License for more details.</span><br><spa=
n>  *</span><br><span>  *  You should have received a copy of the GNU Gener=
al Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *  with this program; if not, write to the Free Software Foundation, Inc=
.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Str=
eet, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=
.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><s=
pan> #ifndef OPENVPN_LZO_H</span><br><span>diff --git a/src/openvpn/manage.=
c b/src/openvpn/manage.c</span><br><span>index 8836e79..c7bdd5a 100644</spa=
n><br><span>--- a/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/ma=
nage.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General P=
ublic License for more details.</span><br><span>  *</span><br><span>  *  Yo=
u should have received a copy of the GNU General Public License along</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if n=
ot, write to the Free Software Foundation, Inc.,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA =
02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span=
><br><span>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</sp=
an><br><span>diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h</span=
><br><span>index eb19a4e..36a1905 100644</span><br><span>--- a/src/openvpn/=
manage.h</span><br><span>+++ b/src/openvpn/manage.h</span><br><span>@@ -17,=
8 +17,7 @@</span><br><span>  *  GNU General Public License for more details=
.</span><br><span>  *</span><br><span>  *  You should have received a copy =
of the GNU General Public License along</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *  with this program; if not, write to the Free Software=
 Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see=
 &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><spa=
n> </span><br><span> #ifndef MANAGE_H</span><br><span>diff --git a/src/open=
vpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h</span><br><span>index a=
eb0c5f..655c48f 100644</span><br><span>--- a/src/openvpn/mbedtls_compat.h</=
span><br><span>+++ b/src/openvpn/mbedtls_compat.h</span><br><span>@@ -17,8 =
+17,7 @@</span><br><span>  *  GNU General Public License for more details.<=
/span><br><span>  *</span><br><span>  *  You should have received a copy of=
 the GNU General Public License along</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- *  with this program; if not, write to the Free Software F=
oundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  5=
1 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &=
lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span>=
 </span><br><span> /**</span><br><span>diff --git a/src/openvpn/mbuf.c b/sr=
c/openvpn/mbuf.c</span><br><span>index 3346a11..76f2e58 100644</span><br><s=
pan>--- a/src/openvpn/mbuf.c</span><br><span>+++ b/src/openvpn/mbuf.c</span=
><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public Licens=
e for more details.</span><br><span>  *</span><br><span>  *  You should hav=
e received a copy of the GNU General Public License along</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to=
 the Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 U=
SA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this pr=
ogram; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span> =
 */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span=
>diff --git a/src/openvpn/mbuf.h b/src/openvpn/mbuf.h</span><br><span>index=
 b9c1645..8cc7ab1 100644</span><br><span>--- a/src/openvpn/mbuf.h</span><br=
><span>+++ b/src/openvpn/mbuf.h</span><br><span>@@ -17,8 +17,7 @@</span><br=
><span>  *  GNU General Public License for more details.</span><br><span>  =
*</span><br><span>  *  You should have received a copy of the GNU General P=
ublic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
  with this program; if not, write to the Free Software Foundation, Inc.,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street,=
 Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu=
.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span>=
 #ifndef MBUF_H</span><br><span>diff --git a/src/openvpn/memdbg.h b/src/ope=
nvpn/memdbg.h</span><br><span>index 6947275..9f8ff11 100644</span><br><span=
>--- a/src/openvpn/memdbg.h</span><br><span>+++ b/src/openvpn/memdbg.h</spa=
n><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public Licen=
se for more details.</span><br><span>  *</span><br><span>  *  You should ha=
ve received a copy of the GNU General Public License along</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write t=
o the Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 =
USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this p=
rogram; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>=
  */</span><br><span> </span><br><span> #ifndef MEMDBG_H</span><br><span>di=
ff --git a/src/openvpn/misc.c b/src/openvpn/misc.c</span><br><span>index 46=
95700..5776d6a 100644</span><br><span>--- a/src/openvpn/misc.c</span><br><s=
pan>+++ b/src/openvpn/misc.c</span><br><span>@@ -19,8 +19,7 @@</span><br><s=
pan>  *  GNU General Public License for more details.</span><br><span>  *</=
span><br><span>  *  You should have received a copy of the GNU General Publ=
ic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  w=
ith this program; if not, write to the Free Software Foundation, Inc.,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fi=
fth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.or=
g/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> #i=
fdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/misc.h b/src/op=
envpn/misc.h</span><br><span>index c6e2fa51..eb2449c 100644</span><br><span=
>--- a/src/openvpn/misc.h</span><br><span>+++ b/src/openvpn/misc.h</span><b=
r><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License f=
or more details.</span><br><span>  *</span><br><span>  *  You should have r=
eceived a copy of the GNU General Public License along</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to th=
e Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progr=
am; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */=
</span><br><span> </span><br><span> #ifndef MISC_H</span><br><span>diff --g=
it a/src/openvpn/mroute.c b/src/openvpn/mroute.c</span><br><span>index e3b1=
e9b..b14be7e 100644</span><br><span>--- a/src/openvpn/mroute.c</span><br><s=
pan>+++ b/src/openvpn/mroute.c</span><br><span>@@ -17,8 +17,7 @@</span><br>=
<span>  *  GNU General Public License for more details.</span><br><span>  *=
</span><br><span>  *  You should have received a copy of the GNU General Pu=
blic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
 with this program; if not, write to the Free Software Foundation, Inc.,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, =
Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.=
org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> =
#ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/mroute.h b/sr=
c/openvpn/mroute.h</span><br><span>index 4f9fc03..e06d272 100644</span><br>=
<span>--- a/src/openvpn/mroute.h</span><br><span>+++ b/src/openvpn/mroute.h=
</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public =
License for more details.</span><br><span>  *</span><br><span>  *  You shou=
ld have received a copy of the GNU General Public License along</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, wr=
ite to the Free Software Foundation, Inc.,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-=
1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with t=
his program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><=
span>  */</span><br><span> </span><br><span> #ifndef MROUTE_H</span><br><sp=
an>diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c</span><br><span>index=
 01ccdeb..96a9af0 100644</span><br><span>--- a/src/openvpn/mss.c</span><br>=
<span>+++ b/src/openvpn/mss.c</span><br><span>@@ -17,8 +17,7 @@</span><br><=
span>  *  GNU General Public License for more details.</span><br><span>  *<=
/span><br><span>  *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
with this program; if not, write to the Free Software Foundation, Inc.,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, F=
ifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.o=
rg/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> #=
ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/mss.h b/src/op=
envpn/mss.h</span><br><span>index 426af5e..1b1eafb 100644</span><br><span>-=
-- a/src/openvpn/mss.h</span><br><span>+++ b/src/openvpn/mss.h</span><br><s=
pan>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License for m=
ore details.</span><br><span>  *</span><br><span>  *  You should have recei=
ved a copy of the GNU General Public License along</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Fr=
ee Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; =
if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</sp=
an><br><span> </span><br><span> #ifndef MSS_H</span><br><span>diff --git a/=
src/openvpn/mstats.c b/src/openvpn/mstats.c</span><br><span>index cbef26a..=
d9ecee3 100644</span><br><span>--- a/src/openvpn/mstats.c</span><br><span>+=
++ b/src/openvpn/mstats.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span=
>  *  GNU General Public License for more details.</span><br><span>  *</spa=
n><br><span>  *  You should have received a copy of the GNU General Public =
License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with=
 this program; if not, write to the Free Software Foundation, Inc.,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth=
 Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.org/l=
icenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> /*</s=
pan><br><span>diff --git a/src/openvpn/mstats.h b/src/openvpn/mstats.h</spa=
n><br><span>index ea0237f..b9f33b6 100644</span><br><span>--- a/src/openvpn=
/mstats.h</span><br><span>+++ b/src/openvpn/mstats.h</span><br><span>@@ -17=
,8 +17,7 @@</span><br><span>  *  GNU General Public License for more detail=
s.</span><br><span>  *</span><br><span>  *  You should have received a copy=
 of the GNU General Public License along</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *  with this program; if not, write to the Free Softwar=
e Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, se=
e &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><sp=
an> </span><br><span> /*</span><br><span>diff --git a/src/openvpn/mtcp.c b/=
src/openvpn/mtcp.c</span><br><span>index 71991dd..9781724 100644</span><br>=
<span>--- a/src/openvpn/mtcp.c</span><br><span>+++ b/src/openvpn/mtcp.c</sp=
an><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public Lice=
nse for more details.</span><br><span>  *</span><br><span>  *  You should h=
ave received a copy of the GNU General Public License along</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write =
to the Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301=
 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this =
program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span=
>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><sp=
an>diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h</span><br><span>ind=
ex 334d6eb..5158427d 100644</span><br><span>--- a/src/openvpn/mtcp.h</span>=
<br><span>+++ b/src/openvpn/mtcp.h</span><br><span>@@ -17,8 +17,7 @@</span>=
<br><span>  *  GNU General Public License for more details.</span><br><span=
>  *</span><br><span>  *  You should have received a copy of the GNU Genera=
l Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *  with this program; if not, write to the Free Software Foundation, Inc.=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Stre=
et, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.=
gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><sp=
an> /*</span><br><span>diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c</=
span><br><span>index 78f1309..7245f95 100644</span><br><span>--- a/src/open=
vpn/mtu.c</span><br><span>+++ b/src/openvpn/mtu.c</span><br><span>@@ -17,8 =
+17,7 @@</span><br><span>  *  GNU General Public License for more details.<=
/span><br><span>  *</span><br><span>  *  You should have received a copy of=
 the GNU General Public License along</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- *  with this program; if not, write to the Free Software F=
oundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  5=
1 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &=
lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span>=
 </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/op=
envpn/mtu.h b/src/openvpn/mtu.h</span><br><span>index dca402a..64fd5b9 1006=
44</span><br><span>--- a/src/openvpn/mtu.h</span><br><span>+++ b/src/openvp=
n/mtu.h</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General =
Public License for more details.</span><br><span>  *</span><br><span>  *  Y=
ou should have received a copy of the GNU General Public License along</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if =
not, write to the Free Software Foundation, Inc.,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA=
 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</spa=
n><br><span>  */</span><br><span> </span><br><span> #ifndef MTU_H</span><br=
><span>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span=
>index 118c954..5755273 100644</span><br><span>--- a/src/openvpn/mudp.c</sp=
an><br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -17,8 +17,7 @@</sp=
an><br><span>  *  GNU General Public License for more details.</span><br><s=
pan>  *</span><br><span>  *  You should have received a copy of the GNU Gen=
eral Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *  with this program; if not, write to the Free Software Foundation, I=
nc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin S=
treet, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://w=
ww.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br>=
<span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/mudp.h=
 b/src/openvpn/mudp.h</span><br><span>index 4c83ad4..7e377b9 100644</span><=
br><span>--- a/src/openvpn/mudp.h</span><br><span>+++ b/src/openvpn/mudp.h<=
/span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public L=
icense for more details.</span><br><span>  *</span><br><span>  *  You shoul=
d have received a copy of the GNU General Public License along</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, wri=
te to the Free Software Foundation, Inc.,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1=
301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with th=
is program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><s=
pan>  */</span><br><span> </span><br><span> /*</span><br><span>diff --git a=
/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 68b4da6..a=
306b12 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++=
 b/src/openvpn/multi.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  =
*  GNU General Public License for more details.</span><br><span>  *</span><=
br><span>  *  You should have received a copy of the GNU General Public Lic=
ense along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with th=
is program; if not, write to the Free Software Foundation, Inc.,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Fl=
oor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.org/lice=
nses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> #ifdef H=
AVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/multi.h b/src/openvpn=
/multi.h</span><br><span>index 3c821d7..3c3db97 100644</span><br><span>--- =
a/src/openvpn/multi.h</span><br><span>+++ b/src/openvpn/multi.h</span><br><=
span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License for =
more details.</span><br><span>  *</span><br><span>  *  You should have rece=
ived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to the=
 Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progra=
m; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */<=
/span><br><span> </span><br><span> /**</span><br><span>diff --git a/src/ope=
nvpn/multi_io.c b/src/openvpn/multi_io.c</span><br><span>index 102ee2f..82f=
8372 100644</span><br><span>--- a/src/openvpn/multi_io.c</span><br><span>++=
+ b/src/openvpn/multi_io.c</span><br><span>@@ -17,8 +17,7 @@</span><br><spa=
n>  *  GNU General Public License for more details.</span><br><span>  *</sp=
an><br><span>  *  You should have received a copy of the GNU General Public=
 License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  wit=
h this program; if not, write to the Free Software Foundation, Inc.,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fift=
h Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.org/=
licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> #ifd=
ef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/multi_io.h b/src/=
openvpn/multi_io.h</span><br><span>index aecb65f..07eb3d4 100644</span><br>=
<span>--- a/src/openvpn/multi_io.h</span><br><span>+++ b/src/openvpn/multi_=
io.h</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Pub=
lic License for more details.</span><br><span>  *</span><br><span>  *  You =
should have received a copy of the GNU General Public License along</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not=
, write to the Free Software Foundation, Inc.,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02=
110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  wi=
th this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><=
br><span>  */</span><br><span> </span><br><span> /*</span><br><span>diff --=
git a/src/openvpn/networking.h b/src/openvpn/networking.h</span><br><span>i=
ndex 0ba4963..eccd8d2 100644</span><br><span>--- a/src/openvpn/networking.h=
</span><br><span>+++ b/src/openvpn/networking.h</span><br><span>@@ -14,8 +1=
4,7 @@</span><br><span>  *</span><br><span>  *  You should have received a =
copy of the GNU General Public License</span><br><span>  *  along with this=
 program (see the file COPYING included with this</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *  distribution); if not, write to the Free So=
ftware Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  distribution); if not, see &=
lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span>=
 </span><br><span> #ifndef NETWORKING_H_</span><br><span>diff --git a/src/o=
penvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c</span><br>=
<span>index 28b5bfc..ec8ab1e 100644</span><br><span>--- a/src/openvpn/netwo=
rking_iproute2.c</span><br><span>+++ b/src/openvpn/networking_iproute2.c</s=
pan><br><span>@@ -14,8 +14,7 @@</span><br><span>  *</span><br><span>  *  Yo=
u should have received a copy of the GNU General Public License</span><br><=
span>  *  along with this program (see the file COPYING included with this<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  distribution); if =
not, write to the Free Software Foundation, Inc.,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *  59 Temple Place, Suite 330, Boston, MA  021=
11-1307  USA</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  dis=
tribution); if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><s=
pan>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br>=
<span>diff --git a/src/openvpn/networking_iproute2.h b/src/openvpn/networki=
ng_iproute2.h</span><br><span>index ae72099..07de8b7 100644</span><br><span=
>--- a/src/openvpn/networking_iproute2.h</span><br><span>+++ b/src/openvpn/=
networking_iproute2.h</span><br><span>@@ -14,8 +14,7 @@</span><br><span>  *=
</span><br><span>  *  You should have received a copy of the GNU General Pu=
blic License</span><br><span>  *  along with this program (see the file COP=
YING included with this</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *  distribution); if not, write to the Free Software Foundation, Inc.,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  59 Temple Place, Su=
ite 330, Boston, MA  02111-1307  USA</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  distribution); if not, see &lt;https://www.gnu.org/lic=
enses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> </span>=
<br><span>diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/network=
ing_sitnl.c</span><br><span>index 79aba8d..97e5749 100644</span><br><span>-=
-- a/src/openvpn/networking_sitnl.c</span><br><span>+++ b/src/openvpn/netwo=
rking_sitnl.c</span><br><span>@@ -14,8 +14,7 @@</span><br><span>  *</span><=
br><span>  *  You should have received a copy of the GNU General Public Lic=
ense</span><br><span>  *  along with this program (see the file COPYING inc=
luded with this</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  di=
stribution); if not, write to the Free Software Foundation, Inc.,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *  59 Temple Place, Suite 330,=
 Boston, MA  02111-1307  USA</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  distribution); if not, see &lt;https://www.gnu.org/licenses/&g=
t;.</span><br><span>  */</span><br><span> </span><br><span> #ifdef HAVE_CON=
FIG_H</span><br><span>diff --git a/src/openvpn/networking_sitnl.h b/src/ope=
nvpn/networking_sitnl.h</span><br><span>index 002b479..97ff443 100644</span=
><br><span>--- a/src/openvpn/networking_sitnl.h</span><br><span>+++ b/src/o=
penvpn/networking_sitnl.h</span><br><span>@@ -14,8 +14,7 @@</span><br><span=
>  *</span><br><span>  *  You should have received a copy of the GNU Genera=
l Public License</span><br><span>  *  along with this program (see the file=
 COPYING included with this</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *  distribution); if not, write to the Free Software Foundation, Inc=
.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  59 Temple Place=
, Suite 330, Boston, MA  02111-1307  USA</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  distribution); if not, see &lt;https://www.gnu.org=
/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> </s=
pan><br><span>diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c</span><b=
r><span>index 2c6a69d..94e5d95 100644</span><br><span>--- a/src/openvpn/ntl=
m.c</span><br><span>+++ b/src/openvpn/ntlm.c</span><br><span>@@ -16,8 +16,7=
 @@</span><br><span>  *  GNU General Public License for more details.</span=
><br><span>  *</span><br><span>  *  You should have received a copy of the =
GNU General Public License along</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  with this program; if not, write to the Free Software Founda=
tion, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Fra=
nklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;ht=
tps://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </sp=
an><br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn=
/occ.c b/src/openvpn/occ.c</span><br><span>index 773fcfd..00b2fa4 100644</s=
pan><br><span>--- a/src/openvpn/occ.c</span><br><span>+++ b/src/openvpn/occ=
.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Publi=
c License for more details.</span><br><span>  *</span><br><span>  *  You sh=
ould have received a copy of the GNU General Public License along</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, =
write to the Free Software Foundation, Inc.,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 0211=
0-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with=
 this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br=
><span>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><=
br><span>diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h</span><br><span=
>index 8631bce..d5f208e 100644</span><br><span>--- a/src/openvpn/occ.h</spa=
n><br><span>+++ b/src/openvpn/occ.h</span><br><span>@@ -17,8 +17,7 @@</span=
><br><span>  *  GNU General Public License for more details.</span><br><spa=
n>  *</span><br><span>  *  You should have received a copy of the GNU Gener=
al Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *  with this program; if not, write to the Free Software Foundation, Inc=
.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Str=
eet, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=
.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><s=
pan> #ifndef OCC_H</span><br><span>diff --git a/src/openvpn/openssl_compat.=
h b/src/openvpn/openssl_compat.h</span><br><span>index 6baaaea..20f612e 100=
644</span><br><span>--- a/src/openvpn/openssl_compat.h</span><br><span>+++ =
b/src/openvpn/openssl_compat.h</span><br><span>@@ -18,8 +18,7 @@</span><br>=
<span>  *  GNU General Public License for more details.</span><br><span>  *=
</span><br><span>  *  You should have received a copy of the GNU General Pu=
blic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
 with this program; if not, write to the Free Software Foundation, Inc.,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, =
Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.=
org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> =
/**</span><br><span>diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvp=
n.c</span><br><span>index 54d5a06..99c420a 100644</span><br><span>--- a/src=
/openvpn/openvpn.c</span><br><span>+++ b/src/openvpn/openvpn.c</span><br><s=
pan>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License for m=
ore details.</span><br><span>  *</span><br><span>  *  You should have recei=
ved a copy of the GNU General Public License along</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Fr=
ee Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; =
if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</sp=
an><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff -=
-git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h</span><br><span>index =
7d48888..004cbc7 100644</span><br><span>--- a/src/openvpn/openvpn.h</span><=
br><span>+++ b/src/openvpn/openvpn.h</span><br><span>@@ -17,8 +17,7 @@</spa=
n><br><span>  *  GNU General Public License for more details.</span><br><sp=
an>  *</span><br><span>  *  You should have received a copy of the GNU Gene=
ral Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *  with this program; if not, write to the Free Software Foundation, In=
c.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin St=
reet, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://ww=
w.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><=
span> #ifndef OPENVPN_H</span><br><span>diff --git a/src/openvpn/options.c =
b/src/openvpn/options.c</span><br><span>index ff9addd..67139b8 100644</span=
><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/op=
tions.c</span><br><span>@@ -18,8 +18,7 @@</span><br><span>  *  GNU General =
Public License for more details.</span><br><span>  *</span><br><span>  *  Y=
ou should have received a copy of the GNU General Public License along</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if =
not, write to the Free Software Foundation, Inc.,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA=
 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</spa=
n><br><span>  */</span><br><span> </span><br><span> /*</span><br><span>diff=
 --git a/src/openvpn/options.h b/src/openvpn/options.h</span><br><span>inde=
x 0544ca9..dbd50f0 100644</span><br><span>--- a/src/openvpn/options.h</span=
><br><span>+++ b/src/openvpn/options.h</span><br><span>@@ -17,8 +17,7 @@</s=
pan><br><span>  *  GNU General Public License for more details.</span><br><=
span>  *</span><br><span>  *  You should have received a copy of the GNU Ge=
neral Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *  with this program; if not, write to the Free Software Foundation, =
Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin =
Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://=
www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br=
><span> /*</span><br><span>diff --git a/src/openvpn/options_util.c b/src/op=
envpn/options_util.c</span><br><span>index d317c1a..e469c28 100644</span><b=
r><span>--- a/src/openvpn/options_util.c</span><br><span>+++ b/src/openvpn/=
options_util.c</span><br><span>@@ -18,8 +18,7 @@</span><br><span>  *  GNU G=
eneral Public License for more details.</span><br><span>  *</span><br><span=
>  *  You should have received a copy of the GNU General Public License alo=
ng</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this progr=
am; if not, write to the Free Software Foundation, Inc.,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Bos=
ton, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt=
;.</span><br><span>  */</span><br><span> </span><br><span> #ifdef HAVE_CONF=
IG_H</span><br><span>diff --git a/src/openvpn/options_util.h b/src/openvpn/=
options_util.h</span><br><span>index 71d51d6..23fd78d 100644</span><br><spa=
n>--- a/src/openvpn/options_util.h</span><br><span>+++ b/src/openvpn/option=
s_util.h</span><br><span>@@ -18,8 +18,7 @@</span><br><span>  *  GNU General=
 Public License for more details.</span><br><span>  *</span><br><span>  *  =
You should have received a copy of the GNU General Public License along</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if=
 not, write to the Free Software Foundation, Inc.,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, M=
A 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</sp=
an><br><span>  */</span><br><span> </span><br><span> #ifndef OPTIONS_UTIL_H=
_</span><br><span>diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c</s=
pan><br><span>index d423067..d6b9c2c 100644</span><br><span>--- a/src/openv=
pn/otime.c</span><br><span>+++ b/src/openvpn/otime.c</span><br><span>@@ -17=
,8 +17,7 @@</span><br><span>  *  GNU General Public License for more detail=
s.</span><br><span>  *</span><br><span>  *  You should have received a copy=
 of the GNU General Public License along</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *  with this program; if not, write to the Free Softwar=
e Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, se=
e &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><sp=
an> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src=
/openvpn/otime.h b/src/openvpn/otime.h</span><br><span>index 448389d..29e80=
46 100644</span><br><span>--- a/src/openvpn/otime.h</span><br><span>+++ b/s=
rc/openvpn/otime.h</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  G=
NU General Public License for more details.</span><br><span>  *</span><br><=
span>  *  You should have received a copy of the GNU General Public License=
 along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this p=
rogram; if not, write to the Free Software Foundation, Inc.,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor,=
 Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses=
/&gt;.</span><br><span>  */</span><br><span> </span><br><span> #ifndef OTIM=
E_H</span><br><span>diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/o=
vpn_dco_win.h</span><br><span>index dd6b7ce..baf7214 100644</span><br><span=
>--- a/src/openvpn/ovpn_dco_win.h</span><br><span>+++ b/src/openvpn/ovpn_dc=
o_win.h</span><br><span>@@ -15,8 +15,7 @@</span><br><span>  *  GNU General =
Public License for more details.</span><br><span>  *</span><br><span>  *  Y=
ou should have received a copy of the GNU General Public License along</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if =
not, write to the Free Software Foundation, Inc.,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA=
 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</spa=
n><br><span>  *</span><br><span>  *  This particular file (uapi.h) is also =
licensed using the MIT license (see COPYRIGHT.MIT).</span><br><span>  */</s=
pan><br><span>diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.=
c</span><br><span>index 76a81c6..e6ca601 100644</span><br><span>--- a/src/o=
penvpn/packet_id.c</span><br><span>+++ b/src/openvpn/packet_id.c</span><br>=
<span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License for=
 more details.</span><br><span>  *</span><br><span>  *  You should have rec=
eived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to the=
 Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progra=
m; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */<=
/span><br><span> </span><br><span> /*</span><br><span>diff --git a/src/open=
vpn/packet_id.h b/src/openvpn/packet_id.h</span><br><span>index 6db939f..8b=
b6951 100644</span><br><span>--- a/src/openvpn/packet_id.h</span><br><span>=
+++ b/src/openvpn/packet_id.h</span><br><span>@@ -17,8 +17,7 @@</span><br><=
span>  *  GNU General Public License for more details.</span><br><span>  *<=
/span><br><span>  *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
with this program; if not, write to the Free Software Foundation, Inc.,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, F=
ifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.o=
rg/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> /=
*</span><br><span>diff --git a/src/openvpn/perf.c b/src/openvpn/perf.c</spa=
n><br><span>index 71c00e5..580e0fe 100644</span><br><span>--- a/src/openvpn=
/perf.c</span><br><span>+++ b/src/openvpn/perf.c</span><br><span>@@ -17,8 +=
17,7 @@</span><br><span>  *  GNU General Public License for more details.</=
span><br><span>  *</span><br><span>  *  You should have received a copy of =
the GNU General Public License along</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *  with this program; if not, write to the Free Software Fo=
undation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51=
 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &l=
t;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> =
</span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/ope=
nvpn/perf.h b/src/openvpn/perf.h</span><br><span>index 5ddebeb..7b35b5e 100=
644</span><br><span>--- a/src/openvpn/perf.h</span><br><span>+++ b/src/open=
vpn/perf.h</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU Gener=
al Public License for more details.</span><br><span>  *</span><br><span>  *=
  You should have received a copy of the GNU General Public License along</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; =
if not, write to the Free Software Foundation, Inc.,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston=
, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.<=
/span><br><span>  */</span><br><span> </span><br><span> /*</span><br><span>=
diff --git a/src/openvpn/ping.c b/src/openvpn/ping.c</span><br><span>index =
f570d95..50f255a 100644</span><br><span>--- a/src/openvpn/ping.c</span><br>=
<span>+++ b/src/openvpn/ping.c</span><br><span>@@ -17,8 +17,7 @@</span><br>=
<span>  *  GNU General Public License for more details.</span><br><span>  *=
</span><br><span>  *  You should have received a copy of the GNU General Pu=
blic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
 with this program; if not, write to the Free Software Foundation, Inc.,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, =
Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.=
org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> =
#ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/ping.h b/src/=
openvpn/ping.h</span><br><span>index 4cb89b4..29ee2f2 100644</span><br><spa=
n>--- a/src/openvpn/ping.h</span><br><span>+++ b/src/openvpn/ping.h</span><=
br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License =
for more details.</span><br><span>  *</span><br><span>  *  You should have =
received a copy of the GNU General Public License along</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to t=
he Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this prog=
ram; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  *=
/</span><br><span> </span><br><span> #ifndef PING_H</span><br><span>diff --=
git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c</span><br><span>index 004=
28d8..0177b18 100644</span><br><span>--- a/src/openvpn/pkcs11.c</span><br><=
span>+++ b/src/openvpn/pkcs11.c</span><br><span>@@ -17,8 +17,7 @@</span><br=
><span>  *  GNU General Public License for more details.</span><br><span>  =
*</span><br><span>  *  You should have received a copy of the GNU General P=
ublic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
  with this program; if not, write to the Free Software Foundation, Inc.,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street,=
 Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu=
.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span>=
 #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/pkcs11.h b/s=
rc/openvpn/pkcs11.h</span><br><span>index 72913eb..644d7ce 100644</span><br=
><span>--- a/src/openvpn/pkcs11.h</span><br><span>+++ b/src/openvpn/pkcs11.=
h</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public=
 License for more details.</span><br><span>  *</span><br><span>  *  You sho=
uld have received a copy of the GNU General Public License along</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, w=
rite to the Free Software Foundation, Inc.,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110=
-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with =
this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br>=
<span>  */</span><br><span> </span><br><span> #ifndef OPENVPN_PKCS11_H</spa=
n><br><span>diff --git a/src/openvpn/pkcs11_backend.h b/src/openvpn/pkcs11_=
backend.h</span><br><span>index dce6822..f65ba3f 100644</span><br><span>---=
 a/src/openvpn/pkcs11_backend.h</span><br><span>+++ b/src/openvpn/pkcs11_ba=
ckend.h</span><br><span>@@ -18,8 +18,7 @@</span><br><span>  *  GNU General =
Public License for more details.</span><br><span>  *</span><br><span>  *  Y=
ou should have received a copy of the GNU General Public License along</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if =
not, write to the Free Software Foundation, Inc.,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA=
 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</spa=
n><br><span>  */</span><br><span> </span><br><span> /**</span><br><span>dif=
f --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c</span=
><br><span>index 13b8a86..d1c8957 100644</span><br><span>--- a/src/openvpn/=
pkcs11_mbedtls.c</span><br><span>+++ b/src/openvpn/pkcs11_mbedtls.c</span><=
br><span>@@ -18,8 +18,7 @@</span><br><span>  *  GNU General Public License =
for more details.</span><br><span>  *</span><br><span>  *  You should have =
received a copy of the GNU General Public License along</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to t=
he Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this prog=
ram; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  *=
/</span><br><span> </span><br><span> /**</span><br><span>diff --git a/src/o=
penvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c</span><br><span>inde=
x e6baa43..489aa35 100644</span><br><span>--- a/src/openvpn/pkcs11_openssl.=
c</span><br><span>+++ b/src/openvpn/pkcs11_openssl.c</span><br><span>@@ -18=
,8 +18,7 @@</span><br><span>  *  GNU General Public License for more detail=
s.</span><br><span>  *</span><br><span>  *  You should have received a copy=
 of the GNU General Public License along</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *  with this program; if not, write to the Free Softwar=
e Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, se=
e &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><sp=
an> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/platform=
.c b/src/openvpn/platform.c</span><br><span>index b690192..623daaa 100644</=
span><br><span>--- a/src/openvpn/platform.c</span><br><span>+++ b/src/openv=
pn/platform.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU Ge=
neral Public License for more details.</span><br><span>  *</span><br><span>=
  *  You should have received a copy of the GNU General Public License alon=
g</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this progra=
m; if not, write to the Free Software Foundation, Inc.,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Bost=
on, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;=
.</span><br><span>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFI=
G_H</span><br><span>diff --git a/src/openvpn/platform.h b/src/openvpn/platf=
orm.h</span><br><span>index 56f8909..18ea97d 100644</span><br><span>--- a/s=
rc/openvpn/platform.h</span><br><span>+++ b/src/openvpn/platform.h</span><b=
r><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License f=
or more details.</span><br><span>  *</span><br><span>  *  You should have r=
eceived a copy of the GNU General Public License along</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to th=
e Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progr=
am; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */=
</span><br><span> </span><br><span> #ifndef PLATFORM_H</span><br><span>diff=
 --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c</span><br><span>index =
bafa469..12912c0 100644</span><br><span>--- a/src/openvpn/plugin.c</span><b=
r><span>+++ b/src/openvpn/plugin.c</span><br><span>@@ -17,8 +17,7 @@</span>=
<br><span>  *  GNU General Public License for more details.</span><br><span=
>  *</span><br><span>  *  You should have received a copy of the GNU Genera=
l Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *  with this program; if not, write to the Free Software Foundation, Inc.=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Stre=
et, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.=
gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><sp=
an> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/plugin.h =
b/src/openvpn/plugin.h</span><br><span>index 5e91c60..b44cf0d 100644</span>=
<br><span>--- a/src/openvpn/plugin.h</span><br><span>+++ b/src/openvpn/plug=
in.h</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Pub=
lic License for more details.</span><br><span>  *</span><br><span>  *  You =
should have received a copy of the GNU General Public License along</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not=
, write to the Free Software Foundation, Inc.,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02=
110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  wi=
th this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><=
br><span>  */</span><br><span> </span><br><span> /*</span><br><span>diff --=
git a/src/openvpn/pool.c b/src/openvpn/pool.c</span><br><span>index ced172c=
..bfa43ec 100644</span><br><span>--- a/src/openvpn/pool.c</span><br><span>+=
++ b/src/openvpn/pool.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span> =
 *  GNU General Public License for more details.</span><br><span>  *</span>=
<br><span>  *  You should have received a copy of the GNU General Public Li=
cense along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with t=
his program; if not, write to the Free Software Foundation, Inc.,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth F=
loor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.org/lic=
enses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> #ifdef =
HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/pool.h b/src/openvpn=
/pool.h</span><br><span>index 9c3905d..9f50ca9 100644</span><br><span>--- a=
/src/openvpn/pool.h</span><br><span>+++ b/src/openvpn/pool.h</span><br><spa=
n>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License for mor=
e details.</span><br><span>  *</span><br><span>  *  You should have receive=
d a copy of the GNU General Public License along</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Free=
 Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if=
 not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span=
><br><span> </span><br><span> #ifndef POOL_H</span><br><span>diff --git a/s=
rc/openvpn/proto.c b/src/openvpn/proto.c</span><br><span>index 90930fe..482=
0602 100644</span><br><span>--- a/src/openvpn/proto.c</span><br><span>+++ b=
/src/openvpn/proto.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  * =
 GNU General Public License for more details.</span><br><span>  *</span><br=
><span>  *  You should have received a copy of the GNU General Public Licen=
se along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this=
 program; if not, write to the Free Software Foundation, Inc.,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floo=
r, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.org/licens=
es/&gt;.</span><br><span>  */</span><br><span> </span><br><span> #ifdef HAV=
E_CONFIG_H</span><br><span>diff --git a/src/openvpn/proto.h b/src/openvpn/p=
roto.h</span><br><span>index 11c2a49..0942c11 100644</span><br><span>--- a/=
src/openvpn/proto.h</span><br><span>+++ b/src/openvpn/proto.h</span><br><sp=
an>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License for mo=
re details.</span><br><span>  *</span><br><span>  *  You should have receiv=
ed a copy of the GNU General Public License along</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Fre=
e Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; i=
f not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</spa=
n><br><span> </span><br><span> #ifndef PROTO_H</span><br><span>diff --git a=
/src/openvpn/proxy.c b/src/openvpn/proxy.c</span><br><span>index 0117a66..3=
93abb4 100644</span><br><span>--- a/src/openvpn/proxy.c</span><br><span>+++=
 b/src/openvpn/proxy.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  =
*  GNU General Public License for more details.</span><br><span>  *</span><=
br><span>  *  You should have received a copy of the GNU General Public Lic=
ense along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with th=
is program; if not, write to the Free Software Foundation, Inc.,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Fl=
oor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.org/lice=
nses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> #ifdef H=
AVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/proxy.h b/src/openvpn=
/proxy.h</span><br><span>index cf1fbdb..fcca1ab 100644</span><br><span>--- =
a/src/openvpn/proxy.h</span><br><span>+++ b/src/openvpn/proxy.h</span><br><=
span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License for =
more details.</span><br><span>  *</span><br><span>  *  You should have rece=
ived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to the=
 Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progra=
m; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */<=
/span><br><span> </span><br><span> #ifndef PROXY_H</span><br><span>diff --g=
it a/src/openvpn/ps.c b/src/openvpn/ps.c</span><br><span>index 0f2b812..6c6=
e5ea 100644</span><br><span>--- a/src/openvpn/ps.c</span><br><span>+++ b/sr=
c/openvpn/ps.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU G=
eneral Public License for more details.</span><br><span>  *</span><br><span=
>  *  You should have received a copy of the GNU General Public License alo=
ng</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this progr=
am; if not, write to the Free Software Foundation, Inc.,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Bos=
ton, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt=
;.</span><br><span>  */</span><br><span> </span><br><span> #ifdef HAVE_CONF=
IG_H</span><br><span>diff --git a/src/openvpn/ps.h b/src/openvpn/ps.h</span=
><br><span>index 59aecbe..c6f5633 100644</span><br><span>--- a/src/openvpn/=
ps.h</span><br><span>+++ b/src/openvpn/ps.h</span><br><span>@@ -17,8 +17,7 =
@@</span><br><span>  *  GNU General Public License for more details.</span>=
<br><span>  *</span><br><span>  *  You should have received a copy of the G=
NU General Public License along</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- *  with this program; if not, write to the Free Software Foundat=
ion, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Fran=
klin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;ht=
tps://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </sp=
an><br><span> #ifndef PS_H</span><br><span>diff --git a/src/openvpn/push.c =
b/src/openvpn/push.c</span><br><span>index 22082a9..3013100 100644</span><b=
r><span>--- a/src/openvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</=
span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public Li=
cense for more details.</span><br><span>  *</span><br><span>  *  You should=
 have received a copy of the GNU General Public License along</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, writ=
e to the Free Software Foundation, Inc.,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-13=
01 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><sp=
an>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><=
span>diff --git a/src/openvpn/push.h b/src/openvpn/push.h</span><br><span>i=
ndex 18dfcd8..b6770bc 100644</span><br><span>--- a/src/openvpn/push.h</span=
><br><span>+++ b/src/openvpn/push.h</span><br><span>@@ -17,8 +17,7 @@</span=
><br><span>  *  GNU General Public License for more details.</span><br><spa=
n>  *</span><br><span>  *  You should have received a copy of the GNU Gener=
al Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *  with this program; if not, write to the Free Software Foundation, Inc=
.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Str=
eet, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=
.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><s=
pan> #ifndef PUSH_H</span><br><span>diff --git a/src/openvpn/pushlist.h b/s=
rc/openvpn/pushlist.h</span><br><span>index d946a5f..1b66517 100644</span><=
br><span>--- a/src/openvpn/pushlist.h</span><br><span>+++ b/src/openvpn/pus=
hlist.h</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General =
Public License for more details.</span><br><span>  *</span><br><span>  *  Y=
ou should have received a copy of the GNU General Public License along</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if =
not, write to the Free Software Foundation, Inc.,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA=
 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</spa=
n><br><span>  */</span><br><span> </span><br><span> #if !defined(PUSHLIST_H=
)</span><br><span>diff --git a/src/openvpn/reflect_filter.c b/src/openvpn/r=
eflect_filter.c</span><br><span>index a5bcf94..17255f7 100644</span><br><sp=
an>--- a/src/openvpn/reflect_filter.c</span><br><span>+++ b/src/openvpn/ref=
lect_filter.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU Ge=
neral Public License for more details.</span><br><span>  *</span><br><span>=
  *  You should have received a copy of the GNU General Public License alon=
g</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this progra=
m; if not, write to the Free Software Foundation, Inc.,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Bost=
on, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;=
.</span><br><span>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFI=
G_H</span><br><span>diff --git a/src/openvpn/reflect_filter.h b/src/openvpn=
/reflect_filter.h</span><br><span>index ae7be21..e3fb165 100644</span><br><=
span>--- a/src/openvpn/reflect_filter.h</span><br><span>+++ b/src/openvpn/r=
eflect_filter.h</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU =
General Public License for more details.</span><br><span>  *</span><br><spa=
n>  *  You should have received a copy of the GNU General Public License al=
ong</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this prog=
ram; if not, write to the Free Software Foundation, Inc.,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Bo=
ston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&g=
t;.</span><br><span>  */</span><br><span> #ifndef REFLECT_FILTER_H</span><b=
r><span> #define REFLECT_FILTER_H</span><br><span>diff --git a/src/openvpn/=
reliable.c b/src/openvpn/reliable.c</span><br><span>index 5505f56..278dc33 =
100644</span><br><span>--- a/src/openvpn/reliable.c</span><br><span>+++ b/s=
rc/openvpn/reliable.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *=
  GNU General Public License for more details.</span><br><span>  *</span><b=
r><span>  *  You should have received a copy of the GNU General Public Lice=
nse along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with thi=
s program; if not, write to the Free Software Foundation, Inc.,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Flo=
or, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.org/licen=
ses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> /*</span>=
<br><span>diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h</spa=
n><br><span>index 2cbff01..6c37d78 100644</span><br><span>--- a/src/openvpn=
/reliable.h</span><br><span>+++ b/src/openvpn/reliable.h</span><br><span>@@=
 -17,8 +17,7 @@</span><br><span>  *  GNU General Public License for more de=
tails.</span><br><span>  *</span><br><span>  *  You should have received a =
copy of the GNU General Public License along</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Free Sof=
tware Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not=
, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br=
><span> </span><br><span> </span><br><span>diff --git a/src/openvpn/route.c=
 b/src/openvpn/route.c</span><br><span>index 89ebaee..c4f7f95 100644</span>=
<br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/openvpn/route=
.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Publi=
c License for more details.</span><br><span>  *</span><br><span>  *  You sh=
ould have received a copy of the GNU General Public License along</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, =
write to the Free Software Foundation, Inc.,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 0211=
0-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with=
 this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br=
><span>  */</span><br><span> </span><br><span> /*</span><br><span>diff --gi=
t a/src/openvpn/route.h b/src/openvpn/route.h</span><br><span>index b89ec9f=
..1a358e32 100644</span><br><span>--- a/src/openvpn/route.h</span><br><span=
>+++ b/src/openvpn/route.h</span><br><span>@@ -17,8 +17,7 @@</span><br><spa=
n>  *  GNU General Public License for more details.</span><br><span>  *</sp=
an><br><span>  *  You should have received a copy of the GNU General Public=
 License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  wit=
h this program; if not, write to the Free Software Foundation, Inc.,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fift=
h Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.org/=
licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> /*</=
span><br><span>diff --git a/src/openvpn/run_command.c b/src/openvpn/run_com=
mand.c</span><br><span>index 8b5fa4f..ed5b08c 100644</span><br><span>--- a/=
src/openvpn/run_command.c</span><br><span>+++ b/src/openvpn/run_command.c</=
span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public Li=
cense for more details.</span><br><span>  *</span><br><span>  *  You should=
 have received a copy of the GNU General Public License along</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, writ=
e to the Free Software Foundation, Inc.,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-13=
01 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><sp=
an>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><=
span>diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h</sp=
an><br><span>index e9a6fe1..e703732 100644</span><br><span>--- a/src/openvp=
n/run_command.h</span><br><span>+++ b/src/openvpn/run_command.h</span><br><=
span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License for =
more details.</span><br><span>  *</span><br><span>  *  You should have rece=
ived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to the=
 Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progra=
m; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */<=
/span><br><span> </span><br><span> #ifndef RUN_COMMAND_H</span><br><span>di=
ff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c</span><br><span>=
index aaa9885..f89f341 100644</span><br><span>--- a/src/openvpn/schedule.c<=
/span><br><span>+++ b/src/openvpn/schedule.c</span><br><span>@@ -17,8 +17,7=
 @@</span><br><span>  *  GNU General Public License for more details.</span=
><br><span>  *</span><br><span>  *  You should have received a copy of the =
GNU General Public License along</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  with this program; if not, write to the Free Software Founda=
tion, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Fra=
nklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;ht=
tps://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </sp=
an><br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn=
/schedule.h b/src/openvpn/schedule.h</span><br><span>index 1608708..fad3f36=
 100644</span><br><span>--- a/src/openvpn/schedule.h</span><br><span>+++ b/=
src/openvpn/schedule.h</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  =
*  GNU General Public License for more details.</span><br><span>  *</span><=
br><span>  *  You should have received a copy of the GNU General Public Lic=
ense along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with th=
is program; if not, write to the Free Software Foundation, Inc.,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Fl=
oor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.org/lice=
nses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> #ifndef =
SCHEDULE_H</span><br><span>diff --git a/src/openvpn/session_id.c b/src/open=
vpn/session_id.c</span><br><span>index 47226fb..f31b898 100644</span><br><s=
pan>--- a/src/openvpn/session_id.c</span><br><span>+++ b/src/openvpn/sessio=
n_id.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General P=
ublic License for more details.</span><br><span>  *</span><br><span>  *  Yo=
u should have received a copy of the GNU General Public License along</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if n=
ot, write to the Free Software Foundation, Inc.,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA =
02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span=
><br><span>  */</span><br><span> </span><br><span> /*</span><br><span>diff =
--git a/src/openvpn/session_id.h b/src/openvpn/session_id.h</span><br><span=
>index 5ce9a96..7c0a968 100644</span><br><span>--- a/src/openvpn/session_id=
.h</span><br><span>+++ b/src/openvpn/session_id.h</span><br><span>@@ -17,8 =
+17,7 @@</span><br><span>  *  GNU General Public License for more details.<=
/span><br><span>  *</span><br><span>  *  You should have received a copy of=
 the GNU General Public License along</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- *  with this program; if not, write to the Free Software F=
oundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  5=
1 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &=
lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span>=
 </span><br><span> /*</span><br><span>diff --git a/src/openvpn/shaper.c b/s=
rc/openvpn/shaper.c</span><br><span>index 1075954..1c8cfb3 100644</span><br=
><span>--- a/src/openvpn/shaper.c</span><br><span>+++ b/src/openvpn/shaper.=
c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public=
 License for more details.</span><br><span>  *</span><br><span>  *  You sho=
uld have received a copy of the GNU General Public License along</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, w=
rite to the Free Software Foundation, Inc.,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110=
-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with =
this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br>=
<span>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><b=
r><span>diff --git a/src/openvpn/shaper.h b/src/openvpn/shaper.h</span><br>=
<span>index 2b3eeb9..9996b08 100644</span><br><span>--- a/src/openvpn/shape=
r.h</span><br><span>+++ b/src/openvpn/shaper.h</span><br><span>@@ -17,8 +17=
,7 @@</span><br><span>  *  GNU General Public License for more details.</sp=
an><br><span>  *</span><br><span>  *  You should have received a copy of th=
e GNU General Public License along</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *  with this program; if not, write to the Free Software Foun=
dation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 F=
ranklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;=
https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </=
span><br><span> #ifndef SHAPER_H</span><br><span>diff --git a/src/openvpn/s=
ig.c b/src/openvpn/sig.c</span><br><span>index 9334b10..02df5e0 100644</spa=
n><br><span>--- a/src/openvpn/sig.c</span><br><span>+++ b/src/openvpn/sig.c=
</span><br><span>@@ -18,8 +18,7 @@</span><br><span>  *  GNU General Public =
License for more details.</span><br><span>  *</span><br><span>  *  You shou=
ld have received a copy of the GNU General Public License along</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, wr=
ite to the Free Software Foundation, Inc.,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-=
1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with t=
his program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><=
span>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br=
><span>diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h</span><br><span>i=
ndex fe81af9..93219f7 100644</span><br><span>--- a/src/openvpn/sig.h</span>=
<br><span>+++ b/src/openvpn/sig.h</span><br><span>@@ -17,8 +17,7 @@</span><=
br><span>  *  GNU General Public License for more details.</span><br><span>=
  *</span><br><span>  *  You should have received a copy of the GNU General=
 Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *  with this program; if not, write to the Free Software Foundation, Inc.,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Stree=
t, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.g=
nu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><spa=
n> #ifndef SIG_H</span><br><span>diff --git a/src/openvpn/socket.c b/src/op=
envpn/socket.c</span><br><span>index 980d8b4..8510e1d 100644</span><br><spa=
n>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</sp=
an><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public Lice=
nse for more details.</span><br><span>  *</span><br><span>  *  You should h=
ave received a copy of the GNU General Public License along</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write =
to the Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301=
 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this =
program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span=
>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><sp=
an>diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h</span><br><span=
>index 6d71e83..f30411d 100644</span><br><span>--- a/src/openvpn/socket.h</=
span><br><span>+++ b/src/openvpn/socket.h</span><br><span>@@ -17,8 +17,7 @@=
</span><br><span>  *  GNU General Public License for more details.</span><b=
r><span>  *</span><br><span>  *  You should have received a copy of the GNU=
 General Public License along</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *  with this program; if not, write to the Free Software Foundatio=
n, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Frankl=
in Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https=
://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span>=
<br><span> #ifndef SOCKET_H</span><br><span>diff --git a/src/openvpn/socks.=
c b/src/openvpn/socks.c</span><br><span>index cc2dbdf..6192c39 100644</span=
><br><span>--- a/src/openvpn/socks.c</span><br><span>+++ b/src/openvpn/sock=
s.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Publ=
ic License for more details.</span><br><span>  *</span><br><span>  *  You s=
hould have received a copy of the GNU General Public License along</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not,=
 write to the Free Software Foundation, Inc.,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 021=
10-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  wit=
h this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><b=
r><span>  */</span><br><span> </span><br><span> /*</span><br><span>diff --g=
it a/src/openvpn/socks.h b/src/openvpn/socks.h</span><br><span>index 0eaa9d=
a..985745b 100644</span><br><span>--- a/src/openvpn/socks.h</span><br><span=
>+++ b/src/openvpn/socks.h</span><br><span>@@ -17,8 +17,7 @@</span><br><spa=
n>  *  GNU General Public License for more details.</span><br><span>  *</sp=
an><br><span>  *  You should have received a copy of the GNU General Public=
 License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  wit=
h this program; if not, write to the Free Software Foundation, Inc.,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fift=
h Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.org/=
licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> /*</=
span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br=
><span>index a7658dd..06621bd 100644</span><br><span>--- a/src/openvpn/ssl.=
c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -19,8 +19,7 @@=
</span><br><span>  *  GNU General Public License for more details.</span><b=
r><span>  *</span><br><span>  *  You should have received a copy of the GNU=
 General Public License along</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *  with this program; if not, write to the Free Software Foundatio=
n, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Frankl=
in Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https=
://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span>=
<br><span> /**</span><br><span>diff --git a/src/openvpn/ssl.h b/src/openvpn=
/ssl.h</span><br><span>index 0a43ea1..b952cd9 100644</span><br><span>--- a/=
src/openvpn/ssl.h</span><br><span>+++ b/src/openvpn/ssl.h</span><br><span>@=
@ -18,8 +18,7 @@</span><br><span>  *  GNU General Public License for more d=
etails.</span><br><span>  *</span><br><span>  *  You should have received a=
 copy of the GNU General Public License along</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Free So=
ftware Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if no=
t, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><b=
r><span> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/ssl=
_backend.h b/src/openvpn/ssl_backend.h</span><br><span>index 1cf9e1d..8023f=
ed 100644</span><br><span>--- a/src/openvpn/ssl_backend.h</span><br><span>+=
++ b/src/openvpn/ssl_backend.h</span><br><span>@@ -18,8 +18,7 @@</span><br>=
<span>  *  GNU General Public License for more details.</span><br><span>  *=
</span><br><span>  *  You should have received a copy of the GNU General Pu=
blic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
 with this program; if not, write to the Free Software Foundation, Inc.,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, =
Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.=
org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> =
/**</span><br><span>diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl=
_common.h</span><br><span>index e9e50da..90c0086 100644</span><br><span>---=
 a/src/openvpn/ssl_common.h</span><br><span>+++ b/src/openvpn/ssl_common.h<=
/span><br><span>@@ -18,8 +18,7 @@</span><br><span>  *  GNU General Public L=
icense for more details.</span><br><span>  *</span><br><span>  *  You shoul=
d have received a copy of the GNU General Public License along</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, wri=
te to the Free Software Foundation, Inc.,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1=
301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with th=
is program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><s=
pan>  */</span><br><span> </span><br><span> /**</span><br><span>diff --git =
a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span><br><span>ind=
ex a4bb772..22e777b 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls.c<=
/span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><span>@@ -19,8 +1=
9,7 @@</span><br><span>  *  GNU General Public License for more details.</s=
pan><br><span>  *</span><br><span>  *  You should have received a copy of t=
he GNU General Public License along</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- *  with this program; if not, write to the Free Software Fou=
ndation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 =
Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt=
;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> <=
/span><br><span> /**</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.h=
 b/src/openvpn/ssl_mbedtls.h</span><br><span>index 9f124cd..fba766b 100644<=
/span><br><span>--- a/src/openvpn/ssl_mbedtls.h</span><br><span>+++ b/src/o=
penvpn/ssl_mbedtls.h</span><br><span>@@ -18,8 +18,7 @@</span><br><span>  * =
 GNU General Public License for more details.</span><br><span>  *</span><br=
><span>  *  You should have received a copy of the GNU General Public Licen=
se along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this=
 program; if not, write to the Free Software Foundation, Inc.,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floo=
r, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.org/licens=
es/&gt;.</span><br><span>  */</span><br><span> </span><br><span> /**</span>=
<br><span>diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c</span>=
<br><span>index 74d7b43..62fef42 100644</span><br><span>--- a/src/openvpn/s=
sl_ncp.c</span><br><span>+++ b/src/openvpn/ssl_ncp.c</span><br><span>@@ -19=
,8 +19,7 @@</span><br><span>  *  GNU General Public License for more detail=
s.</span><br><span>  *</span><br><span>  *  You should have received a copy=
 of the GNU General Public License along</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *  with this program; if not, write to the Free Softwar=
e Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, se=
e &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><sp=
an> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/ssl_ncp.=
h b/src/openvpn/ssl_ncp.h</span><br><span>index 6159264..b01cd87 100644</sp=
an><br><span>--- a/src/openvpn/ssl_ncp.h</span><br><span>+++ b/src/openvpn/=
ssl_ncp.h</span><br><span>@@ -18,8 +18,7 @@</span><br><span>  *  GNU Genera=
l Public License for more details.</span><br><span>  *</span><br><span>  * =
 You should have received a copy of the GNU General Public License along</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; i=
f not, write to the Free Software Foundation, Inc.,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston=
, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.<=
/span><br><span>  */</span><br><span> </span><br><span> /**</span><br><span=
>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><=
br><span>index 4c11cd4..1c1649f 100644</span><br><span>--- a/src/openvpn/ss=
l_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span=
>@@ -18,8 +18,7 @@</span><br><span>  *  GNU General Public License for more=
 details.</span><br><span>  *</span><br><span>  *  You should have received=
 a copy of the GNU General Public License along</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Free =
Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if =
not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span>=
<br><span> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/s=
sl_openssl.h b/src/openvpn/ssl_openssl.h</span><br><span>index f26b44e..966=
bb44 100644</span><br><span>--- a/src/openvpn/ssl_openssl.h</span><br><span=
>+++ b/src/openvpn/ssl_openssl.h</span><br><span>@@ -18,8 +18,7 @@</span><b=
r><span>  *  GNU General Public License for more details.</span><br><span> =
 *</span><br><span>  *  You should have received a copy of the GNU General =
Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*  with this program; if not, write to the Free Software Foundation, Inc.,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street=
, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gn=
u.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span=
> /**</span><br><span>diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_=
pkt.c</span><br><span>index bfd405f..e730e33 100644</span><br><span>--- a/s=
rc/openvpn/ssl_pkt.c</span><br><span>+++ b/src/openvpn/ssl_pkt.c</span><br>=
<span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License for=
 more details.</span><br><span>  *</span><br><span>  *  You should have rec=
eived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to the=
 Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progra=
m; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */<=
/span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;confi=
g.h&quot;</span><br><span>diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/=
ssl_pkt.h</span><br><span>index 98a39d3..1e9f4e9 100644</span><br><span>---=
 a/src/openvpn/ssl_pkt.h</span><br><span>+++ b/src/openvpn/ssl_pkt.h</span>=
<br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License=
 for more details.</span><br><span>  *</span><br><span>  *  You should have=
 received a copy of the GNU General Public License along</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to =
the Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 US=
A.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this pro=
gram; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  =
*/</span><br><span> </span><br><span> /**</span><br><span>diff --git a/src/=
openvpn/ssl_util.c b/src/openvpn/ssl_util.c</span><br><span>index d3d7b2c..=
6e00630 100644</span><br><span>--- a/src/openvpn/ssl_util.c</span><br><span=
>+++ b/src/openvpn/ssl_util.c</span><br><span>@@ -17,8 +17,7 @@</span><br><=
span>  *  GNU General Public License for more details.</span><br><span>  *<=
/span><br><span>  *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
with this program; if not, write to the Free Software Foundation, Inc.,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, F=
ifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.o=
rg/licenses/&gt;.</span><br><span>  */</span><br><span> #ifdef HAVE_CONFIG_=
H</span><br><span> #include &quot;config.h&quot;</span><br><span>diff --git=
 a/src/openvpn/ssl_util.h b/src/openvpn/ssl_util.h</span><br><span>index e5=
0f899..189b1d0 100644</span><br><span>--- a/src/openvpn/ssl_util.h</span><b=
r><span>+++ b/src/openvpn/ssl_util.h</span><br><span>@@ -17,8 +17,7 @@</spa=
n><br><span>  *  GNU General Public License for more details.</span><br><sp=
an>  *</span><br><span>  *  You should have received a copy of the GNU Gene=
ral Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *  with this program; if not, write to the Free Software Foundation, In=
c.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin St=
reet, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://ww=
w.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><=
span> /**</span><br><span>diff --git a/src/openvpn/ssl_verify.c b/src/openv=
pn/ssl_verify.c</span><br><span>index 41635c8..82337cf 100644</span><br><sp=
an>--- a/src/openvpn/ssl_verify.c</span><br><span>+++ b/src/openvpn/ssl_ver=
ify.c</span><br><span>@@ -18,8 +18,7 @@</span><br><span>  *  GNU General Pu=
blic License for more details.</span><br><span>  *</span><br><span>  *  You=
 should have received a copy of the GNU General Public License along</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if no=
t, write to the Free Software Foundation, Inc.,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 0=
2110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  w=
ith this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span>=
<br><span>  */</span><br><span> </span><br><span> /**</span><br><span>diff =
--git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h</span><br><span=
>index 9a30db0..76f1e24 100644</span><br><span>--- a/src/openvpn/ssl_verify=
.h</span><br><span>+++ b/src/openvpn/ssl_verify.h</span><br><span>@@ -18,8 =
+18,7 @@</span><br><span>  *  GNU General Public License for more details.<=
/span><br><span>  *</span><br><span>  *  You should have received a copy of=
 the GNU General Public License along</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- *  with this program; if not, write to the Free Software F=
oundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  5=
1 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &=
lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span>=
 </span><br><span> /**</span><br><span>diff --git a/src/openvpn/ssl_verify_=
backend.h b/src/openvpn/ssl_verify_backend.h</span><br><span>index eb80cc8.=
.03f591c 100644</span><br><span>--- a/src/openvpn/ssl_verify_backend.h</spa=
n><br><span>+++ b/src/openvpn/ssl_verify_backend.h</span><br><span>@@ -18,8=
 +18,7 @@</span><br><span>  *  GNU General Public License for more details.=
</span><br><span>  *</span><br><span>  *  You should have received a copy o=
f the GNU General Public License along</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *  with this program; if not, write to the Free Software =
Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see =
&lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span=
> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/ssl_verify=
_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c</span><br><span>index 25ad09c=
..43bbde5 100644</span><br><span>--- a/src/openvpn/ssl_verify_mbedtls.c</sp=
an><br><span>+++ b/src/openvpn/ssl_verify_mbedtls.c</span><br><span>@@ -18,=
8 +18,7 @@</span><br><span>  *  GNU General Public License for more details=
.</span><br><span>  *</span><br><span>  *  You should have received a copy =
of the GNU General Public License along</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *  with this program; if not, write to the Free Software=
 Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see=
 &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><spa=
n> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/ssl_verif=
y_mbedtls.h b/src/openvpn/ssl_verify_mbedtls.h</span><br><span>index ff2115=
7..3e380a6 100644</span><br><span>--- a/src/openvpn/ssl_verify_mbedtls.h</s=
pan><br><span>+++ b/src/openvpn/ssl_verify_mbedtls.h</span><br><span>@@ -18=
,8 +18,7 @@</span><br><span>  *  GNU General Public License for more detail=
s.</span><br><span>  *</span><br><span>  *  You should have received a copy=
 of the GNU General Public License along</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *  with this program; if not, write to the Free Softwar=
e Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, se=
e &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><sp=
an> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/ssl_veri=
fy_openssl.c b/src/openvpn/ssl_verify_openssl.c</span><br><span>index 15468=
15..0c206e3 100644</span><br><span>--- a/src/openvpn/ssl_verify_openssl.c</=
span><br><span>+++ b/src/openvpn/ssl_verify_openssl.c</span><br><span>@@ -1=
8,8 +18,7 @@</span><br><span>  *  GNU General Public License for more detai=
ls.</span><br><span>  *</span><br><span>  *  You should have received a cop=
y of the GNU General Public License along</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *  with this program; if not, write to the Free Softwa=
re Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, s=
ee &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><s=
pan> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/ssl_ver=
ify_openssl.h b/src/openvpn/ssl_verify_openssl.h</span><br><span>index 00c1=
06d..7577cb2 100644</span><br><span>--- a/src/openvpn/ssl_verify_openssl.h<=
/span><br><span>+++ b/src/openvpn/ssl_verify_openssl.h</span><br><span>@@ -=
18,8 +18,7 @@</span><br><span>  *  GNU General Public License for more deta=
ils.</span><br><span>  *</span><br><span>  *  You should have received a co=
py of the GNU General Public License along</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *  with this program; if not, write to the Free Softw=
are Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, =
see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><=
span> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/status=
.c b/src/openvpn/status.c</span><br><span>index 4b0e516..1f5e67a 100644</sp=
an><br><span>--- a/src/openvpn/status.c</span><br><span>+++ b/src/openvpn/s=
tatus.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General =
Public License for more details.</span><br><span>  *</span><br><span>  *  Y=
ou should have received a copy of the GNU General Public License along</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if =
not, write to the Free Software Foundation, Inc.,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA=
 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</spa=
n><br><span>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</s=
pan><br><span>diff --git a/src/openvpn/status.h b/src/openvpn/status.h</spa=
n><br><span>index eaed22a..ddbaeef 100644</span><br><span>--- a/src/openvpn=
/status.h</span><br><span>+++ b/src/openvpn/status.h</span><br><span>@@ -17=
,8 +17,7 @@</span><br><span>  *  GNU General Public License for more detail=
s.</span><br><span>  *</span><br><span>  *  You should have received a copy=
 of the GNU General Public License along</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *  with this program; if not, write to the Free Softwar=
e Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, se=
e &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><sp=
an> </span><br><span> #ifndef STATUS_H</span><br><span>diff --git a/src/ope=
nvpn/syshead.h b/src/openvpn/syshead.h</span><br><span>index 00d7685..e77f3=
13 100644</span><br><span>--- a/src/openvpn/syshead.h</span><br><span>+++ b=
/src/openvpn/syshead.h</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  =
*  GNU General Public License for more details.</span><br><span>  *</span><=
br><span>  *  You should have received a copy of the GNU General Public Lic=
ense along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with th=
is program; if not, write to the Free Software Foundation, Inc.,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Fl=
oor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.org/lice=
nses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> #ifndef =
SYSHEAD_H</span><br><span>diff --git a/src/openvpn/tls_crypt.c b/src/openvp=
n/tls_crypt.c</span><br><span>index 67e19382..b0c4291 100644</span><br><spa=
n>--- a/src/openvpn/tls_crypt.c</span><br><span>+++ b/src/openvpn/tls_crypt=
.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Publi=
c License for more details.</span><br><span>  *</span><br><span>  *  You sh=
ould have received a copy of the GNU General Public License along</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, =
write to the Free Software Foundation, Inc.,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 0211=
0-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with=
 this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br=
><span>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><=
br><span>diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h</sp=
an><br><span>index 42545d1..c8bd384 100644</span><br><span>--- a/src/openvp=
n/tls_crypt.h</span><br><span>+++ b/src/openvpn/tls_crypt.h</span><br><span=
>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License for more=
 details.</span><br><span>  *</span><br><span>  *  You should have received=
 a copy of the GNU General Public License along</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Free =
Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if =
not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span>=
<br><span> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/t=
un.c b/src/openvpn/tun.c</span><br><span>index d15d9eb6..a96a305 100644</sp=
an><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.=
c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public=
 License for more details.</span><br><span>  *</span><br><span>  *  You sho=
uld have received a copy of the GNU General Public License along</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, w=
rite to the Free Software Foundation, Inc.,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110=
-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with =
this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br>=
<span>  */</span><br><span> </span><br><span> /*</span><br><span>diff --git=
 a/src/openvpn/tun.h b/src/openvpn/tun.h</span><br><span>index 5407e47..c53=
fdc0 100644</span><br><span>--- a/src/openvpn/tun.h</span><br><span>+++ b/s=
rc/openvpn/tun.h</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU=
 General Public License for more details.</span><br><span>  *</span><br><sp=
an>  *  You should have received a copy of the GNU General Public License a=
long</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this pro=
gram; if not, write to the Free Software Foundation, Inc.,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, B=
oston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&=
gt;.</span><br><span>  */</span><br><span> </span><br><span> #ifndef TUN_H<=
/span><br><span>diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afu=
nix.c</span><br><span>index 50ef765..ac12070 100644</span><br><span>--- a/s=
rc/openvpn/tun_afunix.c</span><br><span>+++ b/src/openvpn/tun_afunix.c</spa=
n><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public Licen=
se for more details.</span><br><span>  *</span><br><span>  *  You should ha=
ve received a copy of the GNU General Public License along</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write t=
o the Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 =
USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this p=
rogram; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>=
  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><spa=
n>diff --git a/src/openvpn/tun_afunix.h b/src/openvpn/tun_afunix.h</span><b=
r><span>index 21ae676..faca142 100644</span><br><span>--- a/src/openvpn/tun=
_afunix.h</span><br><span>+++ b/src/openvpn/tun_afunix.h</span><br><span>@@=
 -17,8 +17,7 @@</span><br><span>  *  GNU General Public License for more de=
tails.</span><br><span>  *</span><br><span>  *  You should have received a =
copy of the GNU General Public License along</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Free Sof=
tware Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not=
, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br=
><span> </span><br><span> #ifndef AFUNIX_TUN_H</span><br><span>diff --git a=
/src/openvpn/vlan.c b/src/openvpn/vlan.c</span><br><span>index d0beb48..5cc=
23f4 100644</span><br><span>--- a/src/openvpn/vlan.c</span><br><span>+++ b/=
src/openvpn/vlan.c</span><br><span>@@ -18,8 +18,7 @@</span><br><span>  *  G=
NU General Public License for more details.</span><br><span>  *</span><br><=
span>  *  You should have received a copy of the GNU General Public License=
 along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this p=
rogram; if not, write to the Free Software Foundation, Inc.,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor,=
 Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses=
/&gt;.</span><br><span>  */</span><br><span> </span><br><span> #ifdef HAVE_=
CONFIG_H</span><br><span>diff --git a/src/openvpn/vlan.h b/src/openvpn/vlan=
.h</span><br><span>index f6cf385..7602585 100644</span><br><span>--- a/src/=
openvpn/vlan.h</span><br><span>+++ b/src/openvpn/vlan.h</span><br><span>@@ =
-18,8 +18,7 @@</span><br><span>  *  GNU General Public License for more det=
ails.</span><br><span>  *</span><br><span>  *  You should have received a c=
opy of the GNU General Public License along</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *  with this program; if not, write to the Free Soft=
ware Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not,=
 see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br>=
<span> </span><br><span> #ifndef VLAN_H</span><br><span>diff --git a/src/op=
envpn/wfp_block.c b/src/openvpn/wfp_block.c</span><br><span>index 2f13001..=
ce5cef2 100644</span><br><span>--- a/src/openvpn/wfp_block.c</span><br><spa=
n>+++ b/src/openvpn/wfp_block.c</span><br><span>@@ -19,8 +19,7 @@</span><br=
><span>  *  GNU General Public License for more details.</span><br><span>  =
*</span><br><span>  *  You should have received a copy of the GNU General P=
ublic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
  with this program; if not, write to the Free Software Foundation, Inc.,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street,=
 Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu=
.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span>=
 #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/wfp_block.h =
b/src/openvpn/wfp_block.h</span><br><span>index fc5ec7e..6de39f5 100644</sp=
an><br><span>--- a/src/openvpn/wfp_block.h</span><br><span>+++ b/src/openvp=
n/wfp_block.h</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU Ge=
neral Public License for more details.</span><br><span>  *</span><br><span>=
  *  You should have received a copy of the GNU General Public License alon=
g</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this progra=
m; if not, write to the Free Software Foundation, Inc.,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Bost=
on, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;=
.</span><br><span>  */</span><br><span> </span><br><span> #ifdef _WIN32</sp=
an><br><span>diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32-util=
.c</span><br><span>index dd55743..c23d066 100644</span><br><span>--- a/src/=
openvpn/win32-util.c</span><br><span>+++ b/src/openvpn/win32-util.c</span><=
br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License =
for more details.</span><br><span>  *</span><br><span>  *  You should have =
received a copy of the GNU General Public License along</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to t=
he Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this prog=
ram; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  *=
/</span><br><span> </span><br><span> /*</span><br><span>diff --git a/src/op=
envpn/win32-util.h b/src/openvpn/win32-util.h</span><br><span>index bd7c03a=
..df4f8b3 100644</span><br><span>--- a/src/openvpn/win32-util.h</span><br><=
span>+++ b/src/openvpn/win32-util.h</span><br><span>@@ -17,8 +17,7 @@</span=
><br><span>  *  GNU General Public License for more details.</span><br><spa=
n>  *</span><br><span>  *  You should have received a copy of the GNU Gener=
al Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *  with this program; if not, write to the Free Software Foundation, Inc=
.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Str=
eet, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=
.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><s=
pan> #ifdef _WIN32</span><br><span>diff --git a/src/openvpn/win32.c b/src/o=
penvpn/win32.c</span><br><span>index 8d6f9c3..0524c57 100644</span><br><spa=
n>--- a/src/openvpn/win32.c</span><br><span>+++ b/src/openvpn/win32.c</span=
><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public Licens=
e for more details.</span><br><span>  *</span><br><span>  *  You should hav=
e received a copy of the GNU General Public License along</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to=
 the Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 U=
SA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this pr=
ogram; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span> =
 */</span><br><span> </span><br><span> /*</span><br><span>diff --git a/src/=
openvpn/win32.h b/src/openvpn/win32.h</span><br><span>index 4b07d9e..34d18c=
6 100644</span><br><span>--- a/src/openvpn/win32.h</span><br><span>+++ b/sr=
c/openvpn/win32.h</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GN=
U General Public License for more details.</span><br><span>  *</span><br><s=
pan>  *  You should have received a copy of the GNU General Public License =
along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this pr=
ogram; if not, write to the Free Software Foundation, Inc.,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, =
Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/=
&gt;.</span><br><span>  */</span><br><span> </span><br><span> #ifdef _WIN32=
</span><br><span>diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_=
common.h</span><br><span>index 84c6329..111596e 100644</span><br><span>--- =
a/src/openvpn/xkey_common.h</span><br><span>+++ b/src/openvpn/xkey_common.h=
</span><br><span>@@ -18,8 +18,7 @@</span><br><span>  *  GNU General Public =
License for more details.</span><br><span>  *</span><br><span>  *  You shou=
ld have received a copy of the GNU General Public License along</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, wr=
ite to the Free Software Foundation, Inc.,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-=
1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with t=
his program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><=
span>  */</span><br><span> </span><br><span> #ifndef XKEY_COMMON_H_</span><=
br><span>diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c=
</span><br><span>index b5ed73c..487bfe6 100644</span><br><span>--- a/src/op=
envpn/xkey_helper.c</span><br><span>+++ b/src/openvpn/xkey_helper.c</span><=
br><span>@@ -18,8 +18,7 @@</span><br><span>  *  GNU General Public License =
for more details.</span><br><span>  *</span><br><span>  *  You should have =
received a copy of the GNU General Public License along</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to t=
he Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this prog=
ram; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  *=
/</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>d=
iff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c</span=
><br><span>index deaca38..edd64d3 100644</span><br><span>--- a/src/openvpn/=
xkey_provider.c</span><br><span>+++ b/src/openvpn/xkey_provider.c</span><br=
><span>@@ -18,8 +18,7 @@</span><br><span>  *  GNU General Public License fo=
r more details.</span><br><span>  *</span><br><span>  *  You should have re=
ceived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to the=
 Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progra=
m; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */<=
/span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>dif=
f --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am</span=
><br><span>index b463531..8dc3749 100644</span><br><span>--- a/src/openvpnm=
sica/Makefile.am</span><br><span>+++ b/src/openvpnmsica/Makefile.am</span><=
br><span>@@ -14,8 +14,7 @@</span><br><span> #  GNU General Public License f=
or more details.</span><br><span> #</span><br><span> #  You should have rec=
eived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#  with this program; if not, write to the =
Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#  with this program; =
if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span> #</span=
><br><span> </span><br><span> include $(top_srcdir)/ltrc.inc</span><br><spa=
n>diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c</spa=
n><br><span>index 6f14a5c..7121c02 100644</span><br><span>--- a/src/openvpn=
msica/dllmain.c</span><br><span>+++ b/src/openvpnmsica/dllmain.c</span><br>=
<span>@@ -14,8 +14,7 @@</span><br><span>  *  GNU General Public License for=
 more details.</span><br><span>  *</span><br><span>  *  You should have rec=
eived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to the=
 Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progra=
m; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */<=
/span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>dif=
f --git a/src/openvpnmsica/msica_arg.c b/src/openvpnmsica/msica_arg.c</span=
><br><span>index 0f5b2fb..46bef2b 100644</span><br><span>--- a/src/openvpnm=
sica/msica_arg.c</span><br><span>+++ b/src/openvpnmsica/msica_arg.c</span><=
br><span>@@ -14,8 +14,7 @@</span><br><span>  *  GNU General Public License =
for more details.</span><br><span>  *</span><br><span>  *  You should have =
received a copy of the GNU General Public License along</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to t=
he Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this prog=
ram; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  *=
/</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>d=
iff --git a/src/openvpnmsica/msica_arg.h b/src/openvpnmsica/msica_arg.h</sp=
an><br><span>index 2a3e931..c8f7595 100644</span><br><span>--- a/src/openvp=
nmsica/msica_arg.h</span><br><span>+++ b/src/openvpnmsica/msica_arg.h</span=
><br><span>@@ -14,8 +14,7 @@</span><br><span>  *  GNU General Public Licens=
e for more details.</span><br><span>  *</span><br><span>  *  You should hav=
e received a copy of the GNU General Public License along</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to=
 the Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 U=
SA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this pr=
ogram; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span> =
 */</span><br><span> </span><br><span> #ifndef MSICA_ARG_H</span><br><span>=
diff --git a/src/openvpnmsica/msiex.c b/src/openvpnmsica/msiex.c</span><br>=
<span>index c0f5853..3529e9a 100644</span><br><span>--- a/src/openvpnmsica/=
msiex.c</span><br><span>+++ b/src/openvpnmsica/msiex.c</span><br><span>@@ -=
14,8 +14,7 @@</span><br><span>  *  GNU General Public License for more deta=
ils.</span><br><span>  *</span><br><span>  *  You should have received a co=
py of the GNU General Public License along</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *  with this program; if not, write to the Free Softw=
are Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, =
see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><=
span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/s=
rc/openvpnmsica/msiex.h b/src/openvpnmsica/msiex.h</span><br><span>index ab=
029cc..d9afeb5 100644</span><br><span>--- a/src/openvpnmsica/msiex.h</span>=
<br><span>+++ b/src/openvpnmsica/msiex.h</span><br><span>@@ -14,8 +14,7 @@<=
/span><br><span>  *  GNU General Public License for more details.</span><br=
><span>  *</span><br><span>  *  You should have received a copy of the GNU =
General Public License along</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *  with this program; if not, write to the Free Software Foundation=
, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Frankli=
n Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https:=
//www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><=
br><span> #ifndef MSIHLP_H</span><br><span>diff --git a/src/openvpnmsica/op=
envpnmsica.c b/src/openvpnmsica/openvpnmsica.c</span><br><span>index 003da6=
e..8d860e2 100644</span><br><span>--- a/src/openvpnmsica/openvpnmsica.c</sp=
an><br><span>+++ b/src/openvpnmsica/openvpnmsica.c</span><br><span>@@ -14,8=
 +14,7 @@</span><br><span>  *  GNU General Public License for more details.=
</span><br><span>  *</span><br><span>  *  You should have received a copy o=
f the GNU General Public License along</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *  with this program; if not, write to the Free Software =
Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see =
&lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span=
> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/o=
penvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h</span><br><spa=
n>index b4e3aa8..d07554f 100644</span><br><span>--- a/src/openvpnmsica/open=
vpnmsica.h</span><br><span>+++ b/src/openvpnmsica/openvpnmsica.h</span><br>=
<span>@@ -14,8 +14,7 @@</span><br><span>  *  GNU General Public License for=
 more details.</span><br><span>  *</span><br><span>  *  You should have rec=
eived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to the=
 Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progra=
m; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */<=
/span><br><span> </span><br><span> #ifndef MSICA_H</span><br><span>diff --g=
it a/src/openvpnmsica/openvpnmsica_resources.rc b/src/openvpnmsica/openvpnm=
sica_resources.rc</span><br><span>index 0bf7330..d4e0274 100644</span><br><=
span>--- a/src/openvpnmsica/openvpnmsica_resources.rc</span><br><span>+++ b=
/src/openvpnmsica/openvpnmsica_resources.rc</span><br><span>@@ -13,8 +13,7 =
@@</span><br><span>  *  GNU General Public License for more details.</span>=
<br><span>  *</span><br><span>  *  You should have received a copy of the G=
NU General Public License along</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- *  with this program; if not, write to the Free Software Foundat=
ion, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Fran=
klin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;ht=
tps://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </sp=
an><br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn=
serv/common.c b/src/openvpnserv/common.c</span><br><span>index fe360fa..554=
3c37 100644</span><br><span>--- a/src/openvpnserv/common.c</span><br><span>=
+++ b/src/openvpnserv/common.c</span><br><span>@@ -17,8 +17,7 @@</span><br>=
<span>  *  GNU General Public License for more details.</span><br><span>  *=
</span><br><span>  *  You should have received a copy of the GNU General Pu=
blic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
 with this program; if not, write to the Free Software Foundation, Inc.,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, =
Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.=
org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> =
#include &quot;service.h&quot;</span><br><span>diff --git a/src/openvpnserv=
/interactive.c b/src/openvpnserv/interactive.c</span><br><span>index 628a96=
b..bc63296 100644</span><br><span>--- a/src/openvpnserv/interactive.c</span=
><br><span>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -17,8 +17=
,7 @@</span><br><span>  *  GNU General Public License for more details.</sp=
an><br><span>  *</span><br><span>  *  You should have received a copy of th=
e GNU General Public License along</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *  with this program; if not, write to the Free Software Foun=
dation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 F=
ranklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;=
https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </=
span><br><span> </span><br><span>diff --git a/src/openvpnserv/service.h b/s=
rc/openvpnserv/service.h</span><br><span>index bfbe466..8989e60 100644</spa=
n><br><span>--- a/src/openvpnserv/service.h</span><br><span>+++ b/src/openv=
pnserv/service.h</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU=
 General Public License for more details.</span><br><span>  *</span><br><sp=
an>  *  You should have received a copy of the GNU General Public License a=
long</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this pro=
gram; if not, write to the Free Software Foundation, Inc.,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, B=
oston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&=
gt;.</span><br><span>  */</span><br><span> </span><br><span> #ifndef _SERVI=
CE_H</span><br><span>diff --git a/src/openvpnserv/validate.c b/src/openvpns=
erv/validate.c</span><br><span>index 9231417..6ed5bea 100644</span><br><spa=
n>--- a/src/openvpnserv/validate.c</span><br><span>+++ b/src/openvpnserv/va=
lidate.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General=
 Public License for more details.</span><br><span>  *</span><br><span>  *  =
You should have received a copy of the GNU General Public License along</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if=
 not, write to the Free Software Foundation, Inc.,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, M=
A 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</sp=
an><br><span>  */</span><br><span> </span><br><span> #include &quot;validat=
e.h&quot;</span><br><span>diff --git a/src/openvpnserv/validate.h b/src/ope=
nvpnserv/validate.h</span><br><span>index 3ef577b..bde1892 100644</span><br=
><span>--- a/src/openvpnserv/validate.h</span><br><span>+++ b/src/openvpnse=
rv/validate.h</span><br><span>@@ -18,8 +18,7 @@</span><br><span>  *  GNU Ge=
neral Public License for more details.</span><br><span>  *</span><br><span>=
  *  You should have received a copy of the GNU General Public License alon=
g</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this progra=
m; if not, write to the Free Software Foundation, Inc.,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Bost=
on, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;=
.</span><br><span>  */</span><br><span> </span><br><span> #ifndef VALIDATE_=
H</span><br><span>diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugin=
s/auth-pam/auth-pam.c</span><br><span>index 7264f95..bff4767 100644</span><=
br><span>--- a/src/plugins/auth-pam/auth-pam.c</span><br><span>+++ b/src/pl=
ugins/auth-pam/auth-pam.c</span><br><span>@@ -18,8 +18,7 @@</span><br><span=
>  *  GNU General Public License for more details.</span><br><span>  *</spa=
n><br><span>  *  You should have received a copy of the GNU General Public =
License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with=
 this program; if not, write to the Free Software Foundation, Inc.,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth=
 Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.org/l=
icenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> /*</s=
pan><br><span>diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-=
pam/utils.c</span><br><span>index ab5e17e..6524051 100644</span><br><span>-=
-- a/src/plugins/auth-pam/utils.c</span><br><span>+++ b/src/plugins/auth-pa=
m/utils.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU Genera=
l Public License for more details.</span><br><span>  *</span><br><span>  * =
 You should have received a copy of the GNU General Public License along</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; i=
f not, write to the Free Software Foundation, Inc.,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston=
, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.<=
/span><br><span>  */</span><br><span> </span><br><span> /*</span><br><span>=
diff --git a/src/plugins/auth-pam/utils.h b/src/plugins/auth-pam/utils.h</s=
pan><br><span>index 844d2d1..0b90aee 100644</span><br><span>--- a/src/plugi=
ns/auth-pam/utils.h</span><br><span>+++ b/src/plugins/auth-pam/utils.h</spa=
n><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public Licen=
se for more details.</span><br><span>  *</span><br><span>  *  You should ha=
ve received a copy of the GNU General Public License along</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write t=
o the Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 =
USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this p=
rogram; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>=
  */</span><br><span> </span><br><span> #ifndef _PLUGIN_AUTH_PAM_UTILS__H</=
span><br><span>diff --git a/src/plugins/down-root/down-root.c b/src/plugins=
/down-root/down-root.c</span><br><span>index 2c0faf4..5f595fd 100644</span>=
<br><span>--- a/src/plugins/down-root/down-root.c</span><br><span>+++ b/src=
/plugins/down-root/down-root.c</span><br><span>@@ -18,8 +18,7 @@</span><br>=
<span>  *  GNU General Public License for more details.</span><br><span>  *=
</span><br><span>  *  You should have received a copy of the GNU General Pu=
blic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
 with this program; if not, write to the Free Software Foundation, Inc.,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, =
Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.=
org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> =
/*</span><br><span>diff --git a/src/tapctl/Makefile.am b/src/tapctl/Makefil=
e.am</span><br><span>index 86c8dc1..07fd714 100644</span><br><span>--- a/sr=
c/tapctl/Makefile.am</span><br><span>+++ b/src/tapctl/Makefile.am</span><br=
><span>@@ -14,8 +14,7 @@</span><br><span> #  GNU General Public License for=
 more details.</span><br><span> #</span><br><span> #  You should have recei=
ved a copy of the GNU General Public License along</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#  with this program; if not, write to the Fre=
e Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#  with this program; if =
not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span> #</span><b=
r><span> </span><br><span> include $(top_srcdir)/ltrc.inc</span><br><span>d=
iff --git a/src/tapctl/basic.h b/src/tapctl/basic.h</span><br><span>index 3=
814db1..571ae62 100644</span><br><span>--- a/src/tapctl/basic.h</span><br><=
span>+++ b/src/tapctl/basic.h</span><br><span>@@ -15,8 +15,7 @@</span><br><=
span>  *  GNU General Public License for more details.</span><br><span>  *<=
/span><br><span>  *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
with this program; if not, write to the Free Software Foundation, Inc.,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, F=
ifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.o=
rg/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> #=
ifndef BASIC_H</span><br><span>diff --git a/src/tapctl/error.c b/src/tapctl=
/error.c</span><br><span>index 10c89d5..9f5094e 100644</span><br><span>--- =
a/src/tapctl/error.c</span><br><span>+++ b/src/tapctl/error.c</span><br><sp=
an>@@ -15,8 +15,7 @@</span><br><span>  *  GNU General Public License for mo=
re details.</span><br><span>  *</span><br><span>  *  You should have receiv=
ed a copy of the GNU General Public License along</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Fre=
e Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; i=
f not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</spa=
n><br><span> </span><br><span> #include &quot;error.h&quot;</span><br><span=
>diff --git a/src/tapctl/error.h b/src/tapctl/error.h</span><br><span>index=
 42c175e..3da5674 100644</span><br><span>--- a/src/tapctl/error.h</span><br=
><span>+++ b/src/tapctl/error.h</span><br><span>@@ -15,8 +15,7 @@</span><br=
><span>  *  GNU General Public License for more details.</span><br><span>  =
*</span><br><span>  *  You should have received a copy of the GNU General P=
ublic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
  with this program; if not, write to the Free Software Foundation, Inc.,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street,=
 Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu=
.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span>=
 #ifndef ERROR_H</span><br><span>diff --git a/src/tapctl/main.c b/src/tapct=
l/main.c</span><br><span>index 58ab8cc..82caeaf 100644</span><br><span>--- =
a/src/tapctl/main.c</span><br><span>+++ b/src/tapctl/main.c</span><br><span=
>@@ -15,8 +15,7 @@</span><br><span>  *  GNU General Public License for more=
 details.</span><br><span>  *</span><br><span>  *  You should have received=
 a copy of the GNU General Public License along</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Free =
Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if =
not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span>=
<br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --gi=
t a/src/tapctl/tap.c b/src/tapctl/tap.c</span><br><span>index 39b43ac..96f0=
9ee 100644</span><br><span>--- a/src/tapctl/tap.c</span><br><span>+++ b/src=
/tapctl/tap.c</span><br><span>@@ -14,8 +14,7 @@</span><br><span>  *  GNU Ge=
neral Public License for more details.</span><br><span>  *</span><br><span>=
  *  You should have received a copy of the GNU General Public License alon=
g</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this progra=
m; if not, write to the Free Software Foundation, Inc.,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Bost=
on, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;=
.</span><br><span>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFI=
G_H</span><br><span>diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h</span>=
<br><span>index 1ca512a..a0b0561 100644</span><br><span>--- a/src/tapctl/ta=
p.h</span><br><span>+++ b/src/tapctl/tap.h</span><br><span>@@ -14,8 +14,7 @=
@</span><br><span>  *  GNU General Public License for more details.</span><=
br><span>  *</span><br><span>  *  You should have received a copy of the GN=
U General Public License along</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- *  with this program; if not, write to the Free Software Foundati=
on, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Frank=
lin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;ht=
tps://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </sp=
an><br><span> #ifndef TAP_H</span><br><span>diff --git a/src/tapctl/tapctl_=
resources.rc b/src/tapctl/tapctl_resources.rc</span><br><span>index f2a1ae0=
..f84fd6d 100644</span><br><span>--- a/src/tapctl/tapctl_resources.rc</span=
><br><span>+++ b/src/tapctl/tapctl_resources.rc</span><br><span>@@ -13,8 +1=
3,7 @@</span><br><span>  *  GNU General Public License for more details.</s=
pan><br><span>  *</span><br><span>  *  You should have received a copy of t=
he GNU General Public License along</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- *  with this program; if not, write to the Free Software Fou=
ndation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 =
Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt=
;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> <=
/span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/tests/nt=
lm_support.c b/tests/ntlm_support.c</span><br><span>index f5eba88..3960cc5 =
100644</span><br><span>--- a/tests/ntlm_support.c</span><br><span>+++ b/tes=
ts/ntlm_support.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GN=
U General Public License for more details.</span><br><span>  *</span><br><s=
pan>  *  You should have received a copy of the GNU General Public License =
along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this pr=
ogram; if not, write to the Free Software Foundation, Inc.,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, =
Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/=
&gt;.</span><br><span>  */</span><br><span> </span><br><span> #ifdef HAVE_C=
ONFIG_H</span><br><span>diff --git a/tests/t_cltsrv.sh b/tests/t_cltsrv.sh<=
/span><br><span>index 4a8643a..6b7df65 100755</span><br><span>--- a/tests/t=
_cltsrv.sh</span><br><span>+++ b/tests/t_cltsrv.sh</span><br><span>@@ -14,9=
 +14,7 @@</span><br><span> # GNU General Public License for more details.</=
span><br><span> #</span><br><span> # You should have received a copy of the=
 GNU General Public License</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-# along with this program; if not, write to the Free Software</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-# Foundation, Inc., 51 Frankl=
in Street, Fifth Floor, Boston, MA</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-# 02110-1301, USA.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# along with this program; if not, see &lt;https://www.gnu.org/=
licenses/&gt;.</span><br><span> </span><br><span> set -e</span><br><span> s=
rcdir=3D&quot;${srcdir:-.}&quot;</span><br><span>diff --git a/tests/t_lpbac=
k.sh b/tests/t_lpback.sh</span><br><span>index 68df2a6..8ab3973 100755</spa=
n><br><span>--- a/tests/t_lpback.sh</span><br><span>+++ b/tests/t_lpback.sh=
</span><br><span>@@ -15,9 +15,7 @@</span><br><span> # GNU General Public Li=
cense for more details.</span><br><span> #</span><br><span> # You should ha=
ve received a copy of the GNU General Public License</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# along with this program; if not, write to=
 the Free Software</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# F=
oundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-# 02110-1301, USA.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+# along with this program; if not, se=
e &lt;https://www.gnu.org/licenses/&gt;.</span><br><span> </span><br><span>=
 set -eu</span><br><span> top_builddir=3D&quot;${top_builddir:-..}&quot;</s=
pan><br><span>diff --git a/tests/unit_tests/openvpn/cert_data.h b/tests/uni=
t_tests/openvpn/cert_data.h</span><br><span>index bbf3736..638af39 100644</=
span><br><span>--- a/tests/unit_tests/openvpn/cert_data.h</span><br><span>+=
++ b/tests/unit_tests/openvpn/cert_data.h</span><br><span>@@ -18,8 +18,7 @@=
</span><br><span>  *  GNU General Public License for more details.</span><b=
r><span>  *</span><br><span>  *  You should have received a copy of the GNU=
 General Public License along</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *  with this program; if not, write to the Free Software Foundatio=
n, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Frankl=
in Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https=
://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span>=
<br><span> #ifndef CERT_DATA_H</span><br><span>diff --git a/tests/unit_test=
s/openvpn/mock_get_random.c b/tests/unit_tests/openvpn/mock_get_random.c</s=
pan><br><span>index dfc7287..77db18e 100644</span><br><span>--- a/tests/uni=
t_tests/openvpn/mock_get_random.c</span><br><span>+++ b/tests/unit_tests/op=
envpn/mock_get_random.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span> =
 *  GNU General Public License for more details.</span><br><span>  *</span>=
<br><span>  *  You should have received a copy of the GNU General Public Li=
cense along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with t=
his program; if not, write to the Free Software Foundation, Inc.,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth F=
loor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.org/lic=
enses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> #includ=
e &lt;stdarg.h&gt;</span><br><span>diff --git a/tests/unit_tests/openvpn/mo=
ck_management.c b/tests/unit_tests/openvpn/mock_management.c</span><br><spa=
n>index c3e38b9..9674b45 100644</span><br><span>--- a/tests/unit_tests/open=
vpn/mock_management.c</span><br><span>+++ b/tests/unit_tests/openvpn/mock_m=
anagement.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU Gene=
ral Public License for more details.</span><br><span>  *</span><br><span>  =
*  You should have received a copy of the GNU General Public License along<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program;=
 if not, write to the Free Software Foundation, Inc.,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston=
, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.<=
/span><br><span>  */</span><br><span> </span><br><span> /* Minimal set of m=
ocked management function/globals to get unit tests to</span><br><span>diff=
 --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn/moc=
k_msg.c</span><br><span>index b6ec744..5407561 100644</span><br><span>--- a=
/tests/unit_tests/openvpn/mock_msg.c</span><br><span>+++ b/tests/unit_tests=
/openvpn/mock_msg.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  =
GNU General Public License for more details.</span><br><span>  *</span><br>=
<span>  *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this =
program; if not, write to the Free Software Foundation, Inc.,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor=
, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  with this program; if not, see &lt;https://www.gnu.org/license=
s/&gt;.</span><br><span>  */</span><br><span> </span><br><span> #ifdef HAVE=
_CONFIG_H</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_msg.h =
b/tests/unit_tests/openvpn/mock_msg.h</span><br><span>index bc2ee5d..40d760=
9 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_msg.h</span><b=
r><span>+++ b/tests/unit_tests/openvpn/mock_msg.h</span><br><span>@@ -17,8 =
+17,7 @@</span><br><span>  *  GNU General Public License for more details.<=
/span><br><span>  *</span><br><span>  *  You should have received a copy of=
 the GNU General Public License along</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- *  with this program; if not, write to the Free Software F=
oundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  5=
1 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &=
lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span>=
 </span><br><span> #ifndef MOCK_MSG_H</span><br><span>diff --git a/tests/un=
it_tests/openvpn/mock_ssl_dependencies.c b/tests/unit_tests/openvpn/mock_ss=
l_dependencies.c</span><br><span>index 5cfe8d0..2a562fc 100644</span><br><s=
pan>--- a/tests/unit_tests/openvpn/mock_ssl_dependencies.c</span><br><span>=
+++ b/tests/unit_tests/openvpn/mock_ssl_dependencies.c</span><br><span>@@ -=
17,8 +17,7 @@</span><br><span>  *  GNU General Public License for more deta=
ils.</span><br><span>  *</span><br><span>  *  You should have received a co=
py of the GNU General Public License along</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *  with this program; if not, write to the Free Softw=
are Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, =
see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><=
span> </span><br><span> /* Minimal set of mocked function/globals to get un=
it tests to</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_win3=
2_execve.c b/tests/unit_tests/openvpn/mock_win32_execve.c</span><br><span>i=
ndex 26f8a84..0666fe8 100644</span><br><span>--- a/tests/unit_tests/openvpn=
/mock_win32_execve.c</span><br><span>+++ b/tests/unit_tests/openvpn/mock_wi=
n32_execve.c</span><br><span>@@ -19,8 +19,7 @@</span><br><span>  *  GNU Gen=
eral Public License for more details.</span><br><span>  *</span><br><span> =
 *  You should have received a copy of the GNU General Public License along=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program=
; if not, write to the Free Software Foundation, Inc.,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Bosto=
n, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.=
</span><br><span>  */</span><br><span> </span><br><span> #include &quot;con=
fig.h&quot;</span><br><span>diff --git a/tests/unit_tests/openvpn/pkey_test=
_utils.c b/tests/unit_tests/openvpn/pkey_test_utils.c</span><br><span>index=
 9a044ec..56608ea 100644</span><br><span>--- a/tests/unit_tests/openvpn/pke=
y_test_utils.c</span><br><span>+++ b/tests/unit_tests/openvpn/pkey_test_uti=
ls.c</span><br><span>@@ -18,8 +18,7 @@</span><br><span>  *  GNU General Pub=
lic License for more details.</span><br><span>  *</span><br><span>  *  You =
should have received a copy of the GNU General Public License along</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not=
, write to the Free Software Foundation, Inc.,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02=
110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  wi=
th this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><=
br><span>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span=
><br><span>diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/=
unit_tests/openvpn/test_auth_token.c</span><br><span>index be3b2b7..960422c=
 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_auth_token.c</s=
pan><br><span>+++ b/tests/unit_tests/openvpn/test_auth_token.c</span><br><s=
pan>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License for m=
ore details.</span><br><span>  *</span><br><span>  *  You should have recei=
ved a copy of the GNU General Public License along</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Fr=
ee Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; =
if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</sp=
an><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff -=
-git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/te=
st_buffer.c</span><br><span>index 3a1007a..4b3aaf8 100644</span><br><span>-=
-- a/tests/unit_tests/openvpn/test_buffer.c</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_buffer.c</span><br><span>@@ -17,8 +17,7 @@</span><br><=
span>  *  GNU General Public License for more details.</span><br><span>  *<=
/span><br><span>  *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
with this program; if not, write to the Free Software Foundation, Inc.,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, F=
ifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.o=
rg/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> #=
ifdef HAVE_CONFIG_H</span><br><span>diff --git a/tests/unit_tests/openvpn/t=
est_common.h b/tests/unit_tests/openvpn/test_common.h</span><br><span>index=
 52503c6..2f2207a 100644</span><br><span>--- a/tests/unit_tests/openvpn/tes=
t_common.h</span><br><span>+++ b/tests/unit_tests/openvpn/test_common.h</sp=
an><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public Lice=
nse for more details.</span><br><span>  *</span><br><span>  *  You should h=
ave received a copy of the GNU General Public License along</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write =
to the Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301=
 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this =
program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span=
>  */</span><br><span> </span><br><span> #include &lt;stdio.h&gt;</span><br=
><span>diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tes=
ts/openvpn/test_crypto.c</span><br><span>index 5b583c7..1c3b146 100644</spa=
n><br><span>--- a/tests/unit_tests/openvpn/test_crypto.c</span><br><span>++=
+ b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>@@ -17,8 +17,7 @=
@</span><br><span>  *  GNU General Public License for more details.</span><=
br><span>  *</span><br><span>  *  You should have received a copy of the GN=
U General Public License along</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- *  with this program; if not, write to the Free Software Foundati=
on, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Frank=
lin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;ht=
tps://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </sp=
an><br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/tests/unit_=
tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c<=
/span><br><span>index 9225b4d..072cc78 100644</span><br><span>--- a/tests/u=
nit_tests/openvpn/test_cryptoapi.c</span><br><span>+++ b/tests/unit_tests/o=
penvpn/test_cryptoapi.c</span><br><span>@@ -18,8 +18,7 @@</span><br><span> =
 *  GNU General Public License for more details.</span><br><span>  *</span>=
<br><span>  *  You should have received a copy of the GNU General Public Li=
cense along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with t=
his program; if not, write to the Free Software Foundation, Inc.,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth F=
loor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.org/lic=
enses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> #ifdef =
HAVE_CONFIG_H</span><br><span>diff --git a/tests/unit_tests/openvpn/test_mi=
sc.c b/tests/unit_tests/openvpn/test_misc.c</span><br><span>index 0981a1a..=
fb46e99 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_misc.c</=
span><br><span>+++ b/tests/unit_tests/openvpn/test_misc.c</span><br><span>@=
@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License for more d=
etails.</span><br><span>  *</span><br><span>  *  You should have received a=
 copy of the GNU General Public License along</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Free So=
ftware Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if no=
t, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><b=
r><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git =
a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c=
</span><br><span>index 9c40f5c..941216a 100644</span><br><span>--- a/tests/=
unit_tests/openvpn/test_ncp.c</span><br><span>+++ b/tests/unit_tests/openvp=
n/test_ncp.c</span><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU Gen=
eral Public License for more details.</span><br><span>  *</span><br><span> =
 *  You should have received a copy of the GNU General Public License along=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program=
; if not, write to the Free Software Foundation, Inc.,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Bosto=
n, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.=
</span><br><span>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG=
_H</span><br><span>diff --git a/tests/unit_tests/openvpn/test_packet_id.c b=
/tests/unit_tests/openvpn/test_packet_id.c</span><br><span>index 312a6b3d..=
084db5e 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_packet_i=
d.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_packet_id.c</span><=
br><span>@@ -18,8 +18,7 @@</span><br><span>  *</span><br><span>  *  You sho=
uld have received a copy of the GNU General Public License</span><br><span>=
  *  along with this program (see the file COPYING included with this</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *  distribution); if not, =
write to the Free Software Foundation, Inc.,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *  59 Temple Place, Suite 330, Boston, MA  02111-13=
07  USA</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  distribu=
tion); if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span> =
 */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span=
>diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/ope=
nvpn/test_pkcs11.c</span><br><span>index adad40b..591a457 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/test_pkcs11.c</span><br><span>+++ b/te=
sts/unit_tests/openvpn/test_pkcs11.c</span><br><span>@@ -18,8 +18,7 @@</spa=
n><br><span>  *  GNU General Public License for more details.</span><br><sp=
an>  *</span><br><span>  *  You should have received a copy of the GNU Gene=
ral Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *  with this program; if not, write to the Free Software Foundation, In=
c.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin St=
reet, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://ww=
w.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><=
span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/tests/unit_tests/op=
envpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c</span><br><span>inde=
x ebffabe..46206fe 100644</span><br><span>--- a/tests/unit_tests/openvpn/te=
st_pkt.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt.c</span><b=
r><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public License f=
or more details.</span><br><span>  *</span><br><span>  *  You should have r=
eceived a copy of the GNU General Public License along</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write to th=
e Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progr=
am; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */=
</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>di=
ff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/open=
vpn/test_provider.c</span><br><span>index fd38d3b..a8aea0c 100644</span><br=
><span>--- a/tests/unit_tests/openvpn/test_provider.c</span><br><span>+++ b=
/tests/unit_tests/openvpn/test_provider.c</span><br><span>@@ -18,8 +18,7 @@=
</span><br><span>  *  GNU General Public License for more details.</span><b=
r><span>  *</span><br><span>  *  You should have received a copy of the GNU=
 General Public License along</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *  with this program; if not, write to the Free Software Foundatio=
n, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Frankl=
in Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https=
://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span>=
<br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/tests/unit_tes=
ts/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c</span><br><span=
>index 2a05c4f..c758f87 100644</span><br><span>--- a/tests/unit_tests/openv=
pn/test_ssl.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl.c</sp=
an><br><span>@@ -17,8 +17,7 @@</span><br><span>  *  GNU General Public Lice=
nse for more details.</span><br><span>  *</span><br><span>  *  You should h=
ave received a copy of the GNU General Public License along</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, write =
to the Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301=
 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this =
program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span=
>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><sp=
an>diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_test=
s/openvpn/test_tls_crypt.c</span><br><span>index cc415c8..1b5eb27 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><sp=
an>+++ b/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><span>@@ -17,8=
 +17,7 @@</span><br><span>  *  GNU General Public License for more details.=
</span><br><span>  *</span><br><span>  *  You should have received a copy o=
f the GNU General Public License along</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *  with this program; if not, write to the Free Software =
Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see =
&lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span=
> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/tests=
/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_p=
ass.c</span><br><span>index 400c0f4..74f67a7 100644</span><br><span>--- a/t=
ests/unit_tests/openvpn/test_user_pass.c</span><br><span>+++ b/tests/unit_t=
ests/openvpn/test_user_pass.c</span><br><span>@@ -18,8 +18,7 @@</span><br><=
span>  *  GNU General Public License for more details.</span><br><span>  *<=
/span><br><span>  *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
with this program; if not, write to the Free Software Foundation, Inc.,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, F=
ifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.o=
rg/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br><span> #=
ifdef HAVE_CONFIG_H</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1124?usp=3Demail">change 1124<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1124?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic3959970fa9ab993e98d4b38c02=
5fd0efc7b92f2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1124 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--E8vzTfyB2Fk=--

