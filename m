From: Gert Doering <gert@...1296...>
Date: Fri,  5 Jan 2024 15:24:32 +0100
Message-ID: <20240105142432.26298-1-gert@...1296...>
In-Reply-To: <gerrit.1704298871000.Ida4d22455c51773b6713caf94a4b4fbe136a6ded@...2715...>
References: <gerrit.1704298871000.Ida4d22455c51773b6713caf94a4b4fbe136a6ded@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Clarify that the tls-crypt-v2-verify has
 a very limited env set
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

Change-Id: Ida4d22455c51773b6713caf94a4b4fbe136a6ded
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/488
This mail reflects revision 2 of this Change.
Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index 4c45b10..460cecf 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -538,7 +538,9 @@
   stack (including the notoriously dangerous X.509 and ASN.1 stacks) to
   the connecting client.
 
-  OpenVPN supplies the following environment variables to the command:
+  OpenVPN supplies the following environment variables to the command (and
+  only these variables. The normal environment variables available for
+  other scripts are NOT present):
 
   * :code:`script_type` is set to :code:`tls-crypt-v2-verify`
 

