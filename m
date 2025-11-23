From: Gert Doering <gert@...1296...>
Date: Sun, 23 Nov 2025 12:58:46 +0100
Message-ID: <20251123115851.19555-1-gert@...1296...>
In-Reply-To: <gerrit.1763880426000.Icaeca22bdbd8ead0cb12345b1bcc2b5c0f46236f@...2715...>
References: <gerrit.1763880426000.Icaeca22bdbd8ead0cb12345b1bcc2b5c0f46236f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] iservice: make sure registry string is
 terminated
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

From: Heiko Hund <heiko@...2662...>

When reading the interface domains from the registry, check that the
string is zero terminated, since the code in GetItfDnsDomains depends
on the fact when doing size calculations during the conversion.

Reported-by: Marc Heuse <marc@...2953...>
Reported-by: stephan@...2953...
Change-Id: Icaeca22bdbd8ead0cb12345b1bcc2b5c0f46236f
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1392
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1392
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index f31a8a9..ec80a30 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2163,7 +2163,7 @@
     {
         *size = buf_size;
         err = RegGetValueW(itf, NULL, values[i], RRF_RT_REG_SZ, NULL, (PBYTE)domains, size);
-        if (!err && *size > one_glyph && wcschr(domains, '.'))
+        if (!err && *size > one_glyph && domains[(*size / one_glyph) - 1] == '\0' && wcschr(domains, '.'))
         {
             /*
              * Found domain(s), now convert them:

