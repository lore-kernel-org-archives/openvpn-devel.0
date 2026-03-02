From: Gert Doering <gert@...1296...>
Date: Mon,  2 Mar 2026 17:35:51 +0100
Message-ID: <20260302163557.18358-1-gert@...1296...>
In-Reply-To: <gerrit.1771250081000.I6bdded6c70596b69428e6a00a405ac3cedc405fa@...2715...>
References: <gerrit.1771250081000.I6bdded6c70596b69428e6a00a405ac3cedc405fa@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] management: stop bytecount on client
 disconnection
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

From: Ralf Lici <ralf@...2726...>

When a management interface client requests periodic bytecount
notifications, openvpn continues to emit them even after the client has
disconnected. Additionally, upon reconnecting, the client starts
receiving these notifications without having issued a new bytecount
command.

Stop the periodic bytecount operation when the management interface
client disconnects, preventing unnecessary stats polling when using DCO
and ensuring that clients only receive notifications they have
explicitly requested.

Change-Id: I6bdded6c70596b69428e6a00a405ac3cedc405fa
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1533
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1533
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 4ed0393..48b87e9 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -472,6 +472,13 @@
 }
 
 static void
+man_bytecount_stop(struct management *man)
+{
+    man->connection.bytecount_update_seconds = 0;
+    event_timeout_clear(&man->connection.bytecount_update_interval);
+}
+
+static void
 man_bytecount(struct management *man, const int update_seconds)
 {
     if (update_seconds > 0)
@@ -483,8 +490,7 @@
     }
     else
     {
-        man->connection.bytecount_update_seconds = 0;
-        event_timeout_clear(&man->connection.bytecount_update_interval);
+        man_bytecount_stop(man);
     }
 
     /* The newly received bytecount interval may be sooner than the existing
@@ -2011,6 +2017,7 @@
 {
     if (socket_defined(man->connection.sd_cli))
     {
+        man_bytecount_stop(man);
 #ifdef _WIN32
         man_stop_ne32(man);
 #endif

