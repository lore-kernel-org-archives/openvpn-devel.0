From: Denis Vlasenko <vda@...216...>
Subject: Re: [Openvpn-devel] how to implement the multi client in openvpn?
References: <E1BXaJk-0002Y9-B8@...110...>
In-Reply-To: <E1BXaJk-0002Y9-B8@...110...>
MIME-Version: 1.0
Message-Id: <200406081115.52753.vda@...216...>
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
Date: Tue Jun  8 01:19:03 2004
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: quoted-printable
To: 

On Tuesday 08 June 2004 09:38, oyk wrote:
> >not always. I am using udp, not tcp (tcp over tcp is prone
> >to 'internal meltdown' if your network losing packets,
> >and you _must_ design your network as if it does, even in reality it
> >works perfectly). Also, ethheader exists only on tap devices, not tun.
> >So, my picture is:
> >
> >[ip(real ips)|udp|ip(tun ips)|.....]
>
> Thank you very much.
> There are many companies and organizations are developing VPN based SSL,
> such as stunnel. But many developments/solutions could solve TCP only.

SSL'ed protocols (i.e. tunneling streams over TCP) are fine.
Tunneling TCP packets over TCP is another matter, its a Bad Thing.
AFAIK even openvpn manpages have URL of the relevant article.

> I think whether it is possible to develop SSL VPN based virtual NIC, which
> could solve the whole IP protocols (TCP/UDP, ARP etc). Simultaneity, we
> could do the fine-granted access control in the application layer to
> protect the internal resource. In my last experience, I developed TDI
> driver-based SSL VPN solution (for widnows client). And the server just do
> like stunnel. I think it is hard to support UDP, ARP on this routine. So,=
 I
> want to do some work on the virtual NIC.
> Could you give me some your advice?
> Thanks a lot.

I don't understand what you're asking, sorry.
Doesn't OpenVPN already does what you want?
--=20
vda

