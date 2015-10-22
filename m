Date: Thu, 22 Oct 2015 16:17:09 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151022141709.GI22054@...1296...>
References: <1445519360-24866-1-git-send-email-lstipakov@...277...>
	<20151022132635.GF22054@...1296...>
	<1445521155.4113.71.camel@...1866...>
	<CA+UdHn9f9reNrCCdtw8+Ei2KZ9_2beDPCL9Vb-JGs2jJ5nnrXw@...278...>
	<20151022135158.GG22054@...1296...>
	<1445522144.4113.79.camel@...1866...>
	<20151022135935.GH22054@...1296...>
	<1445522997.4113.84.camel@...1866...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9+5BC3PU/OvlBx+n"
Content-Disposition: inline
In-Reply-To: <1445522997.4113.84.camel@...1866...>
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

--9+5BC3PU/OvlBx+n
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 22, 2015 at 03:09:57PM +0100, David Woodhouse wrote:
> So Olli and Lev would appear to be saying. For OpenConnect I haven't
> actually tested this hypothesis. Unfortunately I'd need to reimplement
> the get_adapter_index stuff under LGPL first...

Looking at our tun.c I wish I hadn't done that... but it seems that
using GetAdaptersinfo() should get you pretty far (which is what=20
get_adapter_index_method_2() uses under the hood)...

But indeed, this direction seems to be non trivial...

get

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--9+5BC3PU/OvlBx+n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVijvhqkuBuNlUUl1AQIGkgP/R3ehpJPWry4c8IUj5AEboQCU+P/TXo3k
WQy/s4hppshTmbq3kAJoofw/l2XxWO5TLmu6GoLpG7+jIrX/81bgQP5oQNlOeRS2
lQV3naJF+8vh9FeNIVhBCWMtBNNsTBJLt8u1UeKxYTxoLfCQVAH7hflRIFx2oCCk
JzCt6AcYRK4=
=TAB+
-----END PGP SIGNATURE-----

--9+5BC3PU/OvlBx+n--

