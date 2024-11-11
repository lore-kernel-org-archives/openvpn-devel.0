Date: Mon, 11 Nov 2024 14:38:48 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZzII6DIVQER__GFg@...1296...>
References: <gerrit.1731290343000.I993e7fc5609955d271e74370affc2eea340a1e2d@...2715...>
 <20241111094033.16073-1-gert@...1296...>
 <a8d3854b-2b7a-44ba-97b8-cdb250b0d0ff@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="sIxm/CsHAIDQwlmu"
Content-Disposition: inline
In-Reply-To: <a8d3854b-2b7a-44ba-97b8-cdb250b0d0ff@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v1] Change --reneg-bytes and
 --reneg-packets to 64 bit counters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--sIxm/CsHAIDQwlmu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 11, 2024 at 02:31:48PM +0100, Antonio Quartulli wrote:
> > -        options->renegotiate_bytes =3D positive_atoi(p[1]);
> > +        char *end;
> > +        long long reneg_bytes =3D strtoll(p[1], &end, 10);
>=20
> why int64_t in options.h and long long here?
> I think they should always match in size, but why not use it consistently?

Because strtoll() is documented to return "long long"...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--sIxm/CsHAIDQwlmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJnMgjoAAoJEB2Cnv7KVigSI54L/2seus73PBZDP+CaljDYnNn4
hZKE+GkiM3jPn/DmD6Y9mF3YWWjQwJvgKObCt0w8VPiSNLSNOhdPtRy3MiHGe9kA
65KKdEt/e3muUI91QCBbGP54cHsPGpTUSYYlpMBJfUpCl+Xp6Xe6a37NhVy2YJW6
kx4yhGsrtqQekNsvyoYd24heFho0S80qJN2ITqa+I6zrfNvk1NL7uLihQOIzHULM
liIKNtVJCzOuqqhbx6aRGK/B2r2J7+XsAeWwOHl3PoyAPzlI9ZHqWPo3O3/g/ePy
KxtFEs9LSJ44JAMRwfcY5pfRIqCIAddIEJ+Z0IUhLw0iSmf9XsfSgEYYfGt43Sq5
FPYB4PO5YYYKjt8lnl9db0v+LqcNZnRBjCj45nAQkomeb+Aw6o1wLj1+wZPbKPv0
DTuuVZk+i6p58rLGEjwh/uRmQZozM+cvznj587aQ8LThe6ku3uJJ3mwIlko2T+E2
sXdVCvngd6uhIDCt7Bw9AKaFBPkN0XJmSDbI/BAXWg==
=FWg0
-----END PGP SIGNATURE-----

--sIxm/CsHAIDQwlmu--

