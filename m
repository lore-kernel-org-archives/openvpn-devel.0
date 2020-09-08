From: "Vladislav Grishenko" <themiron.ru@...277...>
References: <20200903114455.29341-1-themiron@...2010...>
 <0ec2c2a7-61d5-69c6-76a4-af83c283c64c@...2080...>
In-Reply-To: <0ec2c2a7-61d5-69c6-76a4-af83c283c64c@...2080...>
Date: Wed, 9 Sep 2020 00:01:28 +0500
Message-ID: <020d01d68612$75dbca00$61935e00$@gmail.com>
MIME-Version: 1.0
Content-Language: ru
Subject: Re: [Openvpn-devel] [PATCH] Fix --remote protocol can't be set
 without port argument
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: 'David Sommerseth' <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

Hi David,

> -----Original Message-----
> From: David Sommerseth <openvpn@...2080...>
> Sent: Tuesday, September 8, 2020 6:23 PM
> To: Vladislav Grishenko <themiron@...2010...>; openvpn-
> devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] [PATCH] Fix --remote protocol can't be set w=
ithout
> port argument
>=20
> On 03/09/2020 13:44, Vladislav Grishenko wrote:
> > According client-options.rst additional argumets ``port`` and
> > ``proto`` are both optional and it's allowed to have port absent and pr=
otocol
> set:
> >     --remote args
> >       Examples:
> >          remote server.example.net tcp
> >
> > But when protocol is set without preceeding port argument, it is being
> > misparsed as a port with subsequent error:
> >     RESOLVE: Cannot resolve host address: server.example.net:tcp
> >     (Servname not supported for ai_socktype)
> >
> > Since protocol names are predefined and don't match service names, fix
> > this behavior by checking second argument for valid protocol first.
> >
> Uhm ... I'm leaning towards a NAK to this patch and would rather suggest
> updating the man page to be correct.  This is a mistake from my side when
> converting the man page to .rst files.  The example should be:
>=20
>        remote server.example.net 1194 tcp
>=20

Hum. Initially all variants were supported, by checking numeric port and ta=
king it as proto, if not numeric. Later port became string servname and opt=
ional logic was lost.
Man pages still has all of them since that time:
	remote server.exmaple.net
	remote server.exmaple.net 1194
	remote server.exmaple.net tcp

At first look there is no need for proto w/o port set,  why it can be impor=
tant?
With support of server host & port discovery (DNS SRV RFC 2782), port info =
is not required, only host and protocol make sense. So I though about this =
one little step forward toward ~consistent syntax.
Does it makes any sense?

> The OpenVPN 2.4 and prior releases has this line:
>=20
>        --remote host [port] [proto]
>=20
> But this syntax was not supported by rst2man, so it was replaced with "ar=
gs"
> and the examples coming below; which carried an error.
>=20
>=20
> --
> kind regards,
>=20
> David Sommerseth
> OpenVPN Inc
>=20



