From: Adrien Bustany <adrien@...1716...>
Date: Tue,  8 May 2012 10:30:03 +0300
Message-Id: <1336462203-20226-2-git-send-email-adrien@...1716...>
In-Reply-To: <1336462203-20226-1-git-send-email-adrien@...1716...>
References: <1336462203-20226-1-git-send-email-adrien@...1716...>
Subject: [Openvpn-devel] [PATCH] management: Don't require DAF_INITIAL_AUTH
	to send ADDRESS/DISCONNECT messages
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
Cc: Adrien Bustany <adrien.bustany@...1719...>

From: Adrien Bustany <adrien.bustany@...1719...>

DAF_INITIAL_AUTH will only be set if a password was needed for client
authentication. This means that for password-less certificate
authentication, no DISCONNECT/ADDRESS messages would be sent.
---
 src/openvpn/manage.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 1dddd41..4148f7c 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2474,7 +2474,7 @@ management_notify_client_close (struct management *management,
 				struct man_def_auth_context *mdac,
 				const struct env_set *es)
 {
-  if ((mdac->flags & DAF_INITIAL_AUTH) && !(mdac->flags & DAF_CONNECTION_CLOSED))
+  if (!(mdac->flags & DAF_CONNECTION_CLOSED))
     {
       msg (M_CLIENT, ">CLIENT:DISCONNECT,%lu", mdac->cid);
       man_output_env (es, true, management->connection.env_filter_level, "CLIENT");
@@ -2489,7 +2489,7 @@ management_learn_addr (struct management *management,
 		       const bool primary)
 {
   struct gc_arena gc = gc_new ();
-  if ((mdac->flags & DAF_INITIAL_AUTH) && !(mdac->flags & DAF_CONNECTION_CLOSED))
+  if (!(mdac->flags & DAF_CONNECTION_CLOSED))
     {
       msg (M_CLIENT, ">CLIENT:ADDRESS,%lu,%s,%d",
 	   mdac->cid,
-- 
1.7.8.1


