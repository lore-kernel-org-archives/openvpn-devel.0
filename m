From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 22 Jan 2026 13:57:07 +0100
Message-ID: <20260122125707.108048-1-frank@...2641...>
In-Reply-To: <gerrit.1769005798000.I575d65912ce9065a0b0868e73998b4a9aece62af@...2715...>
References: <gerrit.1769005798000.I575d65912ce9065a0b0868e73998b4a9aece62af@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] manage: Do not trigger actions on
 management disconnect if not authenticated
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
Cc: Joshua Rogers <contact@...2949...>, Arne Schwabe <arne-openvpn@...1227...>

If the management interface requires authentication via password
and the remote did not specify it, do not do trigger actions
requested by --management-forget-disconnect and --management-signal
on disconnect.

Reported-By: Joshua Rogers <contact@...2949...>
Found-By: ZeroPath (https://zeropath.com)
Github: openvpn-private-issues#5
Change-Id: I575d65912ce9065a0b0868e73998b4a9aece62af
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1484
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1484
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 8fa8784..37ae6b3 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2073,13 +2073,14 @@
     }
     if (!exiting)
     {
-        if (man->settings.flags & MF_FORGET_DISCONNECT)
+        if (man->settings.flags & MF_FORGET_DISCONNECT && !man_password_needed(man))
         {
+            msg(D_MANAGEMENT, "MANAGEMENT: Reset authentication on disconnect");
             ssl_purge_auth(false);
             (void)ssl_clean_auth_token();
         }
 
-        if (man->settings.flags & MF_SIGNAL)
+        if (man->settings.flags & MF_SIGNAL && !man_password_needed(man))
         {
             int mysig = man_mod_signal(man, SIGUSR1);
             if (mysig >= 0)

