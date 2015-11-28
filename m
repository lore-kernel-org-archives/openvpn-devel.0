References: <20151125082651.GT24952@...1296...>
	<1448477731-21421-1-git-send-email-iam@...2070...>
	<56560812.4050008@...2070...>
	<CAKuzo_j+asj4qBeZEPMcOH5coqy2PmXpLzBQQ5Vd6j8jJ2njbQ@...278...>
From: ValdikSS <iam@...2070...>
Message-ID: <5659C357.8030206@...2070...>
Date: Sat, 28 Nov 2015 18:08:07 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_j+asj4qBeZEPMcOH5coqy2PmXpLzBQQ5Vd6j8jJ2njbQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RsDiT1SbRE3GnxeEP8sPO71wIhVWqC7EI"
Subject: Re: [Openvpn-devel] [PATCH v5-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RsDiT1SbRE3GnxeEP8sPO71wIhVWqC7EI
Content-Type: multipart/alternative;
	boundary="------------000600080302000206060902"

This is a multi-part message in MIME format.
--------------000600080302000206060902
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi!

You have the point, note is confusing on XP. Changed it to "=E2=80=A6on Win=
dows Vista or later".

Non-fatal note message is intended to have one config file on various platf=
orms without any modifications. On the other hand, you probably would still=
 use
ignore-unknown-option to comply with outdated versions. As my own preferenc=
e, I'd like to keep it non-fatal, but if you think this is inappropriate be=
haviour,
I'll change that.


On 26.11.2015 20:20, Selva Nair wrote:
> Hi,
>
> I did some tests on the patch for 2.3 [*]. Build for vista+ needed some h=
acking of configure.ac <http://configure.ac> (but that's not relevant for t=
his patch).
>
> For XP+, it builds out of the box. When the resulting exe is run on windo=
ws 7 with --block-outside-dns, it prints the following warning
>
> "NOTE: block-outside-dns option works only on Windows"
>
> Apart from the confusing warning, I had expected the process to exit with=
 unknown option error.
>
>=20=20
> This has to be something like  "... not supported in this version or buil=
d" or some such..
>
> In fact, that #else clause short-circuits the default error handling of u=
nknown/unsupported options. It may be best to omit it altogether and let th=
e final
> if-block handle the unknown option. Or at least use msglevel_fc in place =
of M_WARN so that it will exit if appropriate to do so.
>
>
> Selva
>
> [*] v5 2.3 patch with the missing include <initguid.h> manually added.


--------------000600080302000206060902
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Type=
">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    Hi!<br>
    <br>
    You have the point, note is confusing on XP. Changed it to "=E2=80=A6on
    Windows Vista or later".<br>
    <br>
    Non-fatal note message is intended to have one config file on
    various platforms without any modifications. On the other hand, you
    probably would still use ignore-unknown-option to comply with
    outdated versions. As my own preference, I'd like to keep it
    non-fatal, but if you think this is inappropriate behaviour, I'll
    change that.<br>
    <br>
    <br>
    <div class=3D"moz-cite-prefix">On 26.11.2015 20:20, Selva Nair wrote:<b=
r>
    </div>
    <blockquote
cite=3D"mid:CAKuzo_j+asj4qBeZEPMcOH5coqy2PmXpLzBQQ5Vd6j8jJ2njbQ@...278..."
      type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">Hi,</div>
          <br>
        </div>
        <div class=3D"gmail_extra">I did some tests on the patch for 2.3
          [*]. Build for vista+ needed some hacking of <a
            moz-do-not-send=3D"true" href=3D"http://configure.ac"
            target=3D"_blank">configure.ac</a> (but that's not relevant
          for this patch).</div>
        <div class=3D"gmail_extra"><br>
        </div>
        <div class=3D"gmail_extra">For XP+, it builds out of the box. When
          the resulting exe is run on windows 7 with
          --block-outside-dns, it prints the following warning</div>
        <div class=3D"gmail_extra"><br>
        </div>
        <div class=3D"gmail_extra">"NOTE: block-outside-dns option works
          only on Windows"</div>
        <div class=3D"gmail_extra"><br>
        </div>
        <div class=3D"gmail_extra">Apart from the confusing warning, I had
          expected the process to exit with unknown option error.</div>
        <div class=3D"gmail_extra"><br>
        </div>
        <div class=3D"gmail_extra">
          <div>=C2=A0</div>
          <div class=3D"gmail_extra">This has to be something like =C2=A0".=
..
            not supported in this version or build" or some such..<br>
          </div>
          <div class=3D"gmail_extra"><br>
          </div>
          <div class=3D"gmail_extra">In fact, that #else clause
            short-circuits the default error handling of
            unknown/unsupported options. It may be best to omit it
            altogether and let the final if-block handle the unknown
            option. Or at least use msglevel_fc in place of M_WARN so
            that it will exit if appropriate to do so.</div>
          <div class=3D"gmail_extra"><br>
          </div>
        </div>
        <div class=3D"gmail_extra"><br>
        </div>
        <div class=3D"gmail_extra">Selva</div>
        <div class=3D"gmail_extra"><br>
        </div>
        <div class=3D"gmail_extra">[*] v5 2.3 patch with the missing
          include &lt;initguid.h&gt; manually added.</div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------000600080302000206060902--

--RsDiT1SbRE3GnxeEP8sPO71wIhVWqC7EI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJWWcNXAAoJEFzXIC7viPdyOyQQAMG5t/1K+4JhH3PWPL0D2oJk
KO2OkbGs9e+7Y9dgRoDEysZVDeCKQWTyJpdI+KRECIb9sb4MwFeAlk8iJt5t1pz5
PIN41PCq+gb7cczLTrEQZEbpsgdxEJ63YMF3CTrxlUOUFNWR1wAmWrPZtNAFUXDP
90u9fAxGM8f4x9w22DBUMU0LQBTjlkuE9qcahnQ3LAZj1dVlHq7NhAr6LE1ZORPR
ykehcyLWUuTu5TAAeZzMpgfZUhu9xqoRUlcFkXHDFbkv2UTXeH6r2ATm/fEX9fQ/
iQnDgLGsBdKnDKaf3xr4QsLtV/mWtZkzFazlIN8M1P7581todzsHMamVAhbH2Y1c
IDoWjgokVv49c6CfdFDLWX86ZA6KH4mQA8JiTsSGyut75fqA8SmfTgQdrlgcxe/j
lSHIcijhFtYpJxAljoK0YEmPA4TqoKsnG7niEr9gegteVIkdNsfPkCmFCRLVeNzi
+EpWgV2mT21+FxXL9wJjvUzFz6BGvkhRnzvnkJEXtXb0M3hwU37Wy9MnlrsD+mWs
OPaui/vfck9GtPNJOyNlxxe8pEcwAVvka6QDdV5iZUXhe0zvLIFagFzEZcv2GfXR
D11mRhwrzsLPq99dhENWtmWKO4X0A9r4BoT1jyYtpKYJczzoXG9VeazwMpLdc6Eo
0PO3D4OfFl2LN47i2cri
=F8rG
-----END PGP SIGNATURE-----

--RsDiT1SbRE3GnxeEP8sPO71wIhVWqC7EI--

