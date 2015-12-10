References: <5661686A.4090305@...2070...>
	<1449656275-24934-1-git-send-email-iam@...2070...>
	<56694C04.6020904@...277...>
	<CAKuzo_j6+gjt+_EDVt3CeOR89mAnDNdYtMFfzXDMHbiTjumgnA@...278...>
From: ValdikSS <iam@...2070...>
Message-ID: <5669A739.2030901@...2070...>
Date: Thu, 10 Dec 2015 19:24:25 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_j6+gjt+_EDVt3CeOR89mAnDNdYtMFfzXDMHbiTjumgnA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fI2eWlAbc7vWaksDqWXrI6q5O0MLt25gm"
Subject: Re: [Openvpn-devel] [PATCH v8-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, Lev Stipakov <lstipakov@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fI2eWlAbc7vWaksDqWXrI6q5O0MLt25gm
Content-Type: multipart/alternative;
	boundary="------------020602040103080704080700"

This is a multi-part message in MIME format.
--------------020602040103080704080700
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

That would break name resolver on reconnection if remote is a hostname.

On 12/10/2015 06:53 PM, Selva Nair wrote:
>
> On Thu, Dec 10, 2015 at 4:55 AM, Lev Stipakov <lstipakov@...277... <mailt=
o:lstipakov@...277...>> wrote:
>
> That sounds useful for yet another reason as well. Its only necessary to =
delete and recreate the permit filters when the tun restarts. The block fil=
ters need
> be set up only once.
>
> Selva
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--------------020602040103080704080700
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    That would break name resolver on reconnection if remote is a
    hostname.<br>
    <br>
    <div class=3D"moz-cite-prefix">On 12/10/2015 06:53 PM, Selva Nair
      wrote:<br>
    </div>
    <blockquote
cite=3D"mid:CAKuzo_j6+gjt+_EDVt3CeOR89mAnDNdYtMFfzXDMHbiTjumgnA@...278..."
      type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra"><br>
          <div class=3D"gmail_quote">On Thu, Dec 10, 2015 at 4:55 AM, Lev
            Stipakov <span dir=3D"ltr">&lt;<a moz-do-not-send=3D"true"
                href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstip=
akov@...277...</a>&gt;</span>
            wrote:<br>
            <div><br>
            </div>
            <div>That sounds useful for yet another reason as well. Its
              only necessary to delete and recreate the permit filters
              when the tun restarts. The block filters need be set up
              only once.<br>
            </div>
          </div>
          <br>
        </div>
        <div class=3D"gmail_extra">Selva<br>
        </div>
      </div>
      <br>
      <pre wrap=3D"">_______________________________________________
Openvpn-devel mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Openvpn-devel@...1466...=
urceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.sourceforge.net/li=
sts/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/op=
envpn-devel</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------020602040103080704080700--

--fI2eWlAbc7vWaksDqWXrI6q5O0MLt25gm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJWaac5AAoJEFzXIC7viPdyqMYP+wSsfFBZQYOPEueTlSIwek5g
94uPM4BoFCHugu+gjEXyvw3tOve3yk9fLiwESBsCcacqGj1CU8GxaerDINiVNRWl
6cYkcZfyzWHJne4Q/+ZWWI3VOWHwwgNiaonlk5o8u/aXkJPK2TEDcVFgFV1AC9Jg
xukdr8Quz2Y4HY2YUdhNkHMXCV8Qik1hXqBQF6xaBLWaECZzmKvwstbpRtfp7zfo
o0/JqqOhb+7tqOOgd+JAIhkVPe0fUPqkjMxikJaPvtItwmVnvr4vyUO7sknN8tFY
37K5aCH66Hv6u8RqIcLtXp1KtJN9pA4sOW7IJgv3BZMdfHeV/8JF8iRmeE90cVSo
aDQz/6kOftj5PYTwdyMsnaK+ApWI9MeIEsBRwEgvznLeI1bRlpoxXCmKAsudYkyS
Qv/So5niriqsd9TS9f7i2F98GCOKHmE/NLFnYOh1xbi3MrezzR0zMuxK3Qcbjt9x
lCUdbonjgXFhKU6k3E4DoL5E7Bfiq+hosqzTFgFBftwxBTB7LaJmhJtrzCeY7+u5
sKTIPmLAEOp/6Hg2uhaCOOfzywkxLCJE+K4zE+4XKrjdeRY8A4COyXk7owmMilH+
6Iv8iwPM4nJKSe8hyGPh8RzaGYanAel66ByBr4Gqe2OgOwahxj7pg8TgAvAdfHRF
Cic/dlWIC2uVVtuhlnHT
=NREh
-----END PGP SIGNATURE-----

--fI2eWlAbc7vWaksDqWXrI6q5O0MLt25gm--

