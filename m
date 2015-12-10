References: <5661686A.4090305@...2070...>
	<1449656275-24934-1-git-send-email-iam@...2070...>
	<56694C04.6020904@...277...>
	<CAKuzo_j6+gjt+_EDVt3CeOR89mAnDNdYtMFfzXDMHbiTjumgnA@...278...>
	<5669A739.2030901@...2070...>
	<CAKuzo_iu2ucwr5KrKwv56DJ_wYZ1Qkku=k7M_OcU2qJXRUNeOw@...278...>
From: ValdikSS <iam@...2070...>
Message-ID: <5669AD8A.3060202@...2070...>
Date: Thu, 10 Dec 2015 19:51:22 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iu2ucwr5KrKwv56DJ_wYZ1Qkku=k7M_OcU2qJXRUNeOw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vG9kcOw6VnHrdMMsck6BHcEahPKEh02EF"
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
To: Selva Nair <selva.nair@...277...>, ValdikSS <iam@...2070...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vG9kcOw6VnHrdMMsck6BHcEahPKEh02EF
Content-Type: multipart/alternative;
	boundary="------------070705030802040904060504"

This is a multi-part message in MIME format.
--------------070705030802040904060504
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

No, I'm afraid it would fail by default  since DNS queries are (usually) ma=
de from svchost.exe. Whitelisting openvpn.exe is done to not to break OpenV=
PN on UDP
port 53. I could be incorrect tho.

On 12/10/2015 07:31 PM, Selva Nair wrote:
>
> On Thu, Dec 10, 2015 at 11:24 AM, ValdikSS <iam@...2070... <mailto:iam@...1186...=
.2070...>> wrote:
>
> Yes, I meant to leave the block all and permit openvpn.exe filters always=
 on and delete/re-add only the filters for the tun/tap interface. Well, its=
 probably
> just a cosmetic change, so no strong opinion.
>
> Selva
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--------------070705030802040904060504
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    No, I'm afraid it would fail by default=A0 since DNS queries are
    (usually) made from svchost.exe. Whitelisting openvpn.exe is done to
    not to break OpenVPN on UDP port 53. I could be incorrect tho.<br>
    <br>
    <div class=3D"moz-cite-prefix">On 12/10/2015 07:31 PM, Selva Nair
      wrote:<br>
    </div>
    <blockquote
cite=3D"mid:CAKuzo_iu2ucwr5KrKwv56DJ_wYZ1Qkku=3Dk7M_OcU2qJXRUNeOw@...278..."
      type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra"><br>
          <div class=3D"gmail_quote">On Thu, Dec 10, 2015 at 11:24 AM,
            ValdikSS <span dir=3D"ltr">&lt;<a moz-do-not-send=3D"true"
                href=3D"mailto:iam@...2070..." target=3D"_blank">iam@...2098...=
0...</a>&gt;</span>
            wrote:<br>
          </div>
          <br>
        </div>
        <div class=3D"gmail_extra">Yes, I meant to leave the block all and
          permit openvpn.exe filters always on and delete/re-add only
          the filters for the tun/tap interface. Well, its probably just
          a cosmetic change, so no strong opinion.<br>
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

--------------070705030802040904060504--

--vG9kcOw6VnHrdMMsck6BHcEahPKEh02EF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJWaa2KAAoJEFzXIC7viPdyXi8P/Ru0Vq7rtzdyN+ZcJfv8cdAp
v1hZsbD/Z6r5Zgw2+8MdifKKDOKOvfQK56N+FsrEPrF6FxCdvME/FrfnnXBwP6Wf
0UExLKBJuWfxVf/mgtHOlxkyvnW4lEQ2FoPxH62PmeCGvLCTrXiujyAsE/aq82HD
R1wh59Q2zwIunARDcl5kKKT/78bl4GJFGq2ymF5g3lHHoEIvAMhVcaD2S8FiRm7h
pRcEHamib5EZSwE9yWgGlF2l6ml6suBF8/rMrusKRx3p/+Blf8YTPf4XxfeWle95
ir4uWoNjHve2I7K7KQfsPgj77EEcbaX8Kfc5+SfTQ1k3U5IGNVNLap7unKSFwbZH
gw2ux/Uxw+EmtC5vS7IABSpaYtbQPIae/3K3F+JsuKFZnuEZmZrH3JlKsCb4+o7p
kqrI9xuC9Wg8ZbXeApObHofISeV1OdP8dzRquKvH4CoHvANrEwA4JDpRuyXGYqZo
rKiUUkhDVTGpnhmDRQQgIJINwTGIqQbDDo5oiDej8pbYxPP21/74Kyo+NoRUjZR5
we2DFwGUSKFyB/Djo8EBDtH1prNSJTPgBuBUJcoyWbvIMhmkhLPy2KSzkS73akDp
Ag7PB2vLL5CHrr1Wo6cvMwsf8yk5LgeoLnCYFVWIANU91mQvwIam109DoYbfql29
lnNCmh3OJjJIworW82QD
=8/aT
-----END PGP SIGNATURE-----

--vG9kcOw6VnHrdMMsck6BHcEahPKEh02EF--

