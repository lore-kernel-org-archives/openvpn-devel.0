From: Matthias Andree <matthias.andree@...68...>
Date: Wed, 20 Jul 2011 22:56:20 +0200
Message-Id: <1311195380-28406-1-git-send-email-matthias.andree@...68...>
Subject: [Openvpn-devel] [PATCH] Skip rather than fail test in addressless
	FreeBSD jails.
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
Cc: Matthias Andree <matthias.andree@...68...>

Signed-off-by: Matthias Andree <matthias.andree@...68...>
---
 t_cltsrv.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t_cltsrv.sh b/t_cltsrv.sh
index 808d719..5bcbfc7 100755
--- a/t_cltsrv.sh
+++ b/t_cltsrv.sh
@@ -33,7 +33,7 @@ case `uname -s` in
 	    echo "###"
 	    echo "### To run the test in a FreeBSD jail, you MUST add an IP alias for the jail's IP."
 	    echo "###"
-	    exit 1
+	    exit 77
 	fi
     fi
     ;;
-- 
1.7.4.1


