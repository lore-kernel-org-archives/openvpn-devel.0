From: Gert Doering <gert@...1296...>
Date: Sun,  3 Aug 2025 16:51:20 +0200
Message-ID: <20250803145126.23494-1-gert@...1296...>
In-Reply-To: <gerrit.1753966620000.Ic3959970fa9ab993e98d4b38c025fd0efc7b92f2@...2715...>
References: <gerrit.1753966620000.Ic3959970fa9ab993e98d4b38c025fd0efc7b92f2@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Update GPL header in all source files to
 current recommended version
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

From: Frank Lichtenheld <frank@...2641...>

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
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1124
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
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
 
 ACLOCAL_AMFLAGS = -I m4
diff --git a/compat.m4 b/compat.m4
index 8fa9abe..2cf9844 100644
--- a/compat.m4
+++ b/compat.m4
@@ -17,8 +17,7 @@
 dnl  GNU General Public License for more details.
 dnl
 dnl  You should have received a copy of the GNU General Public License along
-dnl  with this program; if not, write to the Free Software Foundation, Inc.,
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
 dnl  You should have received a copy of the GNU General Public License along
-dnl  with this program; if not, write to the Free Software Foundation, Inc.,
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
diff --git a/contrib/cmake/parse-version.m4.py b/contrib/cmake/parse-version.m4.py
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
diff --git a/dev-tools/gen-release-tarballs.sh b/dev-tools/gen-release-tarballs.sh
index 6262dd4..7b97aa6 100755
--- a/dev-tools/gen-release-tarballs.sh
+++ b/dev-tools/gen-release-tarballs.sh
@@ -14,8 +14,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
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
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+# along with this program; if not, see <https://www.gnu.org/licenses/>.
 #
 
 tstamp="$(date +%Y%m%d-%H%M%S)"
diff --git a/dev-tools/update-copyright.sh b/dev-tools/update-copyright.sh
index f6c8cdf..d19343f 100755
--- a/dev-tools/update-copyright.sh
+++ b/dev-tools/update-copyright.sh
@@ -16,8 +16,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
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
diff --git a/doc/doxygen/doc_control_processor.h b/doc/doxygen/doc_control_processor.h
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
diff --git a/doc/doxygen/doc_external_multiplexer.h b/doc/doxygen/doc_external_multiplexer.h
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
diff --git a/doc/doxygen/doc_fragmentation.h b/doc/doxygen/doc_fragmentation.h
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
diff --git a/doc/doxygen/doc_internal_multiplexer.h b/doc/doxygen/doc_internal_multiplexer.h
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
diff --git a/doc/doxygen/doc_key_generation.h b/doc/doxygen/doc_key_generation.h
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
diff --git a/doc/doxygen/doc_memory_management.h b/doc/doxygen/doc_memory_management.h
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
diff --git a/doc/doxygen/doc_protocol_overview.h b/doc/doxygen/doc_protocol_overview.h
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
diff --git a/sample/sample-plugins/client-connect/sample-client-connect.c b/sample/sample-plugins/client-connect/sample-client-connect.c
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
diff --git a/sample/sample-plugins/defer/multi-auth.c b/sample/sample-plugins/defer/multi-auth.c
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
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
index f1f8868..b73144f 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
@@ -17,8 +17,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/sample/sample-plugins/log/log.c b/sample/sample-plugins/log/log.c
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
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
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
diff --git a/sample/sample-plugins/simple/base64.c b/sample/sample-plugins/simple/base64.c
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
diff --git a/sample/sample-plugins/simple/simple.c b/sample/sample-plugins/simple/simple.c
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
diff --git a/src/compat/compat-gettimeofday.c b/src/compat/compat-gettimeofday.c
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
  *  A printf-like function (that only recognizes a subset of standard printf
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
  *  A printf-like function (that only recognizes a subset of standard printf
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
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
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
diff --git a/src/openvpn/networking_iproute2.h b/src/openvpn/networking_iproute2.h
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
index 3ceada0..76c9832 100644
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
  *  This particular file (uapi.h) is also licensed using the MIT license (see COPYRIGHT.MIT).
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
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
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
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
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
diff --git a/src/openvpn/ssl_verify_mbedtls.h b/src/openvpn/ssl_verify_mbedtls.h
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
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
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
diff --git a/src/openvpn/ssl_verify_openssl.h b/src/openvpn/ssl_verify_openssl.h
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
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
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
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
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
diff --git a/src/openvpnmsica/openvpnmsica_resources.rc b/src/openvpnmsica/openvpnmsica_resources.rc
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
 
 #ifndef VALIDATE_H
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
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
diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
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
 srcdir="${srcdir:-.}"
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
 top_builddir="${top_builddir:-..}"
diff --git a/tests/unit_tests/openvpn/cert_data.h b/tests/unit_tests/openvpn/cert_data.h
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
diff --git a/tests/unit_tests/openvpn/mock_get_random.c b/tests/unit_tests/openvpn/mock_get_random.c
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
diff --git a/tests/unit_tests/openvpn/mock_management.c b/tests/unit_tests/openvpn/mock_management.c
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
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c
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
diff --git a/tests/unit_tests/openvpn/mock_msg.h b/tests/unit_tests/openvpn/mock_msg.h
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
diff --git a/tests/unit_tests/openvpn/mock_ssl_dependencies.c b/tests/unit_tests/openvpn/mock_ssl_dependencies.c
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
diff --git a/tests/unit_tests/openvpn/mock_win32_execve.c b/tests/unit_tests/openvpn/mock_win32_execve.c
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
diff --git a/tests/unit_tests/openvpn/pkey_test_utils.c b/tests/unit_tests/openvpn/pkey_test_utils.c
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
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
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
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
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
diff --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/openvpn/test_common.h
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
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
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
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
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
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
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
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
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
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
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
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c
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
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
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
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c
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
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
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
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
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
 
 #ifdef HAVE_CONFIG_H
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c
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

