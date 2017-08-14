References: <20170701112951.19119-1-steffan@...1856...>
 <b67daad4-362b-3605-5716-3e17c5f0c362@...2080...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <7ca195bc-c088-5ccc-3b2f-07e2dec215ee@...1435...>
Date: Mon, 14 Aug 2017 13:17:25 +0200
MIME-Version: 1.0
In-Reply-To: <b67daad4-362b-3605-5716-3e17c5f0c362@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kIU114eCDvOl8nWDK1dwu9EtL1HORkGIh"
Subject: Re: [Openvpn-devel] [PATCH] Deprecate --keysize
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--kIU114eCDvOl8nWDK1dwu9EtL1HORkGIh
Content-Type: multipart/mixed; boundary="sbLx2pSinfxWixKlxwJ39OMvXm8U8nMUi";
 protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <7ca195bc-c088-5ccc-3b2f-07e2dec215ee@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Deprecate --keysize
References: <20170701112951.19119-1-steffan@...1856...>
 <b67daad4-362b-3605-5716-3e17c5f0c362@...2080...>
In-Reply-To: <b67daad4-362b-3605-5716-3e17c5f0c362@...2080...>

--sbLx2pSinfxWixKlxwJ39OMvXm8U8nMUi
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 14-08-17 12:36, David Sommerseth wrote:
> On 01/07/17 13:29, Steffan Karger wrote:
>> The --keysize option can only be used with already deprecated ciphers,
>> such as CAST5, RC2 or BF.  Deviating from the default keysize is
>> generally not a good idea (see man page text), and otherwise only
>> complicates our code.>
>> (If this patch is accepted, I'll send a follow-up patch to remove the
>> option from the master branch.)
>=20
> I agree to the wanted intention of this change.  But, it hits badly if
> we remove --keysize on configurations still enforcing BF-CBC with
> --keysize 256.  I don't have any numbers of how many users uses it; but
> I know many have preferred BF-CBC for a long time - at least before
> SWEET32 came and hit us all.  Bare in mind that BF-CBC was the default
> since 2002-ish (probably even longer, if considering the OpenVPN v1.x
> branch). And many have added --cipher BF-CBC in their configs despite it
> was the default.
>=20
> As long as BF-CBC is available, we cannot remove --keysize.  And to
> remove BF-CBC support, I think that needs a bit longer timespan than
> v2.5.  Users *must* be far better prepared for that and we need to make
> loud and clear announcements with such a change.
>=20
> Yes, in all this, I know that NCP is a nice rescue.  As long as everyone
> either runs v2.4 everywhere or deploys --ncp-ciphers and starts the
> migration.  But I've lost confidence that the vast majority of our users
> pays closely attention to such feature changes - thus they won't notice
> until it stops working.  We need to PUSH this information into their
> faces, with large posters carrying promises of rainbow coloured unicorns
> if they comply today(!).  In addition to adding clear warnings in the
> log files for a looong time.
>=20
> So I propose:
>=20
> - We add the warning about removing --keysize for both v2.4 and v2.5.
>=20
> - Add a warning in v2.4 and v2.5 that ciphers with block sizes < 128
>   bits will be *removed* in v2.6
>=20
> - When removing those ciphers in v2.6, we can remove --keysize together
>   with the ciphers, as it will no longer be valid.  But --keysize needs
>   to be a NOP for some time (with a warning it has no effect), to avoid
>   OpenVPN stopping to run on upgrades.

Okay.  Instead of sending the keysize removal patch, I'll send a patch
that warns that small block ciphers will be removed in 2.6.

Can you then do s/2.5/2.6/ on the patch, or shall I send a v2?

-Steffan


--sbLx2pSinfxWixKlxwJ39OMvXm8U8nMUi--

--kIU114eCDvOl8nWDK1dwu9EtL1HORkGIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZkYbKAAoJEEEwndWOY1w5fUMIAIdfSbYr3EG5ixMHXeLtZvn9
dTHKOJBb3YrxjkVmArRnKtD+RzetaAHpqTGfkupqskGqW+lswMuq6ocaqAJU6NSY
l76c7nS5tzhrGNaWHdpoV+pZ7h7tub941OzcYcSUbQ7wEyGdm85zPiViLqMHD+eE
Xuf9EQ0ujRkOsY2yDEUj5y0h/nMgmfJI1UI30aufITlrSK1t55gx4qkm1RDu7/4C
DGUqv5VrZm7ud/N2FIq/NLFZRXTL7UD/hm5dgA7BMZQYsMnG6z9JslSIcWSd+t65
HebPS3P5XOUrUwaLT4m19fa4uwj7gexgp5e9Q2SilNi2tzXBjSIaSw/+5LIK6VA=
=nTyj
-----END PGP SIGNATURE-----

--kIU114eCDvOl8nWDK1dwu9EtL1HORkGIh--

