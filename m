From: Gert Doering <gert@...1296...>
Date: Tue,  9 Dec 2025 08:02:11 +0100
Message-ID: <20251209070218.4467-1-gert@...1296...>
In-Reply-To: <gerrit.1764812658000.I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a@...2715...>
References: <gerrit.1764812658000.I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] pull-filter: improve documentation
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

From: Selva Nair <selva.nair@...277...>

Pull-filter uses a simple string comparison and could be defeated by
unusual formatting of pushed option strings. Document that this
option is not meant to be used as a security measure.

Reported by: <aarnav@...2953...>

Change-Id: I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1415
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1415
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index e8523d9..4841756 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -345,6 +345,11 @@
   next remote succeeds. To silently ignore an option pushed by the server,
   use :code:`ignore`.
 
+  *Warning:* ``pull-filter`` cannot be relied upon as a security measure to
+  protect against offending options pushed by a server. For example, the
+  filter could be defeated by pushing options with extra spaces between
+  tokens or other formatting variations.
+
 --push-peer-info
   Push additional information about the client to server. The following
   data is always pushed to the server:

