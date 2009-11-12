From: Olaf Fraczyk <olaf@...1271...>
In-Reply-To: <4AFBEE55.5070202@...515...>
References: <1256844344.7529.43.camel@...1272...>
	<4AFBEE55.5070202@...515...>
Date: Thu, 12 Nov 2009 19:33:52 +0100
Message-Id: <1258050832.4308.3.camel@...1272...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] 2.1 rc20 and multiple interfaces problem
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: James Yonan <james@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Hello,

No, I wasn't using --multihome - I didn't know that this option exists
and that is necessary. I haven't found it in man page and in
documentation on the web page. The only place where I found it (after
you let me know about it) was with openvpn --help.

Thank you, I'll try it.
BTW, why is it not by default?

Regards,

Olaf
On Thu, 2009-11-12 at 04:15 -0700, James Yonan wrote:
> Are you using the --multihome option?
>=20
> James
>=20
> Olaf Fraczyk wrote:
> > Hello,
> >=20
> > I have several interfaces, the problem is that if:
> >=20
> > I open connection from client to server IP=3DY on interface ppp1 then I
> > get packets back from IP=3DX on interface ppp0
> >=20
> > For connection to IP=3DX on interface ppp0 I get correctly packets from
> > IP=3DX on ppp0.
> >=20
> > I have read that in 2.1 it should work, but it doesn't.
> >=20
> > The OS is CentOS 5.4.
> >=20
> > Best regards,
> >=20
> > Olaf
>=20
--=20
Olaf Fr=C4=85czyk <olaf@...1271...>
NAVI
http://www.navi.pl
http://www.ntp.navi.pl


