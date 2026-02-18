From: Gert Doering <gert@...1296...>
Date: Wed, 18 Feb 2026 22:44:31 +0100
Message-ID: <20260218214437.26912-1-gert@...1296...>
In-Reply-To: <gerrit.1771415352000.I2703f15144661f9cadfc8750884db270f3a5bfc6@...2715...>
References: <gerrit.1771415352000.I2703f15144661f9cadfc8750884db270f3a5bfc6@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] ntlm: fix discards 'const' qualifier
 from pointer target type
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

From: Rudi Heitbaum <rudi@...2993...>

Since glibc-2.43:

For ISO C23, the functions bsearch, memchr, strchr, strpbrk, strrchr,
strstr, wcschr, wcspbrk, wcsrchr, wcsstr and wmemchr that return pointers
into their input arrays now have definitions as macros that return a
pointer to a const-qualified type when the input argument is a pointer
to a const-qualified type.

fixes:
    src/openvpn/ntlm.c: In function 'ntlm_phase_3':
    src/openvpn/ntlm.c:241:15: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      241 |     separator = strchr(p->up.username, '\\');
          |               ^

Change-Id: I2703f15144661f9cadfc8750884db270f3a5bfc6
Signed-off-by: Rudi Heitbaum <rudi@...2993...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1546
(cherry picked from commit 720c2e97f609bf7bb7e628ddfa7d3e3783afa676)
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1546
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 9191a8b..6da4359 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -230,7 +230,7 @@
 
     char domain[128];
     char username[128];
-    char *separator;
+    const char *separator;
 
     bool ntlmv2_enabled = (p->auth_method == HTTP_AUTH_NTLM2);
 

