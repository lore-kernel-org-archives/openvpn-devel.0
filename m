Date: Tue, 29 Sep 2020 08:55:35 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200929065535.GJ976@...1296...>
References: <20200920152738.20086-1-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6zn93sY2JrH9m7VZ"
Content-Disposition: inline
In-Reply-To: <20200920152738.20086-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Alias ADAPTER_DOMAIN_SUFFIX to DOMAIN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--6zn93sY2JrH9m7VZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Sep 20, 2020 at 06:27:38PM +0300, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
>=20
> ADAPTER_DOMAIN_SUFFIX is an openvpn3 replacement for
> DOMAIN, which is used there for split-dns. This is pushed by
> modern Access Server.
>=20
> This change improves compatibility between OpenVPN
> community client and Access Server.

I agree that compatibility with AS is important, but I'd rather not
*advertise* this new flag everywhere - so, accepting it as alias for
DOMAIN is ok, but my gut feeling is "it should neither show up in
the man page nor in the online help" - we do not want to encourage
people to use it.

Also, the great re-indentation of the online help might look orderly,
but makes the output actually harder to read with all the whitespace
(plus, some of the resulting lines are too long).  So I'm not happy
with that either.


Thus, unless someone else feels very strongly otherwise, I think we=20
should reduce this to the single-line change that adds the alias
(watch out for line length!), but leave out the --help change.  The=20
man page change should mention "this is a compatibility option, and
should not be used in new deployments" or so.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--6zn93sY2JrH9m7VZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfctpnAAoJEB2Cnv7KVigSNn4L/j3NzcpkGG2D8w5+KdB5FmCF
k+arhu9KD9FhmE8IQgwufKoevNsn9FErxtVLmnfUWDJZN2tSrPeWmNoET3/eW4GZ
RVIg9zXq9tfrok1eeWUYLLDK6G9fFatLFrI4Go49RMyEr0kDV/vOWV4Zfeco4iei
1rRDgvtSLnH4Z+t+V5XGagkqRl3WwHbQS9Tl58ZvFZMIrfRf9iFpvr9PkEOkkN6e
+nr2nn567+9idz8RQbgMlZED2PsGwXIEvYmJS0kisMFXfPnQGYZuDVKLYXFX0/sR
edYxBQQjTEZ3X3PYNtiLwZ3dG7asOgp5lADpMzZ35yZJIp0BluiRtHR21IlNnjIn
So5NxE+z3htfdhLqY/GVVIb5p0/z3QJgla8ksZkLro2s2bMhCH1Kc/5H6QmnIZE8
WMurb6maGEbOtT6CxF1Uo3jHwdlGirahiTH6bpknK3950BHfYIXPgEzDeidPE6bN
F0OpDTXRK+BV2IcpbcAIuG47RHcTAkYIaNX7pVht8Q==
=iOd4
-----END PGP SIGNATURE-----

--6zn93sY2JrH9m7VZ--

