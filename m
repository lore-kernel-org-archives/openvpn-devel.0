From: Gert Doering <gert@...1296...>
Date: Mon,  9 Mar 2026 14:05:40 +0100
Message-ID: <20260309130546.7735-1-gert@...1296...>
In-Reply-To: <gerrit.1772820505000.I89f0aa9a23915c7783ae03793080ee989a437208@...2715...>
References: <gerrit.1772820505000.I89f0aa9a23915c7783ae03793080ee989a437208@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] doc: fix client-nat syntax and examples
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

From: Ralf Lici <ralf@...2726...>

The client-nat documentation uses an incorrect command form and
incomplete examples.

Document the actual syntax accepted by openvpn:
  client-nat snat|dnat network netmask alias

Update examples to include all required arguments and rewrite the
explanatory text to describe 'network', 'netmask', and 'alias'
separately.

Documentation-only change; no behavior change.

Change-Id: I89f0aa9a23915c7783ae03793080ee989a437208
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1560
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1560
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index b9ae7ce..85d25e5 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -132,16 +132,21 @@
   ifconfig settings pushed to the client would create an IP numbering
   conflict.
 
+  Valid syntax:
+  ::
+
+      client-nat snat|dnat network netmask alias
+
   Examples:
   ::
 
-      client-nat snat 192.168.0.0/255.255.0.0
-      client-nat dnat 10.64.0.0/255.255.0.0
+      client-nat snat 192.168.0.0 255.255.0.0 10.64.0.0
+      client-nat dnat 10.64.0.0 255.255.0.0 192.168.0.0
 
-  ``network/netmask`` (for example :code:`192.168.0.0/255.255.0.0`) defines
-  the local view of a resource from the client perspective, while
-  ``alias/netmask`` (for example :code:`10.64.0.0/255.255.0.0`) defines the
-  remote view from the server perspective.
+  ``network`` and ``netmask`` (for example :code:`192.168.0.0
+  255.255.0.0`) define the local view of a resource from the client
+  perspective, while ``alias`` (for example :code:`10.64.0.0`) defines the
+  remote view from the server perspective using the same netmask.
 
   Use :code:`snat` (source NAT) for resources owned by the client and
   :code:`dnat` (destination NAT) for remote resources.

