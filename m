From: Gert Doering <gert@...1296...>
Date: Mon,  2 Mar 2026 15:18:02 +0100
Message-ID: <20260302141811.5697-1-gert@...1296...>
In-Reply-To: <gerrit.1772061272000.I1c01fa1bc7d65ac060b334724feb56ef4d0b5d35@...2715...>
References: <gerrit.1772061272000.I1c01fa1bc7d65ac060b334724feb56ef4d0b5d35@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Document management client versions
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

From: Selva Nair <selva.nair@...277...>

Also add an enum to keep track of client version updates.

Change-Id: I1c01fa1bc7d65ac060b334724feb56ef4d0b5d35
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1552
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1552
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 86b74f3..41e2a91 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -496,6 +496,10 @@
 version. This was fixed starting version 4: clients should expect
 "SUCCESS: .. " message only when setting the version to >= 4.
 
+Minimum client version required for certain features is listed below:
+    >PK_SIGN:[base64]           -- version 2 or greater
+    >PK_SIGN:[base64],[alg]     -- version 3 or greater
+
 COMMAND -- auth-retry
 ---------------------
 
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 03ff5b3..d26c9b2 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -61,6 +61,17 @@
 /* tag for blank username/password */
 static const char blank_up[] = "[[BLANK]]";
 
+/*
+ * Management client versions indicating feature support in client.
+ * Append new values as needed but do not change exisiting ones.
+ */
+enum mcv
+{
+    MCV_DEFAULT = 1,
+    MCV_PKSIGN = 2,
+    MCV_PKSIGN_ALG = 3,
+};
+
 struct management *management; /* GLOBAL */
 
 /* static forward declarations */
@@ -1333,8 +1344,8 @@
     if (version)
     {
         man->connection.client_version = atoi(version);
-        /* Prior to version 3, we missed to respond to this command. Acknowledge only if version >= 4 */
-        if (man->connection.client_version >= 4)
+        /* Until MCV_PKSIGN_ALG, we missed to respond to this command. Acknowledge only if version is newer */
+        if (man->connection.client_version > MCV_PKSIGN_ALG)
         {
             msg(M_CLIENT, "SUCCESS: Management client version set to %d", man->connection.client_version);
         }
@@ -2656,7 +2667,7 @@
             man->connection.es = event_set_init(&maxevents, EVENT_METHOD_FAST);
         }
 
-        man->connection.client_version = 1; /* default version */
+        man->connection.client_version = MCV_DEFAULT; /* default version */
 
         /*
          * Listen/connect socket
@@ -3776,14 +3787,14 @@
     const char *desc = "pk-sign";
     struct buffer buf_data = alloc_buf(strlen(b64_data) + strlen(algorithm) + 20);
 
-    if (man->connection.client_version <= 1)
+    if (man->connection.client_version <= MCV_DEFAULT)
     {
         prompt = "RSA_SIGN";
         desc = "rsa-sign";
     }
 
     buf_write(&buf_data, b64_data, (int)strlen(b64_data));
-    if (man->connection.client_version > 2)
+    if (man->connection.client_version >= MCV_PKSIGN_ALG)
     {
         buf_write(&buf_data, ",", (int)strlen(","));
         buf_write(&buf_data, algorithm, (int)strlen(algorithm));

