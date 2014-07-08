From: Gert Doering <gert@...1296...>
Date: Tue,  8 Jul 2014 09:20:54 +0200
Message-Id: <1404804054-32424-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Call init script helpers with explicit path
	(./)
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

The provided OpenVPN init scripts scan /etc/openvpn for *.conf and run
an OpenVPN process for each, and if a .sh script with the same base name
exists, this is run before openvpn.  Change from running "$name.sh" to
"./$name.sh" - depending on the shell used, the script won't be found
otherwise, and ensuring that the script isn't searched in $PATH is the
right thing anyway.

Reported in trac #423

Signed-off-by: Gert Doering <gert@...1296...>
---
 distro/rpm/openvpn.init.d.rhel | 2 +-
 distro/rpm/openvpn.init.d.suse | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/distro/rpm/openvpn.init.d.rhel b/distro/rpm/openvpn.init.d.rhel
index 821abd5..cdf3e9d 100755
--- a/distro/rpm/openvpn.init.d.rhel
+++ b/distro/rpm/openvpn.init.d.rhel
@@ -148,7 +148,7 @@ case "$1" in
 	for c in `/bin/ls *.conf 2>/dev/null`; do
 	    bn=${c%%.conf}
 	    if [ -f "$bn.sh" ]; then
-		. $bn.sh
+		. ./$bn.sh
 	    fi
 	    rm -f $piddir/$bn.pid
 	    $openvpn --daemon --writepid $piddir/$bn.pid --config $c --cd $work
diff --git a/distro/rpm/openvpn.init.d.suse b/distro/rpm/openvpn.init.d.suse
index 2bac7f3..270024e 100644
--- a/distro/rpm/openvpn.init.d.suse
+++ b/distro/rpm/openvpn.init.d.suse
@@ -161,7 +161,7 @@ case "$1" in
 	for c in `/bin/ls *.conf 2>/dev/null`; do
 	    bn=${c%%.conf}
 	    if [ -f "$bn.sh" ]; then
-		. $bn.sh
+		. ./$bn.sh
 	    fi
 	    rm -f $piddir/$bn.pid
 	    $openvpn --daemon --writepid $piddir/$bn.pid --config $c --cd $work
-- 
1.8.5.5


