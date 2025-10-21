From: Gert Doering <gert@...1296...>
Date: Tue, 21 Oct 2025 21:31:40 +0200
Message-ID: <20251021193147.26778-1-gert@...1296...>
In-Reply-To: <gerrit.1761063467000.I76babf08b041162ddedf7a9b7c2799847f15cbdc@...2715...>
References: <gerrit.1761063467000.I76babf08b041162ddedf7a9b7c2799847f15cbdc@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] multi: Fix wrong usage of
 mroute_extract_openvpn_sockaddr
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

maddr.proto needs to be set before the call since that
will change the behavior.

Found by GCC "'maddr.proto' is used uninitialized"

Change-Id: I76babf08b041162ddedf7a9b7c2799847f15cbdc
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Acked-by: Gianmarco De Gregori <gianmarco@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1292
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1292
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>
Gianmarco De Gregori <gianmarco@...2726...>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e907524..fa9c654 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3965,9 +3965,9 @@
     saddr.addr.in4.sin_family = AF_INET;
     saddr.addr.in4.sin_addr.s_addr = htonl(addr);
     saddr.addr.in4.sin_port = htons(port);
+    maddr.proto = proto;
     if (mroute_extract_openvpn_sockaddr(&maddr, &saddr, true))
     {
-        maddr.proto = proto;
         hash_iterator_init(m->iter, &hi);
         while ((he = hash_iterator_next(&hi)))
         {

