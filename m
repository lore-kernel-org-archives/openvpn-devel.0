Reply-To: openvpn-devel@lists.sourceforge.net
References: <1515959073-10376-1-git-send-email-selva.nair@...277...>
 <1515959073-10376-3-git-send-email-selva.nair@...277...>
 <e059b07e-5684-1dbe-cfdf-1271efc594dc@...1227...>
 <CAKuzo_jN9EOK5aPr2dn+m+ynarY-Snt2pwOmz9cV32BpKSFq=w@...278...>
 <CAKuzo_hYwcRDJjYW7i=Ekmi93TAXRb+n=sNyi4y=+gS+vbbtAA@...278...>
 <caf0faaa-428f-29c4-797f-8be8ac4f0f47@...1435...>
 <CAKuzo_jRh+7KSfw6GTVuXTDnMQCDfrH3g5m=N9GGDTDVLijBhg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <07f28923-1023-fe7b-2b3e-e57ad3f6bc8f@...2080...>
Date: Mon, 22 Jan 2018 14:21:49 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jRh+7KSfw6GTVuXTDnMQCDfrH3g5m=N9GGDTDVLijBhg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ehZFEj6inhe69aWrnaakwMHtdtE7LlxU9"
Subject: Re: [Openvpn-devel] [PATCH 2/3] Allow external EC key through
 --management-external-key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ehZFEj6inhe69aWrnaakwMHtdtE7LlxU9
Content-Type: multipart/mixed; boundary="F7MPhnkcs98M3v9JqzesGNCDrRINdCNZw";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Selva Nair <selva.nair@...277...>,
 Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <07f28923-1023-fe7b-2b3e-e57ad3f6bc8f@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Allow external EC key through
 --management-external-key
References: <1515959073-10376-1-git-send-email-selva.nair@...277...>
 <1515959073-10376-3-git-send-email-selva.nair@...277...>
 <e059b07e-5684-1dbe-cfdf-1271efc594dc@...1227...>
 <CAKuzo_jN9EOK5aPr2dn+m+ynarY-Snt2pwOmz9cV32BpKSFq=w@...278...>
 <CAKuzo_hYwcRDJjYW7i=Ekmi93TAXRb+n=sNyi4y=+gS+vbbtAA@...278...>
 <caf0faaa-428f-29c4-797f-8be8ac4f0f47@...1435...>
 <CAKuzo_jRh+7KSfw6GTVuXTDnMQCDfrH3g5m=N9GGDTDVLijBhg@...278...>
In-Reply-To: <CAKuzo_jRh+7KSfw6GTVuXTDnMQCDfrH3g5m=N9GGDTDVLijBhg@...278...>

--F7MPhnkcs98M3v9JqzesGNCDrRINdCNZw
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 18/01/18 16:49, Selva Nair wrote:
> Hi
>=20
> On Wed, Jan 17, 2018 at 3:53 AM, Steffan Karger <steffan.karger@...1435...
> <mailto:steffan.karger@...1435...>> wrote:
>=20
>     Hi,
>=20
>     On 17-01-18 05:24, Selva Nair wrote:
>     > Also I'm toying with the idea of renaming ecdsa-sig/ECDSA-SIGN by
>     > pkey-sig/PKEY-SIGN so that eventually we may be able to use it for
>     > all types of keys and retire rsa-sig. Any thoughts on that?
>=20
>     This was my first though when looking at these patches.=C2=A0 Haven't=
 looked
>     at the code yet, but functionally I think that's the way to go.=C2=A0=
 Even if
>     it were that Ed25519 / Ed448 sigs are technically not ECDSA sigs.
>=20
>=20
> I was waiting for the chatlog before finalizing v2. Looks like there are a
> number of opinions
> that seem to converge towards the same view.
>=20
> This is what I have in my current v2 ready to go out:
>=20
> (i) Current behaviour for rsa signatures stays for now: daemon sends
>>RSA_SIGN=C2=A0 client responds
> with rsa-sig
> (ii) Daemon sends >PK_SIG client responds with pk-sig [*]=C2=A0
> Initially this will be used only for EC, but trivial to switch RSA to thi=
s in
> future.
> So document that new mgmt clients should be prepared to handle all suppor=
ted
> key types via >PK_SIGN/pk-sig and >RSA_SIGN will be eventually removed.
>=20
> As a nice side effect, clients are allowed to respond with pk-sig even if=
 the
