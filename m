Date: Thu, 22 Oct 2015 17:21:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151022152127.GJ22054@...1296...>
References: <1445519360-24866-1-git-send-email-lstipakov@...277...>
	<20151022132635.GF22054@...1296...>
	<1445521155.4113.71.camel@...1866...>
	<CA+UdHn9f9reNrCCdtw8+Ei2KZ9_2beDPCL9Vb-JGs2jJ5nnrXw@...278...>
	<20151022135158.GG22054@...1296...>
	<1445522144.4113.79.camel@...1866...>
	<20151022135935.GH22054@...1296...>
	<1445522997.4113.84.camel@...1866...>
	<20151022141709.GI22054@...1296...>
	<1445523893.4113.92.camel@...1866...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ysxpgsskrg70M4rk"
Content-Disposition: inline
In-Reply-To: <1445523893.4113.92.camel@...1866...>
Subject: Re: [Openvpn-devel] [PATCH] Use adapter index instead of name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Woodhouse <dwmw2@...1866...>
Cc: Martin Pauly <pauly@...2079...>, Olli =?iso-8859-1?Q?M=E4nnist=F6?= <olmannisto@...277...>, openvpn-devel@lists.sourceforge.net

--Ysxpgsskrg70M4rk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 22, 2015 at 03:24:53PM +0100, David Woodhouse wrote:
> I don't understand why you're feeding get_adapter_index_method_1() a
> GUID prefixed with \DEVICE\TCPIP_ instead of a name, either, since the
> MSDN documentation for GetAdapterIndex() suggests that it takes the
> interface name. Hey, maybe that's why it didn't work and you had to
> invent a new method? Maybe I'm best not looking at your code at all :)

I hav *so* no idea...  this code is all much older than my involvement
here :-) - but the method_2 approach looks halfway sane.

> But still, I'm not booting Windows today. Not for all the tea in China.

Cross-compiling indeed only gets one half-way here...

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Ysxpgsskrg70M4rk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVij+96kuBuNlUUl1AQImLwP+KEP7LKHFIWQbdWUP5TKYCEnRUG+71nlF
0tFwID1KqXb/ZPtFo0UShErU2zAjRvYkSttaRyl40c6O231Dn5jJrNxEvD8TWkNB
v2wtZOKHL3agAZCnCQSmSwAC09VEgeUlPNC7G2fGXrdiyglORhvofyz7QES958qb
+x4yELf1oAw=
=831b
-----END PGP SIGNATURE-----

--Ysxpgsskrg70M4rk--

