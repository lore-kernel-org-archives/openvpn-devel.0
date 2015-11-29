From: Arne Schwabe <arne@...1227...>
Date: Sun, 29 Nov 2015 20:38:21 +0100
Message-Id: <1448825901-12294-1-git-send-email-arne@...1227...>
In-Reply-To: <CAEsd45QjsjNDWFkoHG2O0ycO2pNGxj115TH+SLiUD__jf=WWpQ@...278...>
References: <CAEsd45QjsjNDWFkoHG2O0ycO2pNGxj115TH+SLiUD__jf=WWpQ@...278...>
Subject: [Openvpn-devel] [PATCH] Also remove second Instanz von
	enable-password-save in the manage
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

---
 doc/openvpn.8 | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 3519e7d..1b9dcae 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4886,10 +4886,7 @@ is specified, read the password from the first line of
 .B file.
 Keep in mind that storing your password in a file
 to a certain extent invalidates the extra security provided by
-using an encrypted key (Note: OpenVPN
-will only read passwords from a file if it has been built
-with the \-\-enable\-password\-save configure option, or on Windows
-by defining ENABLE_PASSWORD_SAVE in win/settings.in).
+using an encrypted key.
 .\"*********************************************************
 .TP
 .B \-\-auth\-nocache
-- 
2.4.9 (Apple Git-60)


