Date: Tue, 5 Jun 2018 20:40:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180605184024.GO57262@...1296...>
References: <CAJY0qZKNO_aamQfi56BG_XK2vrOCyPAQf-My1N56qqV7TsUG7A@...278...>
 <eaae68e6-e30d-f63b-59c5-64515c8f8bcd@...1147...>
 <e4a2d28a-ff8d-4797-e0af-3bcf98828cb3@...1856...>
 <CAJY0qZKw+HgQ1vS-W13nw2=gj8d-uxeOqyZia4-gEbaGNTyFLQ@...278...>
 <03a13b39-7b85-0b67-cc94-7b219e6b209f@...1147...>
 <49b53be0-a301-8447-2a0e-0534435e5e87@...1147...>
 <CAJY0qZ+_kEVS_41oOHNX=Wp47LnNhL0HKRZvR75eg7JNW3tLkQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5cSRzy0VGBWAML+b"
Content-Disposition: inline
In-Reply-To: <CAJY0qZ+_kEVS_41oOHNX=Wp47LnNhL0HKRZvR75eg7JNW3tLkQ@...278...>
Subject: Re: [Openvpn-devel] Does the OpenVPN protocol itself handle
 windowing?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Derek Zimmer <derek@...2095...>
Cc: Jan Just Keijser <janjust@...1147...>, openvpn-devel@lists.sourceforge.net

--5cSRzy0VGBWAML+b
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 05, 2018 at 10:23:29AM -0500, Derek Zimmer wrote:
> OpenVPN in UDP mode is still operating a TCP windowing layer=20
> somewhere, right?=20

Not for data packets - they get sent off as they come in from the=20
tun file descriptor and vice versa.  No pacing (unless configured),=20
no windowing, no retransmits.

Of course the OS' TCP layer still applies, but that one *should* not
scale (much) worse via tun than via direct IP.

In any case it's good to see people (who are not me) interested in
performance measurements, and performance improvements.  You can't
improve what you do not understand, and you can't understand what
you do not measure...  (yes, I studied physics as well :) ).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--5cSRzy0VGBWAML+b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbFtkYAAoJEB2Cnv7KVigSyjUL/3H5sfWJNHO7lEHoRI4NH8Nn
MBlMAwLMK/pfB5diuyEeRX+46AONQX20T1wblvOL6yNrdg1GCCn9jR74CUVlmpAA
gxku7S15y3EqpQ1ylincvuM88FYNP7bCoypkVd3bdpeu1MyEB+Pi4XbU3Xj28U6e
3ND3LoadQ/VHeNcE9fy3Xdb2udCU1lTs0iwH+661v3lf6MyhOkTEuOtS3HbKYVhh
3Wfxs6w8uUHU9WQe/PbL1RA3mZ/WsIgNmcN7CkmYm+z2Jkb/cA6bGMIIM9KX5rD1
vTSelKQcdIFoKK3pFPJ0FlIuf5UuwcKS2yfDhyeAHGo/Cuup72V9J/wVYmSRyAl5
mkcw9euwOgc2KbsleCRR0VUvxbHKaqez5UIOdEEawNuB37/1mE8Cf/iR1gd3IeWN
k4Fvz7MYzEDzuPRY/eygxXRl8vSTjskbyWtGDdArbjPEu/p7at5/07xfeCgZqG4W
SxunmJ5grfA0OKZABEeKie/zcG8S/8dEUdamrywHkg==
=lutP
-----END PGP SIGNATURE-----

--5cSRzy0VGBWAML+b--

