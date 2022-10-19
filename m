Date: Wed, 19 Oct 2022 22:56:14 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Y1BkbnMzpOPVsx3v@...1296...>
References: <CAKuzo_gRebSz5GObVLJodQvxV2x1XvxFoXoBxe6RuC3fb3eJog@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vSQ2k9ridjC71CEc"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gRebSz5GObVLJodQvxV2x1XvxFoXoBxe6RuC3fb3eJog@...278...>
Subject: Re: [Openvpn-devel] Is auth-nocache broken?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vSQ2k9ridjC71CEc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 19, 2022 at 02:33:27PM -0400, Selva Nair wrote:
> Using --auth-user-pass, --auth-nocache and --reneg-sec <a small value>, no
> auth-tokens in use, I see that username/password is prompted on the first
> connection attempt and at first renegotiation. After that reneg completes
> without prompting for user/pass.

It's possibly we broke that by trying to repair all the corner cases
with either pushing tokens from the server, or *not* using auth-nocache.

I assume you tested with master?

(Unfortunately my automated tests all use "username + passwords are
coming from a file", which means "send the same one as before" and
"go read the file again" both produce the same effect... having
a management-interface driven client test would help here... no
time yet to write one)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--vSQ2k9ridjC71CEc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjUGRuAAoJEB2Cnv7KVigSr6EL/1pyPF/Kf/jGgvGZO5KaHQdJ
LViCemyytjKNVMpdrq8DNxdV19UkZfpZ+7n526rf+oXjCLYJb7i9PFanzUHRKInA
wurZXj/cme3yeSjwxTLeM9LoJsMwULE6mrfG7Ho+GExajOWk15L3Rs2hzNVd6VTU
tu9DvS8D8CtA2HqBYdFIMhZlx7T7MMHyi/oUFNwyXEEQH7VjBwiZWk65g/a2Gia8
kNfmldHjbdU8oXphNQZY0aoY9rJciZd074fX2DOpzBRO7FApsEI4favt/pPSh1Nb
xgj4hwui1ujGmuoffxFXINIsq1WZlR9kIntud4BRIqB01qPbuX+2RRwpSAPmNmhe
JmALcEu7lKFMdJ8Z2hw+aYYqQCreSXMddlAkpk63PEfPmjRa5DxSyk5HdlOxUR2F
Jx3f15DMqMZmTmV8sujoGo2s4w9kI+3HOAjron9qDVYYOx+VTw6pYA65Fm9UE0GZ
EUig4J+k8EZP79uZneW4B7b+aiX+rSFMNGWSXVrb6g==
=fk+t
-----END PGP SIGNATURE-----

--vSQ2k9ridjC71CEc--

