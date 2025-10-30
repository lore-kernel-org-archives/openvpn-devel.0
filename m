From: Gert Doering <gert@...1296...>
Date: Thu, 30 Oct 2025 16:04:26 +0100
Message-ID: <20251030150432.4689-1-gert@...1296...>
In-Reply-To: <gerrit.1761813264000.I75ebf01641db4dcd07041e3b8b3fa8a632d07595@...2715...>
References: <gerrit.1761813264000.I75ebf01641db4dcd07041e3b8b3fa8a632d07595@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] interactive.c: add the upper bound for
 startupdata size
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

From: Lev Stipakov <lev@...515...>

The size is passed from the limited-privileges process.
This check ensures that the service won't allocate
more than needed.

Reported-by: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)

Change-Id: I75ebf01641db4dcd07041e3b8b3fa8a632d07595
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1331
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1331
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ce0d4dd..cb31267 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -446,9 +446,9 @@
     }
 
     size = bytes / sizeof(*data);
-    if (size == 0)
+    if ((size == 0) || (size > 4096)) /* our startup data is 1024 wchars at the moment */
     {
-        MsgToEventLog(M_SYSERR, L"malformed startup data: 1 byte received");
+        MsgToEventLog(M_SYSERR, L"malformed startup data: %lu bytes received", size);
         ReturnError(pipe, ERROR_STARTUP_DATA, L"GetStartupData", 1, &exit_event);
         goto err;
     }

