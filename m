From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:11:36 +0200
Message-Id: <1330546342-17794-7-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 06/52] cleanup: remove redundant ';'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 misc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/misc.h b/misc.h
index bdada42..dd6bd5a 100644
--- a/misc.h
+++ b/misc.h
@@ -145,7 +145,7 @@ openvpn_run_script (const struct argv *a, const struct env_set *es, const unsign
 
   openvpn_snprintf(msg, sizeof(msg), "WARNING: Failed running command (%s)", hook);
   return openvpn_execve_check(a, es, flags | S_SCRIPT, msg);
-};
+}
 
 #ifdef WIN32
 FILE * openvpn_fopen (const char *path, const char *mode);
-- 
1.7.3.4


