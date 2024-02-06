From: Frank Lichtenheld <frank@...2641...>
Date: Tue,  6 Feb 2024 18:47:45 +0100
Message-Id: <20240206174745.74828-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] documentation: Fixes for previous fixes to
 --push-peer-info
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

- Clarify compression IV_ settings
- Clarify which settings might come from --setenv

Change-Id: Id8615515c8df6e38e931e357396811234faad796
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 doc/man-sections/client-options.rst | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

For master and release/2.6

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index cd3e565f..b92b1a46 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -374,10 +374,11 @@ configuration.
   :code:`IV_GUI_VER=<gui_id> <version>`
         The UI version of a UI if one is running, for example
         :code:`de.blinkt.openvpn 0.5.47` for the Android app.
+        This may be set by the client UI/GUI using ``--setenv``.
 
   :code:`IV_SSO=[crtext,][openurl,][proxy_url]`
         Additional authentication methods supported by the client.
-        This may be set by the client UI/GUI using ``--setenv``
+        This may be set by the client UI/GUI using ``--setenv``.
 
   The following flags depend on which compression formats are compiled in
   and whether compression is allowed by options. See `Protocol options`_
@@ -388,13 +389,15 @@ configuration.
 
     :code:`IV_LZO_STUB=1`
         If client was built with LZO stub capability. This is only sent if
-        ``IV_LZO=1`` is not sent.
+        ``IV_LZO=1`` is not sent. This means the client can talk to a server
+        configured with ``--comp-lzo no``.
 
     :code:`IV_LZ4=1` and :code:`IV_LZ4v2=1`
         If the client supports LZ4 compression.
 
     :code:`IV_COMP_STUB=1` and :code:`IV_COMP_STUBv2=1`
-        If the client supports stub compression.
+        If the client supports stub compression. This means the client can talk
+        to a server configured with ``--compress``.
 
   When ``--push-peer-info`` is enabled the additional information consists
   of the following data:
@@ -414,7 +417,9 @@ configuration.
 
   :code:`IV_PLAT_VER=x.y`
         The version of the operating system, e.g. 6.1 for Windows 7.
-        This is only sent on Windows operating systems.
+        This may be set by the client UI/GUI using ``--setenv``.
+        On Windows systems it is automatically determined by openvpn
+        itself.
 
   :code:`UV_<name>=<value>`
         Client environment variables whose names start with
-- 
2.34.1


