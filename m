Date: Tue, 11 Aug 2015 21:23:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150811192358.GK382@...1296...>
References: <55CA09E0.3020503@...2052...> <55CA0FDC.6020004@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZU1YD3w2J6q+rwco"
Content-Disposition: inline
In-Reply-To: <55CA0FDC.6020004@...1227...>
Subject: Re: [Openvpn-devel] SRV record support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--ZU1YD3w2J6q+rwco
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 11, 2015 at 05:08:12PM +0200, Arne Schwabe wrote:
> > SRV record mechanism/requirements are the following:
> >   - It's protocol-specific, so at lookup time it has to be known whether
> > it's for UDP or TCP
> If proto were optional that would fit OpenVPN better. But SRV records
> seem not support that.

Well, one could just do two lookups, one for _tcp and one for _udp,=20
and use that to fill pseudo-<remote>-entries, not only with port info
but also with protocol info..

But it's not totally trivial.

[..]
> And if you modify anything use -master and not 2.3 as starting point.
> The code in question has changed a lot between releases (dual stack
> client patches).

Yes, what Arne said.  And this will not go into 2.3 as it will be too
much of a change to be added into a release fairly late in its maintenance
cycle... so "master it is".

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ZU1YD3w2J6q+rwco
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVcpLzqkuBuNlUUl1AQLFHgP/RcdVoDEiRT+VlgYFRkgq5pUnDccphYt0
kz2fux9ZF0BZJuJR46Uo3iqEp18zRKHzgsrRLIcNlGlim+UuKIGsspU/3x9YAQy1
quNxnlrKluTRqHIZe6cNlTgh7R18XILVfrx+ZZv/eJ/Em926hGqUJ4EDL6l0UeFD
Gnd/COtufbQ=
=Q1z3
-----END PGP SIGNATURE-----

--ZU1YD3w2J6q+rwco--

