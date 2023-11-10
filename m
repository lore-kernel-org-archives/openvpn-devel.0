Date: Fri, 10 Nov 2023 08:21:24 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZU3Z9AOkQRmPFmWJ@...1296...>
References: <13E5C41C-8358-4252-A751-8FDA9EE95B7D@...2722...>
 <0acc8d93-6175-4d7e-a39a-269a9652ac3e@...1823...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ExVu5lCQrJ3urL3R"
Content-Disposition: inline
In-Reply-To: <0acc8d93-6175-4d7e-a39a-269a9652ac3e@...1823...>
Subject: Re: [Openvpn-devel] OpenVPN 2.6.7 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Dmitry Melekhov <dm@...1823...>
Cc: openvpn-devel@lists.sourceforge.net

--ExVu5lCQrJ3urL3R
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 10, 2023 at 10:21:35AM +0400, Dmitry Melekhov wrote:
> 10.11.2023 00:56, Yuriy Darnobyt ??????????:
> > The OpenVPN community project team is proud to release OpenVPN 2.6.7.
>=20
> something is broken in 2.6.7. it stops passing traffic after several seco=
nds
> after connection when acts as server,

Anything in the logs, when running with --verb 4?  Is this UDP or TCP?  Are
you using --fragment?

I ran the full server side test setup here, and all tests pass - now,
these are only running ~15 seconds per client connect, so might have
overlooked something... just to be sure, I've run a 15-minute ipv4/ipv6
ping test to a UDP server now, and that succeeded just fine.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ExVu5lCQrJ3urL3R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJlTdn0AAoJEB2Cnv7KVigSYMkL/2jQaGVgiA2oyqKeLU/Xlv/n
XskBwKC6siqhMeLM02DOD+G7/X3XFIir2eQ4wbu6+J+ApyfWyRv2ieR6TNA3O6iO
gIwuMvYDyG67hHQKNleQM4SD7RT/Wyw6Bu44M1z8r29TDhZ75MKhIavxXISHJFIx
gEEj95CJh1KUXGABRuKZPARMyY//iRkpw+D7PcHnAaoU9lRva3etAk5EScG3668F
xLP1ji7x6cZteYLuwQ0nqNj5WI+bLoTfkjUvJuDk5wWEhI9gKwU3tzkaFIroZwDF
1t48fRzCUefZkQdMZT7s6taVr9XF0VtFnhXPXwAqpRmY+IcsPzF63OXfiNrzKLpL
x2FlhC0CaUqTwTaLnCNGKwHuv7nPeBZRrXf0IQEoaEc1TOSTzIiAEMCBf61hNeay
nkO3/zdWGsCM2BQFaEYZX5F9ziqTXI2OCK1lzGIobxZ7Zsy0nrlSpXnQDjZH+VGN
dXDteKb1LSguZZlw/y2Uf8hgfnbXXebIzUoWcUIh6w==
=0gZ7
-----END PGP SIGNATURE-----

--ExVu5lCQrJ3urL3R--

