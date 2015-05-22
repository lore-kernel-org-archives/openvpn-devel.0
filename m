From: Gert Doering <gert@...1296...>
Date: Fri, 22 May 2015 20:36:09 +0200
Message-Id: <1432319769-26663-1-git-send-email-gert@...1296...>
In-Reply-To: <555BF270.3090706@...1147...>
References: <555BF270.3090706@...1147...>
Subject: [Openvpn-devel] [PATCH] Document differences between --up-restart
	and --up in openvpn.8
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

See trac #93 and the discussion starting with <555BF270.3090706@...1147...>
on the openvpn-devel mailing list.

Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/openvpn.8 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index b9eee0d..ef87bb7 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1817,6 +1817,12 @@ has been specified, the up script will be called with
 .I restart
 as the last parameter.
 
+NOTE: on restart, OpenVPN will not pass the full set of environment
+variables to the script.  Namely, everything related to routing and
+gateways will not be passed, as nothing needs to be done anyway - all
+the routing setup is already in place.  Additionally, the up\-restart
+script will run with the downgraded UID/GID settings (if configured).
+
 The following standalone example shows how the
 .B \-\-up
 script can be called in both an initialization and restart context.
-- 
2.0.5


