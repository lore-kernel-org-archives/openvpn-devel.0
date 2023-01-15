Date: Sun, 15 Jan 2023 13:25:56 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y8Pw1FLbvnFNdefs@...1296...>
References: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
 <CAFHpkQF4dtn0DV-nHMeUfowA2EszAscpbMVeGk6boiXYhWc5Kw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rBORokFt8n41PFxp"
Content-Disposition: inline
In-Reply-To: <CAFHpkQF4dtn0DV-nHMeUfowA2EszAscpbMVeGk6boiXYhWc5Kw@...278...>
Subject: Re: [Openvpn-devel] Amend OpenVPN license to allow continued mbed
 TLS support (allow mbed TLS 3.x linking)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rBORokFt8n41PFxp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jan 15, 2023 at 06:21:21PM +0600, ???????? ?????????????? wrote:
> I am fine with dropping MBED TLS for good

This is not the question asked.

For the record: I am fine with the proposed change of license.

(I think this is all a tremendous waste of time, but since sufficient
number of licensing lawyers say "linking GPL2 with something that has
additional restrictions and shipping the result is not legal" *and*
mbedTLS can not be considered a system library anywhere, as in "it
will be always there if you install that system" - like a libc - it's
either this or drop mbedTLS support)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--rBORokFt8n41PFxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjw/DUAAoJEB2Cnv7KVigSf6AL/0h/yNsXC5ASrnRr5uPO4Y4B
Jm6l8JQtX45D5NOV5t8shQ6FCynLd/+ywlxv0jgMm2lypPcu/LJbfQ/NUVVJ41cV
0upQXJ0LR0aBAh8aj3Qk0Z+dOoWyE15jSqr64AwW/FeHinn2Ht5OIXBv39qDSdF2
Oc5l1WqXeErSv5mt7YUluDuyL7xWmchWlCo8hd7ASGwgOlPf1wA9tAm8/MH7pG1x
+erW9PJJcRloY8bJUzge1GRzAqXPwyIcPMWlTUVBEo47O5jegX1RSfVIzRctkymE
uk8bIGRtI6XaY8EaDHeEl+eGXoSjEFZVntGGx9+fX0OJ6yK5rN2RaXvbOnZ8h0to
N46nKMJ6fPtYFtBL3t59dEMuaKa/y3VzBJI0L1cg4PabzWsxbXGHyoo8R9izEfJ4
TTbDXFOZNV4sCGjc31jPKAl9h0aWIG04sZFT5Q1TpPKDMiJR9moOxnokSxeWSkeG
naZv0ULQ3FpIlAM79wXi4nt7AQivoRk6khdS4rtTdA==
=J1YI
-----END PGP SIGNATURE-----

--rBORokFt8n41PFxp--

