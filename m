From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 11 Jul 2025 12:07:00 +0200
Message-Id: <20250711100700.241668-1-frank@...2641...>
In-Reply-To: <gerrit.1751514980000.I7adfaa08df6a17545cca8264d7230b5e65e49719@...2715...>
References: <gerrit.1751514980000.I7adfaa08df6a17545cca8264d7230b5e65e49719@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] mac dns: do not run dns-updown in
 parallel
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
Cc: Heiko Hund <heiko@...2662...>, Arne Schwabe <arne-openvpn@...1227...>

From: Heiko Hund <heiko@...2662...>

In case more than one openvpn connection is coming up or going down at
the same time, there is potential for breakage, since the operations
performed are not atomic.

Introduce a locking mechanism, which let's scripts run in sequence, to
prevent races between them.

Change-Id: I7adfaa08df6a17545cca8264d7230b5e65e49719
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1076
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts/macos-dns-updown.sh
index 73bbee9..fb17b2b0 100644
--- a/distro/dns-scripts/macos-dns-updown.sh
+++ b/distro/dns-scripts/macos-dns-updown.sh
@@ -26,6 +26,23 @@
 #   dns_server_1_sni dns.mycorp.in
 #
 
+lockdir=/var/lock
+if [ ! -d "${lockdir}" ]; then
+    /bin/mkdir "${lockdir}"
+    /bin/chmod 1777 "${lockdir}"
+fi
+
+i=1
+lockfile="${lockdir}/openvpn-dns-updown.lock"
+while ! /usr/bin/shlock -f $lockfile -p $$; do
+    if [ $((++i)) -gt 10 ]; then
+        echo "dns-updown failed, could not acquire lock"
+        exit 1
+    fi
+    sleep 0.2
+done
+trap "/bin/rm -f ${lockfile}" EXIT
+
 [ -z "${dns_vars_file}" ] || . "${dns_vars_file}"
 
 itf_dns_key="State:/Network/Service/openvpn-${dev}/DNS"

