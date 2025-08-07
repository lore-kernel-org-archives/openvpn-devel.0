From: Gert Doering <gert@...1296...>
Date: Thu,  7 Aug 2025 22:37:35 +0200
Message-ID: <20250807203741.31359-1-gert@...1296...>
In-Reply-To: <gerrit.1754579268000.Ice8c7ff4d8118a9e6465a4724207a355138360b8@...2715...>
References: <gerrit.1754579268000.Ice8c7ff4d8118a9e6465a4724207a355138360b8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] t_client.sh: Do not wait 3 seconds for
 OpenVPN to come up
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

From: Frank Lichtenheld <frank@...2641...>

On most machines 1 second should be quite enough. Given
that we run currently 23 tests on most t_client runs, this
makes over 40 seconds difference. Not nothing.

We keep the existing 30s maximum wait-time since sometimes
we want to do tests with intentionally slow servers.

Change-Id: Ice8c7ff4d8118a9e6465a4724207a355138360b8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1139
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 7a271b6..a49de40 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -377,13 +377,13 @@
     $RUN_SUDO "${openvpn}" $openvpn_conf >>$LOGDIR/$SUF:openvpn.log &
     sudopid=$!
 
-    # Check if OpenVPN has initialized before continuing.  It will check every 3rd second up
+    # Check if OpenVPN has initialized before continuing.  It will check every second up
     # to $ovpn_init_check times.
-    ovpn_init_check=10
+    ovpn_init_check=30
     ovpn_init_success=0
     while [ $ovpn_init_check -gt 0 ];
     do
-       sleep 3  # Wait for OpenVPN to initialize and have had time to write the pid file
+       sleep 1  # Wait for OpenVPN to initialize and have had time to write the pid file
        grep "Initialization Sequence Completed" $LOGDIR/$SUF:openvpn.log >/dev/null
        if [ $? -eq 0 ]; then
            ovpn_init_check=0

