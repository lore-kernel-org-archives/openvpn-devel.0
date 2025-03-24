From: Gert Doering <gert@...1296...>
Date: Mon, 24 Mar 2025 14:37:53 +0100
Message-ID: <20250324133759.13155-1-gert@...1296...>
In-Reply-To: <gerrit.1742822307000.Ib579c1538eb5440bb7008bc866a5cb7d74844374@...2715...>
References: <gerrit.1742822307000.Ib579c1538eb5440bb7008bc866a5cb7d74844374@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Directly use _countof in array
 initialisation
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

This fixes the build failures on MSVC cl compiler.

MSVC cl does not thinks of the expression of a const variable times
an integer to be compile time static. C23 introduce the constexpr
(like in C++) statement for that but we are only on C11 for now.

So directly use the _countof(msg->addr) expression in the array
initialisation.

Change-Id: Ib579c1538eb5440bb7008bc866a5cb7d74844374
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/915
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index e64ac30..c6963b3 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1901,7 +1901,9 @@
     if (msg->addr_len > 0)
     {
         /* prepare the comma separated address list */
-        CHAR addrs[max_addrs * 64]; /* 64 is enough for one IPv4/6 address */
+        /* cannot use max_addrs here as that is not considered compile
+         * time constant by all compilers and constexpr is C23 */
+        CHAR addrs[_countof(msg->addr) * 64]; /* 64 is enough for one IPv4/6 address */
         size_t offset = 0;
         for (int i = 0; i < addr_len; ++i)
         {

