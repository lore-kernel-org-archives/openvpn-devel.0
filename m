From: Maximilian Wilhelm <max@...1047...>
Date: Mon,  3 Sep 2007 01:14:02 +0200
Message-Id: <11887748432668-git-send-email-max@...1047...>
In-Reply-To: <11887748431930-git-send-email-max@...1047...>
References: <11887748431930-git-send-email-max@...1047...>
Subject: [Openvpn-devel] [PATCH] Let set_utmp_line() use the configured
	'server_id' as prefix in utmp line string
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

  Now every utmp line will look like "ovpn%d-%s" where %d are the two last
  digits of the server_id and %s some chars of the session_id (as many as
  fit into the remaining space in 'ut_line'.

  This provides the ability to let at most 100 OpenVPN instances on one single
  maschine write to the same wtmp file and you are still able to distinguish
  which instance created which entry.

Signed-off-by: Maximilian Wilhelm <max@...1047...>
---
 wtmp.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/wtmp.c b/wtmp.c
index 3887220..50dd5f9 100644
--- a/wtmp.c
+++ b/wtmp.c
@@ -216,29 +216,25 @@ fprintf (stderr, "%s: entry.ut_id = %s\n", __FUNCTION__, entry.ut_id);
 
 
 
-
-
 /* Build up and store an utmp line */
 void
 set_utmp_line (const struct multi_instance *mi, struct utmp *entry)
 {
 	struct gc_arena gc = gc_new ();
-	char *temp;
 
-	char line[UT_LINESIZE];
-
-	/* Should be config option */
-	unsigned int server_num = 1;
+	char *temp;
+	unsigned int server_id
 
 	assert (mi);
 	assert (entry);
 
+	server_id = mi->context.options.wtmp_server_id % 100;
 	temp = format_hex_ex (mi->context.c2.tls_multi->session[TM_ACTIVE].session_id.id, SID_SIZE, 0, 4, "", &gc);
 
 	if (temp) {
-		snprintf (entry->ut_line, UT_LINESIZE, "ovpn%02d-%s", server_num, temp);
+		snprintf (entry->ut_line, UT_LINESIZE, "ovpn%02d-%s", server_id, temp);
 	} else {
-		snprintf (entry->ut_line, UT_LINESIZE, "ovpn%02d", server_num);
+		snprintf (entry->ut_line, UT_LINESIZE, "ovpn%02d", server_id);
 	}
 }
 
-- 
1.5.2.4


