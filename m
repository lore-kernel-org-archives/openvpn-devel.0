From: "oyk" <oyk@...89...>
Subject: Re: [Openvpn-devel] how to implement the multi client in openvpn?
Mime-Version: 1.0
Message-ID: <E1BXcCX-0005aA-Kb@...230...>
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
Date: Tue Jun  8 01:44:05 2004
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: quoted-printable
To: 

Hi=A3=ACDenis Vlasenko
>SL'ed protocols (i.e. tunneling streams over TCP) are fine.
>Tunneling TCP packets over TCP is another matter, its a Bad Thing.
>AFAIK even openvpn manpages have URL of the relevant article.

>I don't understand what you're asking, sorry.
>Doesn't OpenVPN already does what you want?
>--
>vda
I am sorry I did not describe my thought clealy.
Generally, I want to know the mechanism of OpenVPN (In the TCP connection c=
ase).
I am not sure that when OpenVPN use TCP connection, whether it is based on =
SSL.
When multi clients, OpenVPN works like a bridge, right?

If OpenVPN is based SSL when it using TCP. What content is the TCP payload?
[ip(real ips)|tcp|SSL_encrypt(ip(tun ips)|.....)], right?

Best Regards
   Ouyang Kai




