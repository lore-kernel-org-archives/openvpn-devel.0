From: Gert Doering <gert@...1296...>
Date: Wed, 26 Nov 2025 13:00:04 +0100
Message-ID: <20251126120009.12191-1-gert@...1296...>
In-Reply-To: <gerrit.1764157430000.I8e390a276418dda9e7caa6edcd3a9d59d50ce4f8@...2715...>
References: <gerrit.1764157430000.I8e390a276418dda9e7caa6edcd3a9d59d50ce4f8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Changes.rst: Fix various syntax errors
 and typos
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

Mostly people trying to write MarkDown, but this is
reStructuredText.

Change-Id: I8e390a276418dda9e7caa6edcd3a9d59d50ce4f8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1405
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1405
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/Changes.rst b/Changes.rst
index 9077064..f46f7f1 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -112,7 +112,8 @@
     can be pinged, can serve a website and more without requiring any
     elevated permission. This can make testing OpenVPN much easier.
 
-    For more details see [lwipovpn on Gihtub](https://github.com/OpenVPN/lwipovpn).
+    For more details see
+    `lwipovpn on Github <https://github.com/OpenVPN/lwipovpn>`_.
 
 Allow overriding username with ``--override-username``
     This is intended to allow using auth-gen-token in scenarios where the
@@ -314,17 +315,17 @@
   use from "ifconfig", this change repairs functionality (this has
   been backported to 2.6.15, but is not in earlier 2.6 versions).
 
-- `max-routes-per-client 0` used to be silently upgraded to `1`.  This
+- ``max-routes-per-client 0`` used to be silently upgraded to ``1``.  This
   now produces an error.
 
-- `ifconfig` and `ifconfig-ipv6` values are now stored in pre-connect
+- ``ifconfig`` and ``ifconfig-ipv6`` values are now stored in pre-connect
   options cache, and will be restored to pre-connect values on reconnects
   if the server stops pushing the respective option.
 
-- `tapctl.exe` helper binary on Windows has been reworked to improve
+- ``tapctl.exe`` helper binary on Windows has been reworked to improve
   help texts (making clear that it can not only do TAP-Adapters but
   Win-DCO as well), add printing of the hwid to all adapter outputs, and
-  change the default adapter type created to `ovpn-dco`.
+  change the default adapter type created to ``ovpn-dco``.
 
 Deprecated features
 -------------------
@@ -803,7 +804,7 @@
     wait for the second factor authentication to complete.
 
     This feature currently requires usage of the managent interface
-    on both client and server side. See the `management-notes.txt`
+    on both client and server side. See the ``management-notes.txt``
     ``client-pending-auth`` and ``cr-response`` commands for more
     details.
 
@@ -822,7 +823,7 @@
 Allow unicode search string in ``--cryptoapicert`` option (Windows)
 
 Support IPv4 configs with /31 netmasks now
-    (By no longer trying to configure ``broadcast x.x.x.x'' in
+    (By no longer trying to configure ``broadcast x.x.x.x`` in
     ifconfig calls, /31 support "just works")
 
 New option ``--block-ipv6`` to reject all IPv6 packets (ICMPv6)

