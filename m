From: Charles Duffy <cduffy@...294...>
Message-ID: <pan.2005.04.16.13.51.55.26678@...294...>
References: <20050416082546.854.qmail@...373...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: Multipacketing to get better efficiency for small packets?
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
Date: Sat Apr 16 06:54:12 2005
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On Sat, 16 Apr 2005 01:25:46 -0700, Tomas Nouza wrote:

> After almost a year using OpenVPN, I found there are a lot of protocols
> sending big amount of small packets instead of smaller amount of bigger
> packets (e.g. skype, samba/netbios, and even tcp acks ...). And OpenVPN
> encapsulates each packet into openvpn packet. Those protocols cannot be
> changed, but when I simultanously captured packets on Tap and eth
> interface, I saw the openvpn overhead for those packets (especially
> smaller than 200B) is quite high.

IIRC, this has already been discussed, and the conclusion was that
combining small packets would be a feature to be built on top of OpenVPN
3.0 (when it becomes not so much a VPN application as a general-purpose
userspace network stack that happens to have a VPN app bundled).


