From: Arne Schwabe <arne@...1227...>
Date: Sat,  2 Jun 2012 15:03:37 +0200
Message-Id: <1338642223-20324-3-git-send-email-arne@...1227...>
In-Reply-To: <1338642223-20324-1-git-send-email-arne@...1227...>
References: <1338642223-20324-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 2/8] Add the query to the error message.
	Makes the diagnose what went wrong from logs easier.
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
To: openvpn-devel@lists.sourceforge.net


Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/console.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index 2464e7e..afda8ca 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -232,7 +232,7 @@ get_console_input (const char *prompt, const bool echo, char *input, const int c
 	}
     }
 #else
-  msg (M_FATAL, "Sorry, but I can't get console input on this OS");
+  msg (M_FATAL, "Sorry, but I can't get console input on this OS (%s)", prompt);
 #endif
   return ret;
 }
-- 
1.7.7.5 (Apple Git-26)


