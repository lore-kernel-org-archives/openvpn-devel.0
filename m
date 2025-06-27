From: Gert Doering <gert@...1296...>
Date: Fri, 27 Jun 2025 10:24:53 +0200
Message-ID: <20250627082500.17075-1-gert@...1296...>
In-Reply-To: <gerrit.1750934262000.I46132ebaf3bf3b16798b6f2416f7bf7272f5646b@...2715...>
References: <gerrit.1750934262000.I46132ebaf3bf3b16798b6f2416f7bf7272f5646b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] dns: create NRPT registry key if it
 doesn't exist
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

Windows 2019 Server by default does not have the key where local system
NRPT rules are stored. Tests have determined that NRPT is actually
working when rules are created under the key. So, instead of failing if
the key doesn't exist, we create it, and things will start working.

Github: OpenVPN/openvpn#768
Change-Id: I46132ebaf3bf3b16798b6f2416f7bf7272f5646b
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1069
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 3bd2722..628a96b 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2662,7 +2662,7 @@
     if (err == ERROR_FILE_NOT_FOUND)
     {
         *gpol = FALSE;
-        err = RegOpenKeyExA(HKEY_LOCAL_MACHINE, sys_key, 0, KEY_ALL_ACCESS, &nrpt);
+        err = RegCreateKeyExA(HKEY_LOCAL_MACHINE, sys_key, 0, NULL, 0, KEY_ALL_ACCESS, NULL, &nrpt, NULL);
         if (err)
         {
             nrpt = INVALID_HANDLE_VALUE;

