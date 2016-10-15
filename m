References: <294517a1-1e4d-023d-1b86-75d06387ac15@...515...>
	<95391fd4-7b2f-389c-3752-4123d016286d@...68...>
	<CAA1AbxLYBTUPyQBZy-pvyV8gmgBjvLcB4DFAV8_aJuNFspMB5w@...278...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <d0ce06ad-1bfd-a271-f611-183087eb0c08@...68...>
Date: Sat, 15 Oct 2016 11:01:06 +0200
MIME-Version: 1.0
In-Reply-To: <CAA1AbxLYBTUPyQBZy-pvyV8gmgBjvLcB4DFAV8_aJuNFspMB5w@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="6vg428VdCWaXa6QsLqo84FieNDjBW8osq"
Subject: Re: [Openvpn-devel] Separate apt repositories for 2.4-alpha/beta/rc
 releases?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6vg428VdCWaXa6QsLqo84FieNDjBW8osq
Content-Type: multipart/mixed; boundary="OBgbd6mrDC4KosUenNHR711UM2l9RrEo9";
	protected-headers="v1"
From: Matthias Andree <matthias.andree@...68...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <d0ce06ad-1bfd-a271-f611-183087eb0c08@...68...>
Subject: Re: [Openvpn-devel] Separate apt repositories for 2.4-alpha/beta/rc
	releases?
References: <294517a1-1e4d-023d-1b86-75d06387ac15@...515...>
	<95391fd4-7b2f-389c-3752-4123d016286d@...68...>
	<CAA1AbxLYBTUPyQBZy-pvyV8gmgBjvLcB4DFAV8_aJuNFspMB5w@...278...>
In-Reply-To: <CAA1AbxLYBTUPyQBZy-pvyV8gmgBjvLcB4DFAV8_aJuNFspMB5w@...278...>

--OBgbd6mrDC4KosUenNHR711UM2l9RrEo9
Content-Type: multipart/alternative;
	boundary="------------84E51ACEB31AD6CD0DC135F6"

This is a multi-part message in MIME format.
--------------84E51ACEB31AD6CD0DC135F6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 14.10.2016 um 21:51 schrieb Steffan Karger:
>
> On 14 Oct 2016 9:14 p.m., "Matthias Andree" <matthias.andree@...68...
> <mailto:matthias.andree@...68...>> wrote:
> >
> > Am 14.10.2016 um 17:28 schrieb Samuli Sepp=C3=A4nen:
>
> > > Would 2.3.12 -> 2.4-alpha1 be too big an upgrade?
> > >
> > Yes, definitely. Please create a separate distribution for .deb packages
> > derived from pre-releases.
>
> Indeed. We shouldn't upgrade people who are expecting stable releases
> to alpha versions.
>
One more somewhat more constructive note:
Oracle have been naming their VirtualBox packages such that they
included the minor version in the NAME.
So the package name would be openvpn-2.3 or openvpn-2.4 for us, which
creates redundancy as the actual version is added (openvpn-2.3-2.3.12),
but it prevents moving users between release branches.

Alpha/beta releases and perhaps the early release candidates should
still also be marked in a separate "unstable" 'distribution'.

--------------84E51ACEB31AD6CD0DC135F6
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Type=
">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">Am 14.10.2016 um 21:51 schrieb Steffan
      Karger:<br>
    </div>
    <blockquote
cite=3D"mid:CAA1AbxLYBTUPyQBZy-pvyV8gmgBjvLcB4DFAV8_aJuNFspMB5w@...278..."
      type=3D"cite">
      <p dir=3D"ltr">On 14 Oct 2016 9:14 p.m., "Matthias Andree" &lt;<a
          moz-do-not-send=3D"true" href=3D"mailto:matthias.andree@...68..."=
>matthias.andree@...68...</a>&gt;
        wrote:<br>
        &gt;<br>
        &gt; Am 14.10.2016 um 17:28 schrieb Samuli Sepp=C3=A4nen:<br>
        <br>
        &gt; &gt; Would 2.3.12 -&gt; 2.4-alpha1 be too big an upgrade?<br>
        &gt; &gt;<br>
        &gt; Yes, definitely. Please create a separate distribution for
        .deb packages<br>
        &gt; derived from pre-releases.</p>
      <p dir=3D"ltr">Indeed. We shouldn't upgrade people who are expecting
        stable releases to alpha versions. </p>
    </blockquote>
    One more somewhat more constructive note:<br>
    Oracle have been naming their VirtualBox packages such that they
    included the minor version in the NAME.<br>
    So the package name would be openvpn-2.3 or openvpn-2.4 for us,
    which creates redundancy as the actual version is added
    (openvpn-2.3-2.3.12), but it prevents moving users between release
    branches.<br>
    <br>
    Alpha/beta releases and perhaps the early release candidates should
    still also be marked in a separate "unstable" 'distribution'.<br>
  </body>
</html>

--------------84E51ACEB31AD6CD0DC135F6--

--OBgbd6mrDC4KosUenNHR711UM2l9RrEo9--

--6vg428VdCWaXa6QsLqo84FieNDjBW8osq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJYAfBSAAoJEOQSsVbv84Vas2oQAMCKIIkEXiYjTn8YHgYiI3M/
wR3YRXvjSAjOI7+ghtv2/L/UOppAoWAD3VytwqPx25kX/Ht0bI1grSg7Fzn2an3i
TVQPjYbM6Moe11MfI5r2nFmZK268NOntnKRqCw16yWPjMvS/3f0GclWIWl0YuLUM
EIpMqpXMC2BZRg3/Gfh8/Sr0QQ0OSnlBalPjnDoi7dXcdCu61Mx/Ip2vVcF/tL1I
avwHOXWLyBHKuA2eevm++/+zPXW9F8l3ABYwWV1ljtWxdHwizltT3+uLM31drnum
MxDXuw37zQ58Az74zOEx4HSkQXVdH3lJwRNKT6ZgShMQrwlwh2UZVgfvEbZdsswv
gjI9YWkVj90Ngkh+A9mxbPjG9XFVHPTBppZJslJRtg0OtPYvvWdyyBmuzne4C0hS
HE+2w9A74yazb6px2DIqz4hhUhonC686h2ixhPw27Utpg8pJUwj4D2NMLGNn9Jhc
6ty7NrzpOBE6f5esJKU9sjem2HnIC9mexA2nlq9iiqKNcmBRtZXn9G3zGALCLRBT
coou9J50DI95OUUvxTuoUR5h5dWs+ji7OfEzn2G/+HaZScEB4sqx25WyMH9FMMtr
yKD/gJ6iUDUxE6bhheDbZw8W/+3M0G5M53DP66298Mt0yvcfBJFMIaHk8IjmgaeB
kxTCSlnHacjCNUUhMjlT
=0Nni
-----END PGP SIGNATURE-----

--6vg428VdCWaXa6QsLqo84FieNDjBW8osq--