> challenge was
>>RSA_SIGN. As a not so nice side effect, the daemon will reply with "SUCCE=
SS
> rsa-sign
> succeeded" because that's what it asked for -- I suppose we can live with=
 that.
>=20
> We can deprecate and remove >RSA_SIGN at a later date by a hard switch wh=
en
> all known clients are capable of handling >PK_SIGN
>=20
> Does this sound like an acceptable solution?
>=20
> Question: while at it should we alter the syntax to
>>PK_SIGN,xxx,<base64>
>=20
> where xxx will be empty for now, but it reserves space for extra info tha=
t may
> come handy for some future signature types (like use PSS padding for RSA =
or
> use PureEdDSA or whatever).=C2=A0

Hi,

I've discussed this quickly with James quite recently.  We are concerned ab=
out
breaking existing front-end integrations by doing too much funky stuff with
RSA_SIGN for EC support.  That in particular touches the signal renaming to
PK_SIGN.

So we have another suggestion.  For external keys to be used,
--management-external-key is needed.  Add an optional argument to this opti=
on,
which indicates a version.  If this argument is not provided, everything wo=
rks
as it is today - without EC support.  If using: --management-external-key 2
... for version 2, do a hard-shift to PK_SIGN with RSA and EC support.

This way we ensure we don't break any existing implementations, we can allo=
w a
period of transition to the new version, and we can in the future when we a=
re
sure PK_SIGN works well and has seen deployment elsewhere start a deprecati=
on
process if the legacy version 1.  But we're not put in a situation where
anything changes suddenly and abruptly.

Any thoughts?


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--F7MPhnkcs98M3v9JqzesGNCDrRINdCNZw--

--ehZFEj6inhe69aWrnaakwMHtdtE7LlxU9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJaZeVtAAoJEIbPlEyWcf3ydK8P/RufRGpxygrIylCDXxNpPHed
T7dCA4m+kY8gPvuCMiE0uwge9RG52toFigfrIxmZ4doI+OR5fhv0wh18X277iDIf
zRjlV/PAVZx9bfPDY+Gy5YbDRWZbzxupzT8a8QBSXPqSjm7tFHa1MYQqcUZM2ruJ
02i0Y3D4SGZYd5lfNN3+jOh9/sk8JvlyRqG8NKAt3+ezGSLa2hAFouGM5rJRfVCA
/rVCcual/WZSn331dm8dOkRIG9NTRJdjrdQmCEvAFfU7sc9EOwI0mfaRJpXekrjX
d3McEL/tkCOmiINn+kkhJFneFWYny1dx930NsC1GTqutxIphDwIwyz6RfUG/FAgv
K/LvcngWAkYmNVnCbriRUaYxyS2sL3w+1VBY1U7R2t4NW1Hqk/fx39n+BgW/pq3T
ao0pn2n9yLP41vqCE9APr+cWvJE818LAe2c2Y8egdZUTyGvzjc0tBPMInEfqifUE
Mmu5WNjLnPpnOCU/iR8nnEPTiahWriOlek91PN1Xymy9fosBJnNpiQnhleLFjuRA
NNNcNQ2vEAOUCyEUe57NpKTYyCnuPTUjnhSq1AMx6lWEEsez/jJsRNgGHWpBiee7
ACXURgSlAIgg40Xlxdut03kgABifCQPoJ6xn45RcHHCtHOripybWZiqWW4ajmcr+
jnOVHSfVnuSZsmkouQri
=PQlb
-----END PGP SIGNATURE-----

--ehZFEj6inhe69aWrnaakwMHtdtE7LlxU9--

