From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 17 Jan 2014 16:30:38 +0100
Message-ID: <1389972638-8006-2-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1389972638-8006-1-git-send-email-heiko.hund@...1489...>
References: <1389972638-8006-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] convert struct signal_info element
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

This one place was forgotten when the elements type was changed
from bool to int in the dual stack patch 23d61c56.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/win32.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index f35c96b..7c89a5a 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -517,7 +517,7 @@ win32_signal_get (struct win32_signal *ws)
       if (ret)
 	{
 	  siginfo_static.signal_received = ret;
-	  siginfo_static.hard = true;
+	  siginfo_static.source = SIG_SOURCE_HARD;
 	}
     }
   return ret;
-- 
1.7.9


