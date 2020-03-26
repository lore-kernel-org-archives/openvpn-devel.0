From: Arne Schwabe <arne@...1227...>
Date: Thu, 26 Mar 2020 18:23:32 +0100
Message-Id: <20200326172332.2356-3-arne@...1227...>
In-Reply-To: <20200326172332.2356-1-arne@...1227...>
References: <20200326172332.2356-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 3/3] [auth-token] Document reneweal mechanic
 of auth-token in manual
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

Our man page was missing the information that the life time of the
auth-token also depends on the reneg-sec
---
 doc/openvpn.8 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 864f94e8..f890e7a2 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3741,6 +3741,12 @@ argument defines how long the generated token is valid.  The
 lifetime is defined in seconds.  If lifetime is not set
 or it is set to 0, the token will never expire.
 
+The token will expire either after the lifetime of the token or after
+not being renewed for 2 *
+.B reneg\-sec
+seconds. Clients are being send renewed tokens on every
+TLS renogiation to keep the client's token updated.
+
 This feature is useful for environments which is configured
 to use One Time Passwords (OTP) as part of the user/password
 authentications and that authentication mechanism does not
-- 
2.26.0


