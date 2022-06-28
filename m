Date: Tue, 28 Jun 2022 17:50:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YrsjXOafFHQAWj2E@...1296...>
References: <20220624083809.23487-2-a@...2181...>
 <202206281507.25SF7EVp045610@...2054...>
 <10438362.6d2rlngR5E@...2664...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="z/UWSyCVx55mNdFL"
Content-Disposition: inline
In-Reply-To: <10438362.6d2rlngR5E@...2664...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: dco: introduce low-level
 code for handling ovpn-dco in the Linux kernel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

--z/UWSyCVx55mNdFL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 28, 2022 at 05:46:40PM +0200, Heiko Hund wrote:
> On Dienstag, 28. Juni 2022 17:07:14 CEST Gert Doering wrote:
> > Uncrustify has complained at me when I merged the patch (because in that
> > moment, ovpn_dco_linux.h was "newly modified" and the exclusion rule
> > does not match on the pre-commit-hook) - but as discussed, this is a bit
> > complicated due to "kernel style" vs "openvpn style", so I've left it
> > alone for the moment.
>=20
> That's something which needs to be improved. Who is dev-tools/special-fil=
es.lst=20
> intended for? Can uncrustify read it?

We have dev-tools/reformat-all.sh which was used for the "Grand Reformat"
commits - that one reads the special-files.lst, which can contain
"E: <exclude this file>" or some other magic stuff for "pre/post-patch
because uncrustify is stupid".

Having the pre-commit-hook honour the E: exclusion lines would certainly
make handling these files a bit easier - but then, I do not expect updates
to them very often, so this is not super high priority.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--z/UWSyCVx55mNdFL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiuyNcAAoJEB2Cnv7KVigSTokL/iSRovhwX8hmYZPRRdFf3NoA
LpScDJZea6yEWTeic7JGsXgiXV9p8eY5nQkdx6OYlqxiYNZxciUUS9B9B/1bu9VY
qkgITNfwkR7XF22EDKyHHfE8cycJy8sDBrVGIf5lYFN5FYia3h7592sJU7ZnU9zi
MM7suvMW9incnu6vnLPqX2XfntmqhiNqwknLBVLzBXfvdz6/McEkcOvNcUYVxrNr
pD9B/EoHwMtZdHHcQKp7tMCeBIoIXaRpueeagjNrj9Xl/8DiIAX8bIEUL0kCIuz5
DMReYbMtx/PIMTHE+rnY+u88C/Sd7X4WGSkiiOAq5YdPjwPwY2+ie91YQ5cgldh4
y58ijpBEnLVjCGUU8IytkXuyJLfaVTE6PVRxcKs6+5Q1REhnKVHUd8qHeqAvd2vy
zEkztSHcov+LqMFvip6NWb6U2jzSTLJvFini9Lm26O36Ym4ozjgKJoxSomeWn3ZN
BC0FqWiU1vamOKQ59DbNbYqOAqMeReVCvvgjxIppsQ==
=9lCx
-----END PGP SIGNATURE-----

--z/UWSyCVx55mNdFL--

