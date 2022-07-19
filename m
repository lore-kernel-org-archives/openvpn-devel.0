Date: Tue, 19 Jul 2022 11:51:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YtZ+vSi6ZNenPV7o@...1296...>
References: <20220719080715.1445-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="B3JFJOxP2ND7G05o"
Content-Disposition: inline
In-Reply-To: <20220719080715.1445-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3 12/25] dco: check that pulled options
 are compatible
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

--B3JFJOxP2ND7G05o
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 19, 2022 at 10:07:15AM +0200, Antonio Quartulli wrote:
> A server may push options that are not compatible with DCO.
> In this case we should log a message and bail out.
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>

This patch is fine as it is, but during discussion we found a missing
case - a server pushing "compress <something>".

There's basically (at least) 3 ways to handle this - so bringing this up for
discussion, and a future patch

 - add "compress" to check_dco_pull_options()
 - extend dco_check_option_conflict() to set "allow-compression no" (this=20
   will make openvpn refuse all incoming "compress" configs on its own)
 - or extend dco_check_option_conflict() to make "allow-compression asym/ye=
s"
   disable DCO

I tend to option 3 - default for allow-compression is "no" anyway with
2.6, so if you have this in your config, compression could show up in
a ccd/ file or pushed -> no DCO for you.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--B3JFJOxP2ND7G05o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi1n69AAoJEB2Cnv7KVigSx3QL/3NPom4/Qjq5u3FOCrgvnwmq
X+LAES+EiSXnEPulkovr4N+7QSIJQ3Eabk2tp0E9m7uzCKGg9O3h324qEhpeEMD3
QnozqE03ENzrvnJkUvIJBpDZbwAbLosUTMkJ9nHJKrdfoRAbEAtr/IqAdAdMfpP5
jSGLQVld1PSKkDWhPd1G8dNGIS9g55Bv2lXVq5qaO32CSicVrWJbMO4HU//SRNsd
HTh7CNgb76QK8CjnuazdU3/HaDWrtIgWQvi1xREs4w/oGDJUyNtmg/NGGWIDz9qz
1onZI1GIgSsjzMz3vonEeN0xSZ39PZJPcqLRJUSSqK3Rr/qYOyia7VZGIzg8e4H3
i0LF9xsb38vFGS3EfePdNtNMboSpUzZ1kNbe5NjImPQtP9VX4ulH/1QkbAWDMSLl
rp5pOA2mTo2rxUk5YK47pliAOsoESKa7lJoOUTpH3l39vAn8fcTAm59mO5+ayMQ3
KWVw/FCLaxGkNENYph/2Kw2we39miMd9si5gE7IsGA==
=ifUj
-----END PGP SIGNATURE-----

--B3JFJOxP2ND7G05o--

