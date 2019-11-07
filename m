Date: Thu, 7 Nov 2019 19:31:35 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191107183135.GS40538@...1296...>
References: <1573148729-27339-1-git-send-email-lstipakov@...277...>
 <1573148729-27339-2-git-send-email-lstipakov@...277...>
 <CAFHpkQEhR0w_BPbhAiudQO8AfN0yAdSx5cdtAXa1BB+vGqwsCg@...278...>
 <CAGyAFMU0G3ucCYXv6SmSx8A0=SbzuQ-6bwws+eT2Nq-rsawFKw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cycRQitB/3DOnQyb"
Content-Disposition: inline
In-Reply-To: <CAGyAFMU0G3ucCYXv6SmSx8A0=SbzuQ-6bwws+eT2Nq-rsawFKw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/7] Visual Studio: upgrade project
 files to VS2019
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: ???????? ?????????????? <chipitsine@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cycRQitB/3DOnQyb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Nov 07, 2019 at 07:28:36PM +0100, Lev Stipakov wrote:
> With VS2019 you cannot build for XP,  you would need to install build too=
ls
> from VS2017 for that.
>=20
> On the other hand, we do not build releases with VS, so it should not be =
an
> issue.

Not sure right now about 2.4, but for master/2.5, we dropped support for
XP/Vista long ago.=20=20

So "not being able to build for XP" would not be a problem.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--cycRQitB/3DOnQyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdxGMGAAoJEB2Cnv7KVigSSj0L/2itSVHfewubhAfK9crB9AG1
Pz9wT7YC3GB8a9OAvfVVGPe7ktSY+Tg41iaJ5Yf3omNb5Ll/AUp8YR5j4Hyfc98C
Q5pDQ3nyuos2QgK9sdWMxOFg3qTIHr/5BkNFcOQOhnBF58X8q41PwIakWNdgMDCu
0o54KW8o+058SlaJvWKJHtlenWSWSDrMOOgAz3qo+pPnFCKBsjyYwxIzy45WLeRy
b8yyPL44gUhwc4+Yhne4qgsyC0xD06yfDogJmkXdGjPV5iHOAK4p5qmzPfbyRYKH
SRLDHhuh3cuK6uD/Z5SPPTE4/jAxXEeq0vPCAj9llQD9i9xGkRhz8C1zRdJBDGfE
BFosr6Cc8/F0BEMZDjqnxgTHtpi/OzFwVVD5FkLybViB8AWvqaqqg7vrMjkh7vi4
MFdLWeUikHsyMvG9NjZJzLBapuRxpB8b9I497E/kVyFP/BtWXDboM0cK0Nu31/mx
2f/BqXaU+CBbClvutAtOha9mSnw5e0Vib8YcO+VPzA==
=pV4x
-----END PGP SIGNATURE-----

--cycRQitB/3DOnQyb--

