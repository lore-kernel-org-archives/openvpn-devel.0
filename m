References: <1452901505-3898-1-git-send-email-iam@...2070...>
	<20160116123507.GE24952@...1296...>
From: ValdikSS <iam@...2070...>
Message-ID: <569A4E71.4000707@...2070...>
Date: Sat, 16 Jan 2016 17:06:41 +0300
MIME-Version: 1.0
In-Reply-To: <20160116123507.GE24952@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vh1GsTBKX634P5whORnjietU2COTxi3lM"
Subject: Re: [Openvpn-devel] [PATCH] Clarify --block-outside-dns
	documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, ValdikSS <iam@...2070...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vh1GsTBKX634P5whORnjietU2COTxi3lM
Content-Type: multipart/alternative;
	boundary="------------080805010700040509070102"

This is a multi-part message in MIME format.
--------------080805010700040509070102
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

You're right, thanks.
Sent v2 of this patch.

On 01/16/2016 03:35 PM, Gert Doering wrote:
> Hi,
>
> On Sat, Jan 16, 2016 at 02:45:05AM +0300, ValdikSS wrote:
> While I agree with the idea (and this is a frequent question, so thanks!),
> it's not totally correct for Windows XP - with the Fish patch, it actually
> is *not* an "unknown option", it will "just fail".
>
> --setenv opt block-outside-dns
>
> will handle that (because it will change the message level before running
> the option processor, so it does not matter if the option is unknown or
> fails to initialize), but --ignore-unknown-option will not work on XP -
> it is not "unknown", so that code path does not apply.
>
> gert
>
>
> -------------------------------------------------------------------------=
-----
> Site24x7 APM Insight: Get Deep Visibility into Application Performance
> APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
> Monitor end-to-end web transactions and take corrective actions now
> Troubleshoot faster and improve end-user experience. Signup Now!
> http://pubads.g.doubleclick.net/gampad/clk?id=3D267308311&iu=3D/4140
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--------------080805010700040509070102
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    You're right, thanks.<br>
    Sent v2 of this patch.<br>
    <br>
    <div class=3D"moz-cite-prefix">On 01/16/2016 03:35 PM, Gert Doering
      wrote:<br>
    </div>
    <blockquote cite=3D"mid:20160116123507.GE24952@...1296..."
      type=3D"cite">
      <pre wrap=3D"">Hi,

On Sat, Jan 16, 2016 at 02:45:05AM +0300, ValdikSS wrote:
</pre>
      <pre wrap=3D"">
While I agree with the idea (and this is a frequent question, so thanks!),
it's not totally correct for Windows XP - with the Fish patch, it actually
is *not* an "unknown option", it will "just fail".

--setenv opt block-outside-dns

will handle that (because it will change the message level before running
the option processor, so it does not matter if the option is unknown or
fails to initialize), but --ignore-unknown-option will not work on XP -
it is not "unknown", so that code path does not apply.

gert
</pre>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">------------------------------------------------------=
------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
<a class=3D"moz-txt-link-freetext" href=3D"http://pubads.g.doubleclick.net/=
gampad/clk?id=3D267308311&amp;iu=3D/4140">http://pubads.g.doubleclick.net/g=
ampad/clk?id=3D267308311&amp;iu=3D/4140</a></pre>
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

--------------080805010700040509070102--

--vh1GsTBKX634P5whORnjietU2COTxi3lM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJWmk5zAAoJEFzXIC7viPdyOy0P+wQP99WvEE0oAc+jGY4ToDmi
3ILH7vJKAkxJKRr2kfwmHWjMRZi92bdB9bT8BRY7ZYxnilzFEvHejulrj5Op5t7E
m4p67xjAa8qpzzthfn5hZDZmOcs+d0c/aw5hME//QC1OEk+ID/bghti5T8HZ9zGS
GJf5u2dfAjSjjWPkKcuE6CE2kETF/zyThyZB3g00w2gaYwp78RJSeZ8IjRi2cOnA
+lMgHchyTZthPIDr6iT+PsvCTK650S+DOsLRPMTFSaJtxVIxkIvKFijunPn73f7F
fBHZxP5A91VR4vJ5pcnutBZ5e6zwYXAC1eLGB7Qpulz0EJPlMGQwTGMxcSkbo7uY
op2h1fc7IwmFtBlHPYsr4codvESccGyVvychcbpxwjsKg5u7OxNoDMR3gOGz1yvI
mWn8ynSo6J+14jwjDbhG0jAIik/uuj61cb+AefhpayNrRJajJWVYo+dLgeKcEvV4
xTe23oF6kfmHkkHywaMJ8MFhdLgNjYHajvuGn7X6o2DcNFRNfO2lmWA6nrJIpUT4
5uy3xaiMoAyN6iUdTYlZA/ItDVzy/w4cYyG0NbY2u7XThSoZStUNb7HTpAcf9VW9
RdssHtaYlJEqh2JJNm1SlGL6rgbyubxJgKRPYfM8U10y4DqLGW2Vc4Z5whBGyUeI
MY0wmzjbJWBJS1D688vT
=pAna
-----END PGP SIGNATURE-----

--vh1GsTBKX634P5whORnjietU2COTxi3lM--

