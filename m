Message-ID: <44578A41.20106@...628...>
From: admin2@...628...
MIME-Version: 1.0
Subject: [Openvpn-devel] tap driver for Solaris
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue May  2 09:36:03 2006
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi all,

Is anyone interested in tap driver for Solaris?
I wrote it based on Universal TUN/TAP driver for solaris.
I also modified tun.c of OpenVPN 2.0.7 somewhat and made it to be able to plumb tap
network device on Solaris.
If you are interested in this, please see following web page. You can find source code of
both tap driver and difference file for OpenVPN 2.0.7.

  http://www.whiteboard.ne.jp/~admin2/tuntap/

It has not been tested well, but it works for me somehow.
Your suggestion or advice would be appreciated.

Regards,

Kazuyoshi <admin2@...628...>

