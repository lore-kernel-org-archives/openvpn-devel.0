From: Gert Doering <gert@...1296...>
Date: Thu, 30 Oct 2025 20:47:31 +0100
Message-ID: <20251030194736.2151-1-gert@...1296...>
In-Reply-To: <gerrit.1761496209000.I92804da010bab36cd0326759c04f955f2bda74de@...2715...>
References: <gerrit.1761496209000.I92804da010bab36cd0326759c04f955f2bda74de@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] iservice: check return value of
 MultiByteToWideChar
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

If the first call to MultiByteToWideChar returns 0, something must have
failed, because it returns the required buffer size including the
terminating zero. When it does return 0, just return NULL and indicate
that the call to utf8to16(_size) failed.

Found by ZeroPath.

Reported-By: Joshua Rogers <contact@...2949...>
Change-Id: I92804da010bab36cd0326759c04f955f2bda74de
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1306
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1306
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index e975cc7..d25d9c0 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -276,6 +276,10 @@
 utf8to16_size(const char *utf8, int size)
 {
     int n = MultiByteToWideChar(CP_UTF8, 0, utf8, size, NULL, 0);
+    if (n == 0)
+    {
+        return NULL;
+    }
     wchar_t *utf16 = malloc(n * sizeof(wchar_t));
     if (!utf16)
     {

