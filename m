From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  1 Dec 2023 12:19:37 +0100
Message-Id: <20231201111937.15214-1-frank@...2641...>
In-Reply-To: <gerrit.1700479034000.I93afff2372c4150d6bddc8c07fd4ebc8bfb0cc3e@...2715...>
References: <gerrit.1700479034000.I93afff2372c4150d6bddc8c07fd4ebc8bfb0cc3e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Document tls-exit option mainly as test
 option
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

From: Arne Schwabe <arne@...1227...>

Change-Id: I93afff2372c4150d6bddc8c07fd4ebc8bfb0cc3e
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/447
This mail reflects revision 3 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index 908a42a..ad8ca72 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -553,7 +553,9 @@
   code.
 
 --tls-exit
-  Exit on TLS negotiation failure.
+  Exit on TLS negotiation failure. This option can be useful when you only
+  want to make one attempt at connecting, e.g. in a test or monitoring script.
+  (OpenVPN's own test suite uses it this way.)
 
 --tls-export-cert directory
   Store the certificates the clients use upon connection to this

