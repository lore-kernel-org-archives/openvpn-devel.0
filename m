Message-ID: <00f701c2137d$382f0300$1000000a@...4...>
From: "James Yonan" <jim@...3...>
MIME-Version: 1.0
Subject: [Openvpn-devel] windows port
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
Date: Fri Jun 14 01:25:03 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I discovered today that OpenVPN 1.2.1 builds and runs almost perfectly in
the Cygwin environment under windows.  Of course there's no tun or tap
device yet, but by running with --dev null and --ping 1, you can put OpenVPN
through many of its paces including crypto and UDP network connectivity.  I
was able to connect to a linux peer using SSL/TLS mode and send pings back
and forth.

So it looks like the OpenVPN code itself is ready to go on windows as soon
as we can get a tun or tap driver working.

James



