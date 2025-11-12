From: Gert Doering <gert@...1296...>
Date: Wed, 12 Nov 2025 10:39:05 +0100
Message-ID: <20251112093911.24196-1-gert@...1296...>
In-Reply-To: <gerrit.1762539795000.I4d905da3add9b8a3daf349eb1bc830a017cf493d@...2715...>
References: <gerrit.1762539795000.I4d905da3add9b8a3daf349eb1bc830a017cf493d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] iservice: validate config path
 case-insensitive
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

Windows filesystems do not differentiate by case, so we shouldn't either.

Reported-by: stephan@...2953...
Change-Id: I4d905da3add9b8a3daf349eb1bc830a017cf493d
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1362
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1362
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index b3189b7..3381503 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -78,7 +78,7 @@
         res = PathCchCanonicalize(config_path, _countof(config_path), fname);
     }
 
-    return res == S_OK && wcsncmp(config_path, s->config_dir, wcslen(s->config_dir)) == 0;
+    return res == S_OK && wcsnicmp(config_path, s->config_dir, wcslen(s->config_dir)) == 0;
 }
 
 

