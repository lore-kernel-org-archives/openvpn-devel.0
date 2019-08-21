Date: Wed, 21 Aug 2019 21:09:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190821190925.GP1349@...1296...>
References: <CAL3L06G=w44OuBMUbV1YJSZ9vKb5oJOkwDbCMjPH3ALFSP+cXw@...278...>
 <E1i0R6j-0007v3-4M@...2479...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="yhze8HlyfmXt1APY"
Content-Disposition: inline
In-Reply-To: <E1i0R6j-0007v3-4M@...2479...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] Start TLS after connection
 established without waiting.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

--yhze8HlyfmXt1APY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 21, 2019 at 03:56:50PM +0200, Steffan Karger wrote:
> While this sounds like something we'd like to have (i.e, feature-ACK),
> this doesn't really explain why this change resolves the issue, nor why
> this is the right fix.

As a bit of background why I assume this will fix "things" - we have a
few places in the connection sequence where we do something, and when
it's finished, set up a coarse timer to "go on with the next step" -
which always means "1 second delay" because that's how the coarse
timers work.

I've dug into this a bit when figuring out commit afb93fac803fbab7 -
which helped a bit (this was setting up an "in 1 second" coarse timer,=20
which always got an extra second due to scheduling), but I'm sure there
is more room for improvement.

OTOH this is all tricky code, with client and server and tcp and udp
all intermixed.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--yhze8HlyfmXt1APY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdXZblAAoJEB2Cnv7KVigSYqQMAJWd2yAP00uj/oDP51HcXVmu
wsSgtuxkjVuCfNhgbCzd63TWK7PVVceh59DHYhCrELCQRJC+qmHstkcGEbDsd33a
goywz1efnkdyeVooiF1X4um1wiVWdY7pe7QX/FtyGjZZuu9sF1yz2cyfkdeBd1q+
KMafej59HXmEwHPSC1kTpsJsYSWJV0uGpx6LpYmlA+gUjfbK0gx2EBX1aKx7qRVe
/33QSkwIDFi//WcL57GLQCzuhBHmvsxfNrGOtfa2d172Qb5k2orDqyVhv6OicqFH
0fO54r36HEvVnP3z9nVjTMvE534wDEdymJu4MzYBSH9rC5wNwzG1y8H7DfiO87B1
Ia1DEpZyJFTA/98j+/kepsC6JBTYI4YR6FCaCeDIFFfgKRAfonOeXrDdtlzVyQTe
HKKJ/THWHMYzDqkkbBz+g289uD3mT625kzRHWX68C/gjCFMp4vsqV8Y0sKhxH7jt
xxyBazr/2P09ILGmfLNJ3DsaodoAd2DWQIB0gXgELQ==
=0ZsA
-----END PGP SIGNATURE-----

--yhze8HlyfmXt1APY--

