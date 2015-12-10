References: <5661686A.4090305@...2070...>
	<1449656275-24934-1-git-send-email-iam@...2070...>
	<56694C04.6020904@...277...> <20151210162651.GI24952@...1296...>
From: ValdikSS <iam@...2070...>
Message-ID: <5669AD21.4000301@...2070...>
Date: Thu, 10 Dec 2015 19:49:37 +0300
MIME-Version: 1.0
In-Reply-To: <20151210162651.GI24952@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DnWQooLpRO3CHlTE17dABccG17uF24ljt"
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
To: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DnWQooLpRO3CHlTE17dABccG17uF24ljt
Content-Type: multipart/alternative;
	boundary="------------010204090409080002060904"

This is a multi-part message in MIME format.
--------------010204090409080002060904
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

It's a very minor actually, FwpmSubLayerDeleteByKey0 is indeed fails every =
time but it doesn't break anything since we close the engine right after. L=
ev
suggested to use a correct way with making a filter GUID and deleting it be=
fore deleting sublayer, but I'd better go with just closing the engine with=
out
deleting everything. I don't see any drawbacks, that should be perfectly OK=
 for a dynamic session.

Is this correct, Lev? If yes, I'll push v9 today or tomorrow morning.

On 12/10/2015 07:26 PM, Gert Doering wrote:
> Hi,
>
> On Thu, Dec 10, 2015 at 11:55:16AM +0200, Lev Stipakov wrote:
> [..]
> So, is this something that needs to be fixed before we release 2.3.9, or
> can it wait for improvement later on?
>
> I just agreed with Samuli that we are going to release 2.3.9 on Monday,
> and this should go in - so either I get a v9 "with nice and shiny" until
> Sunday, or someone tells me "v8 is good enough, go for it"...
>
> Thanks :-)
>
> gert
>
>
> -------------------------------------------------------------------------=
-----
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--------------010204090409080002060904
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    It's a very minor actually, FwpmSubLayerDeleteByKey0 is indeed fails
    every time but it doesn't break anything since we close the engine
    right after. Lev suggested to use a correct way with making a filter
    GUID and deleting it before deleting sublayer, but I'd better go
    with just closing the engine without deleting everything. I don't
    see any drawbacks, that should be perfectly OK for a dynamic
    session.<br>
    <br>
    Is this correct, Lev? If yes, I'll push v9 today or tomorrow
    morning.<br>
    <br>
    <div class=3D"moz-cite-prefix">On 12/10/2015 07:26 PM, Gert Doering
      wrote:<br>
    </div>
    <blockquote cite=3D"mid:20151210162651.GI24952@...1296..."
      type=3D"cite">
      <pre wrap=3D"">Hi,

On Thu, Dec 10, 2015 at 11:55:16AM +0200, Lev Stipakov wrote:
</pre>
      <pre wrap=3D"">[..]
</pre>
      <pre wrap=3D"">
So, is this something that needs to be fixed before we release 2.3.9, or
can it wait for improvement later on?

I just agreed with Samuli that we are going to release 2.3.9 on Monday,
and this should go in - so either I get a v9 "with nice and shiny" until
Sunday, or someone tells me "v8 is good enough, go for it"...

Thanks :-)

gert
</pre>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">------------------------------------------------------=
------------------------
</pre>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
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

--------------010204090409080002060904--

--DnWQooLpRO3CHlTE17dABccG17uF24ljt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJWaa0hAAoJEFzXIC7viPdy37gP/2pQp+ctDChVigoPUdZJ9/De
kYwD6qtUjR/mnk2xN0t5auVzubM/6c2vjr5vzNc48td9qtPd6HGKNk7NSthxf2WG
rbNENUXTABA2LnPKvLHprrDu2I75RTM6iD0m29A2/er1rnLF/qrocDhia5nAObbQ
81QRQDCSH13vnCAhxR4Hz/kIe14uYPfVa6H+Zc5/SjoDo8snc+mwdSeVqTUVd2Lc
x+kNgbPkSR28p4riEcvfMDyojHd+5d6mvjN44N/SAPbY8AzsjOcapPtNzXmeTbKb
bQCSUR5e3zI1uWuHoqpElzFvmuAYkxpk2V4VkpAB+16UcKqQZ7E+7yadELeXr9Uo
8KLDPPt18CT7LTfjd+43lbcgnGod/EHX8yyj1H3QqWDYunXfBmuSvWJL0mHe6Dy4
9njqpPKyj7zqs+roDiq+VUlgeYnO00DFvq2dGgHAWL3gZ0Xr8ZvBLv9riUOtxtdn
XTRZMJhEXTb3JaY+zOerD6rfd1ifOV2Q8z0PPxI2iT8Di90sYBqOArZDXoeDR6GK
KwnwyQUGo5cxcv4TAQC0vFga8lLVrRyZxduVndjFNnBXYoEzHxaQ4WzLQ0YyzZRK
H19vfV2j64bqlpABB35t92IgvdbRqc/MlH8aKup1Xm1OlCFqrzqBvQQJ6SqTilbG
iGF2u7efuvZ6pC8+bSYn
=Fp+E
-----END PGP SIGNATURE-----

--DnWQooLpRO3CHlTE17dABccG17uF24ljt--

