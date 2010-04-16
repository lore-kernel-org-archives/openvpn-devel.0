From: David Sommerseth <openvpn.list@...1114...>
Date: Fri, 16 Apr 2010 22:21:53 +0200
Message-Id: <1271449313-26315-4-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1271449313-26315-1-git-send-email-openvpn.list@...1114...>
References: <1271449313-26315-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCHv2 3/3] Updated the man page to reflect the
	behavioural change of create_temp_file()
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
To: Openvpn-devel@lists.sourceforge.net
Cc: James Yonan <james@...515...>, David Sommerseth <dazo@...384...>

From: David Sommerseth <dazo@...384...>

As this function now creates the temp file, it is no longer
'not-yet-created', but 'freshly created'.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 openvpn.8 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/openvpn.8 b/openvpn.8
index 82e7d24..301cd37 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -2814,7 +2814,7 @@ on client connection.  The script is passed the common name
 and IP address of the just-authenticated client
 as environmental variables (see environmental variable section
 below).  The script is also passed
-the pathname of a not-yet-created temporary file as $1
+the pathname of a freshly created temporary file as $1
 (i.e. the first command line argument), to be used by the script
 to pass dynamically generated config file directives back to OpenVPN.
 
-- 
1.6.6.1


