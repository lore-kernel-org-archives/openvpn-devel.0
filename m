MIME-Version: 1.0
Date: Sat, 7 Dec 2013 21:01:35 +0600
Message-ID: <CAFHpkQEdec39CQFOr7M3=+1yDi4myTtoHBdankg9NRnF-ZhzoQ@...278...>
From: =?KOI8-R?B?6czY0SD7ydDJw8nO?= <chipitsine@...277...>
Subject: [Openvpn-devel] uninitialized handle fix (serious bug on Win 8.1),
	another attempt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

if handle is not initialized, orig_stderr variable could take random
value, which we observe on Windows 8.1 (bug reported here as well:
https://forums.openvpn.net/topic13246.html )

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index ebe9a52..b34d209 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -459,7 +459,7 @@ static HANDLE orig_stderr;
 HANDLE
 get_orig_stderr (void)
 {
-  if (orig_stderr)
+  if (std_redir)
     return orig_stderr;
   else
     return GetStdHandle (STD_ERROR_HANDLE);

