MIME-Version: 1.0
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Sat, 23 May 2015 15:33:21 -0400
Message-ID: <CAEsd45SHoEtahdVT95a+N-zmjRG4nH3QPxBZoGpnh1pykjSU4A@...278...>
Subject: [Openvpn-devel] [Patch] Fix null pointer dereference in options.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: James Yonan <james@...515...>

(At Gert's request, I am posting this to openvpn-devel.)

This patch fixes a null pointer dereference in options.c.

Below are versions for openvpn-master and openvpn-2.3; they differ
only in the line number reference.

================
2.3 branch

diff -U 4 -r openvpn-release-2.3/src/openvpn/options.c
openvpn-fix-peer-id-2.3/src/openvpn/options.c
--- openvpn-release-2.3/src/openvpn/options.c 2015-05-18
12:30:14.000000000 -0400
+++ openvpn-fix-peer-id-2.3/src/openvpn/options.c 2015-05-21
06:52:38.000000000 -0400
@@ -7058,9 +7058,9 @@
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->persist_config = true;
       options->persist_mode = 1;
     }
-  else if (streq (p[0], "peer-id"))
+  else if (streq (p[0], "peer-id") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_PEER_ID);
       options->use_peer_id = true;
       options->peer_id = atoi(p[1]);


================
Master branch

diff -U4 -r openvpn-master/src/openvpn/options.c
openvpn-fix-peer-id-master/src/openvpn/options.c
--- openvpn-master/src/openvpn/options.c 2015-05-18 12:25:46.000000000 -0400
+++ openvpn-fix-peer-id-master/src/openvpn/options.c 2015-05-20
23:38:41.000000000 -0400
@@ -7043,9 +7043,9 @@
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->persist_config = true;
       options->persist_mode = 1;
     }
-  else if (streq (p[0], "peer-id"))
+  else if (streq (p[0], "peer-id") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_PEER_ID);
       options->use_peer_id = true;
       options->peer_id = atoi(p[1]);

