References: <564BA6DB.4070703@...2070...>
	<564DE8B3.9030803@...2070...>
	<20151124083944.GY24952@...1296...>
	<5654A314.3080607@...2070...>
	<20151124201135.GM24952@...1296...>
	<CAKuzo_jdcOjunyVmpT8er3HqWG7yh6pr+i8Tn8kD3omj=G_Pqw@...278...>
From: ValdikSS <iam@...2070...>
Message-ID: <565547AB.9030607@...2070...>
Date: Wed, 25 Nov 2015 08:31:23 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jdcOjunyVmpT8er3HqWG7yh6pr+i8Tn8kD3omj=G_Pqw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m7XHXUApAiRuR4vqtfqFD1fEmapWWauft"
Subject: Re: [Openvpn-devel] [PATCH v4-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m7XHXUApAiRuR4vqtfqFD1fEmapWWauft
Content-Type: multipart/alternative;
	boundary="------------030708090607070902070003"

This is a multi-part message in MIME format.
--------------030708090607070902070003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It's cron2 who wanted clear ifdefs for master, because there's no WinXP sup=
port there.
I need help with 2.3 build system. While the code itself would compile fine=
, it won't link because I can't figure out how to link libraries available =
in vista+
only for vista+ build and do not link it for XP.

On 25.11.2015 03:13, Selva Nair wrote:
> Hi,
>
> On Tue, Nov 24, 2015 at 3:11 PM, Gert Doering <gert@...1296... <mailto:ge=
rt@...1296...>> wrote:
>
> Not sure I understand this.  The patch I had tested all along had ifdef _=
WINNT_WIN32 >=3D 0x0600 around everything. So the code nicely silences itse=
lf when
> built for XP (I did not try this though). I built only 64 bit version for=
 vista+.=20
>
> And this was against the master. Now the new sets of patches have differe=
nt ifdefs: _WINNT_WIN32 >=3D 0x600 for 2.3, and if defined(WIN32) for maste=
r. This
> appears unnecessary. Two patches are still needed as some context lines h=
ave changed between 2.3 and master, but the code could be the same, and, in
> particular, the ifdefs could be just _WINNT_WIN32 >=3D 0x600.
>
> May be you mean the same?
>=20=20
> Selva
>=20=20


--------------030708090607070902070003
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Type=
">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    It's cron2 who wanted clear ifdefs for master, because there's no
    WinXP support there.<br>
    I need help with 2.3 build system. While the code itself would
    compile fine, it won't link because I can't figure out how to link
    libraries available in vista+ only for vista+ build and do not link
    it for XP.<br>
    <br>
    <div class=3D"moz-cite-prefix">On 25.11.2015 03:13, Selva Nair wrote:<b=
r>
    </div>
    <blockquote
cite=3D"mid:CAKuzo_jdcOjunyVmpT8er3HqWG7yh6pr+i8Tn8kD3omj=3DG_Pqw@...278..."
      type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">Hi,</div>
        <div class=3D"gmail_extra"><br>
          <div class=3D"gmail_quote">On Tue, Nov 24, 2015 at 3:11 PM, Gert
            Doering <span dir=3D"ltr">&lt;<a moz-do-not-send=3D"true"
                href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1386...=
296...</a>&gt;</span>
            wrote:<br>
          </div>
          <br>
          Not sure I understand this.=C2=A0 The patch I had tested all along
          had ifdef _WINNT_WIN32 &gt;=3D 0x0600 around everything. So the
          code nicely silences itself when built for XP (I did not try
          this though). I built only 64 bit version for vista+.=C2=A0</div>
        <div class=3D"gmail_extra"><br>
        </div>
        <div class=3D"gmail_extra">And this was against the master. Now
          the new sets of patches have different ifdefs: _WINNT_WIN32
          &gt;=3D 0x600 for 2.3, and if defined(WIN32) for master. This
          appears unnecessary. Two patches are still needed as some
          context lines have changed between 2.3 and master, but the
          code could be the same, and, in particular, the ifdefs could
          be just=C2=A0_WINNT_WIN32 &gt;=3D 0x600.</div>
        <div class=3D"gmail_extra"><br>
        </div>
        <div class=3D"gmail_extra">May be you mean the same?</div>
        <div class=3D"gmail_extra">=C2=A0</div>
        <div class=3D"gmail_extra">Selva</div>
        <div class=3D"gmail_extra">=C2=A0</div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------030708090607070902070003--

--m7XHXUApAiRuR4vqtfqFD1fEmapWWauft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJWVUerAAoJEFzXIC7viPdyV7MP/3MtCF6mQKimiyQXTcC3/Zw6
lpn2qAQ339+X5ajYvLdaTNiwZoPE9KDDmoOtMoXGpNV1emXv0rxx7te8qXxW/i7u
CFAYq2+5e6IWWq+gDr9lqKRBCPPPEdlsGjsO2GqlcZLkUwtUPCpGxrEtP/Qs2pY8
tr7zMxO8fR0a5osXBSNEow6K3jP6cfFadDl5Dso4gvS3LleD4ihXqtAwnGqn2URg
a81spkV4ktzcaaNyZggulBK3hRAx5QJ03nRjCLIIzPgyCa3tso1CZ79i+X4Hnefy
w/4t3D3b/X1jV9jVXG5miuWZWRYh/cQIaPME7BtJwobAmASKLq0rXlm+2dMVEK+s
3SFRs45ft/39GV+rSkPcVWxkXiOL02+VZun2nxgtBwRcWlrWR5u/QMRH0DHsl438
tSSsb8pORcbRsf+Bd2k9tJfxqcfAj+R/JjX9ltKVAyauDdBEpIbyWY0rYgIRiQCe
40CGsYNK1sPURSl9Oo+wC+M47fdHUqK/AjWZUsLAlM7uqFSvlOoc2n3p52kgHDDZ
bsY8SLV4RT5GN2Zy+8gtruTyaJKxuXtkBhD5U5zDEyomPywKvTGGjEWzW6r1bEX/
uQBiP3tDfpjlfx61P0IaDttctc3n5x1swnQJKXKA/DSpb3uHwRlLtCYJBKKPFMhG
pO1bekM5k7zfd2JEMydf
=H4us
-----END PGP SIGNATURE-----

--m7XHXUApAiRuR4vqtfqFD1fEmapWWauft--

