From: Greg Cox <gcox@...1057...>
Date: Mon, 30 Mar 2026 23:13:56 +0000
Message-ID: <20260330231355.84547-2-gcox@...1057...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Update --learn-address man page with ipv6
 information
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

Update --learn-address man page with ipv6 information

The `--learn-address` option is very v4-specific in its man page.
This expands the docs based on things I tripped over when bringing up a dual-stack server.

Signed-off-by: Greg Cox <gcox@...1057...>


---
 doc/man-sections/script-options.rst | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index 58baf1e3614f66cc46d841fc9b4a40ed85b0e98f..f420380f00cbd2b5e421823cff96139337398203 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -52,7 +52,7 @@ Script Order of Execution
 
 #. ``--learn-address``
 
-   Executed in ``--mode server`` mode whenever an IPv4 address/route or MAC
+   Executed in ``--mode server`` mode whenever an IP address/route or MAC
    address is added to OpenVPN's internal routing table.
 
 #. ``--auth-user-pass-verify``
@@ -331,10 +331,14 @@ SCRIPT HOOKS
       OpenVPN's internal routing table.
 
   :code:`$2` - [address]
-      The address being learned or unlearned. This can be an IPv4 address
-      such as :code:`"198.162.10.14"`, an IPv4 subnet such as
-      :code:`"198.162.10.0/24"`, or an ethernet MAC address (when
-      ``--dev tap`` is being used) such as :code:`"00:FF:01:02:03:04"`.
+      The address being learned or unlearned. This can be:
+
+      * an IPv4 address such as :code:`"198.162.10.14"`,
+      * an IPv4 subnet such as :code:`"198.162.10.0/24"`,
+      * an IPv6 address such as :code:`"2001:db8:1:2:3:4:5:6"`,
+      * an IPv6 subnet such as :code:`"2001:db8:1:2:3:4:5::/112"`, or
+      * an ethernet MAC address (when ``--dev tap`` is being used)
+        such as :code:`"00:FF:01:02:03:04"`.
 
   :code:`$3` - [common name]
       The common name on the certificate associated with the client linked
@@ -353,6 +357,10 @@ SCRIPT HOOKS
   high-level common name, rather than the low level client virtual
   addresses.
 
+  A dual-stack client connecting to a dual-stack server will cause two calls
+  to the ``cmd`` script in quick succession, as the server learns each of the
+  IPv4 and IPv6 client addresses.
+
 --route-up cmd
   Run command ``cmd`` after routes are added, subject to ``--route-delay``.
 
-- 
2.50.1 (Apple Git-155)


