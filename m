Message-ID: <028601c1df78$05da80c0$1000000a@...4...>
From: "James Yonan" <jim@...3...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 1.1-pre2 available
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Mon Apr  8 20:38:01 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Another beta is available, please test.

1.1 final should be forthcoming in a couple days if I don't hear of any
problems.

pre1 -> pre2 changes:

* New option --shaper that does traffic shaping (i.e. bandwidth limiting).
This option could be used for example to build two tunnels between the same
peers, one running at full speed, and the other at reduced bandwidth for
batch-type transfers such as off-site-backups.  See the man page for more
info.

* Fixed "make install" to also install the man page.

* OpenBSD and --tun-af-inet fixes.

* Other minor fixes.

* CVS updated.

* Manual page updated.

http://openvpn.sourceforge.net/beta/openvpn-1.1-pre2.tar.gz

James



