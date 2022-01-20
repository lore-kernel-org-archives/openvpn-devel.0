Date: Thu, 20 Jan 2022 18:24:07 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Yemat3tmIyN8Hq+s@...1296...>
References: <20211214165928.30676-8-selva.nair@...277...>
 <202201201518.20KFI6r4000355@...2054...>
 <CAKuzo_jX7aL3WG91JRk4_+27m=0G4JRvUrVTRzHd6=jqAf3bpg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="sj3L71vWJY7Coj1N"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jX7aL3WG91JRk4_+27m=0G4JRvUrVTRzHd6=jqAf3bpg@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Enable signing via provider
 for management-external-key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sj3L71vWJY7Coj1N
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jan 20, 2022 at 11:32:40AM -0500, Selva Nair wrote:
> On Thu, Jan 20, 2022 at 10:18 AM Gert Doering <gert@...1296...> wrote:
>=20
> > Compile and client tested on 1.1.1 and 3.0.1.
> >
> > Glancing at the code related to management_external_key() does
> > not make me very happy... too many build time variants.
>=20
>=20
> "Happiness" is never a word that comes to mind while reading OpenVPN code=
 :)
> ...

Oh, some of the code paths are really nice these days :-) - but the
#ifdef maze regarding SSL libraries / crypto features is getting truly
annoying.

> Even at our snail's pace, 2.7 may be out before we can break free of
> OpenSSL 1, LibreSSL xyz etc. An option may be to require OpenSSL 3+ or
> similar for external keys, or at least for management-external-key.
>=20
> That feature is really used by only a few platforms (only Android for
> now?).=20

That was my idea - since only Windows and Android use the "xkey" code
paths today (as far as I understand), make 3.0.1 a hard requirement
for Windows and Android, and disable --management-external-key for
older SSL builds.  Maybe this is a bit too drastic, but it would
reduce code paths to be maintained and tested quite a bit.

For Windows and Android, we bundle the SSL library to be used anyway,
so we do not need to care what the OS might bring along.

> Although it's a nifty option that could potentially be leveraged to
> remove pkcs11-helper, CNG etc out of OpenVPN core.

Whatever reduces #ifdef and library dependencies :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--sj3L71vWJY7Coj1N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJh6Zq3AAoJEB2Cnv7KVigSPEcL/2BQIxaWAGzpsOCRyM5vpWjj
7W+fbVzsSNVEiaG+XLeNPpwUrD4X12tFXm4KsdLoOCugILaTQcPuIHpiZGqv+lcm
06GyJN3uQsLaJzzQpKm/RH0Q+OhyVGk4avnogJFOp719rUOZooGY0IDwxjLuv+bP
MxShvdXD1py4T8lQD2GExumDgtiffj2b7eT3Fw4z7pu0djEit23p2dbEv5FrHPIL
Y/01dAJntXPZCUvYvhHEIN/p84NIO4nCD3CpwvEsc+iHMfWwyc/NGA84bdaN4LBV
V4blrkQXnTlakkEq+sf7yv+r76piWWvFekJi/gfiio1FL65RTAKnPmJ5jP8Z0mUG
RbfKs8JZz1xQr6YPnHKNrGMYQl2qj6E9OcvI5eipnOsF0xZOMyWbaDY2/HBN1MAc
sRP4/gwX7hnb4Jmqkbvf/PE7DnwANyhkbhCRqfYgKaRPC7kNaa7K3XNwhPhcFb5F
Qgr2bBSzYexI2ewlietIbWvRCEgEdtWOTx1eF/ybvA==
=mCqt
-----END PGP SIGNATURE-----

--sj3L71vWJY7Coj1N--

