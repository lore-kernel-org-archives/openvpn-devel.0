From: Denis Vlasenko <vda@...216...>
Subject: Re: [Openvpn-devel] IP adress assignment to tun devices using server mode
References: <twig.1087235354.15668@...41...>
In-Reply-To: <twig.1087235354.15668@...41...>
MIME-Version: 1.0
Message-Id: <200406142326.05872.vda@...216...>
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
Date: Mon Jun 14 13:27:00 2004
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: James Yonan <jim@...41...>, Torge Szczepanek <openvpn-devel@...239...>, openvpn-devel@lists.sourceforge.net
Cc: openvpn-users@lists.sourceforge.net

On Monday 14 June 2004 20:49, James Yonan wrote:
> Torge Szczepanek <openvpn-devel@...239...> said:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Hi!
> >
> > I am currently trying out OpenVPN 2.0 beta 4 using server mode.
> >
> > My config on the server looks like this:
> >
> > dev tun
> > mode server
> > ifconfig 192.168.100.1 192.168.100.2
> > ifconfig-pool 192.168.100.4 192.168.100.254
> > push "route 192.168.100.1 255.255.255.255"
> > route 192.168.100.0 255.255.255.0
> > [...]
> >
> > Everything works fine as expected. (Which is really great. I appreciate
> > the good work done here)
> >
> > I am wondering why there is a subnet of size /30 assigned to the client.
> > I would expect a Point-to-Point device to receive only one ip adress and
> > not a /30 subnet.
>
> This is done for the benefit of OSes (such as Windows) which don't support
> true point-to-point tun interfaces.
>
> The Windows TAP-Win32 driver supports tun interface emulation only.  What
> that means is that the driver can talk to tun interfaces on other OSes, but
> from the perspective of Windows, it sees the tun interface as a virtual
> ethernet interface having a subnet mask of 255.255.255.254, containing the
> two point-to-point interfaces, a network address, and a broadcast address.

255.255.255.252 (252 == 0xFC == 11111100 binary)
--
vda


