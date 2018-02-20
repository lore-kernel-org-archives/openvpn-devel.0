Date: Tue, 20 Feb 2018 16:48:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180220154812.GA69696@...1296...>
References: <1509930876-30728-1-git-send-email-selva.nair@...277...>
 <1516815105-17882-1-git-send-email-selva.nair@...277...>
 <2f187b23-c53f-94cb-6a58-d5c9c14b5da1@...1147...>
 <663a0e1d-0d21-6f40-851e-78d770bec68f@...1147...>
 <CAKuzo_i4Ge=3cbg3zZY61ps+wDi8eCC1M4dopNJKGoB-LmT0Qw@...278...>
 <cba28408-81d0-5295-c882-f4bfdfcc20c3@...1147...>
 <CAKuzo_gCvfSYi+u4XJd88te-B_XbW1AkEQ3LxsuHaAH29EDVrw@...278...>
 <20180220143502.GL69387@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20180220143502.GL69387@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v3] Use lowest metric interface when
 multiple interfaces match a route
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Jan Just Keijser <janjust@...1147...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 20, 2018 at 03:35:02PM +0100, Gert Doering wrote:
> Jan Just, could you please test the following patch?  This will explicitly
> clear the host bits for the "on-link" route again.
>=20
> Fully untested :-)

And indeed, it does not link, because route_ipv6_clear_host_bits() isn't
exported from route.c

A proper patch that is actually compiling and has been tested on Win7
will be coming soon (in a new thread, so patchwork can properly pick=20
it up).

Win7 seems to ignore the extra host bits on route removal, so I cannot
"see" the actual *error* - but I can see whether or not the netsh.exe
invocation is correct, which is good enough to test whether the fix
is working.

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJajEM7AAoJEB2Cnv7KVigSJhMMALCC1VmcV7XRw0ZwFddwfIDn
QR5TqaHLpQ8h8Q6AfrBxPT6OiCp2fAoWXSYT1XusJQm5oEwIWCtMbatQSJHFfShT
JrAi8MyEggrBf6DMKXNsLwg9PzAl91l0bHfjx0W38Ww1SMKAh/kXa1xeQz+AQzpr
m2QruPFL6vwxbWB2l04v5MXgVbj/8Rv2vPudLyiaxouA4ErGIq7D4eUyA1eB4PSB
qOJ85YIBLzDrJM67yQ37uwfw12Qht1oeLx9wjJgOwdGn4l8XNekVIC8GpuNGD56b
i+5tqWA7aUaAb3eVKy5yLniTn6GJW8Km8RFgwnj3k533WrRSblomXZ9fm8N9S3VC
k4xpB3JRXADHdJXqx2hmROpWNBL1LvkuZ3M01fBVw0yyTAgyn+xyoVgaojZ+ZxIP
lPWuMo+SiN32U6P/oLdxmLLik8eUa8e1W9N/P26FH2Y0gM1r/lVJQBoAkT0a7v3R
sg5QATJSeCSGZLkvtB48jPikYtNuLa8ADVXNKJR6XA==
=kuly
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--

