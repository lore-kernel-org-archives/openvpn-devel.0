From: Christian Hesse <list@...1798...>
Date: Wed, 28 Dec 2016 08:54:20 +0100
Message-Id: <20161228075420.348-1-list@...1798...>
Subject: [Openvpn-devel] [PATCH 1/1] man: fix formatting for alternative
	option
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
To: OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>

From: Christian Hesse <mail@...1798...>

This looked like...

    --server-poll-timeout n
        --connect-timeout n when connecting to [...]

... and this patch changes this to...

    --server-poll-timeout n, --connect-timeout n
        When connecting to [...]

... preserving correct highlighting.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 doc/openvpn.8 | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 7bd6d9d..68fed4e 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3969,9 +3969,8 @@ See management\-notes.txt in the OpenVPN distribution for a
 description of the OpenVPN challenge/response protocol.
 .\"*********************************************************
 .TP
-.B \-\-server\-poll\-timeout n
-.B \-\-connect\-timeout n
-when connecting to a remote server do not wait for more than
+\fB\-\-server\-poll\-timeout n\fR, \fB\-\-connect\-timeout n\fR
+When connecting to a remote server do not wait for more than
 .B n
 seconds waiting for a response before trying the next server.
 The default value is 120s. This timeout includes proxy and TCP
-- 
2.11.0


