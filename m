From: Noam Rathaus <noamr@...117...>
Date: Wed, 11 Jul 2007 12:31:33 +0300
References: <826043.40120.qm@...1036...>
In-Reply-To: <826043.40120.qm@...1036...>
MIME-Version: 1.0
Message-Id: <200707111231.33598.noamr@...117...>
Subject: Re: [Openvpn-devel] functions remote in VPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

(I am referring to --remote used to specify more than one remote host/port)

You need to look up references to remote_list, it is filled by code found i=
n=20
options.c and is handled by code found in socket.c

Hope this helps.

On Tuesday 10 July 2007 18:10:28 tiger king wrote:
> I want to search one function in the source code of VPN which really do t=
he
> command "--remote " but I just can't find.
>
> Would you please help me a bit?
>
> Thanks a lot :)
>
>
>
>
>
>
> _________________________________________________________________________=
__
>_________ Don't pick lemons.
> See all the new 2007 cars at Yahoo! Autos.
> http://autos.yahoo.com/new_cars.html



--=20
=C2=A0 Noam Rathaus
=C2=A0 CTO
=C2=A0 1616 Anderson Rd.
=C2=A0 McLean, VA 22102
=C2=A0 Tel: 703.286.7725 extension 105
=C2=A0 Fax: 888.667.7740
=C2=A0 noamr@...117...
=C2=A0 http://www.beyondsecurity.com

