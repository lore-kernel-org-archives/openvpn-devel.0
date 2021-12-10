Date: Fri, 10 Dec 2021 16:08:25 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YbNtaWgZi/8MAyJW@...1296...>
References: <20211201180727.2496903-1-arne@...1227...>
 <20211210130651.3623725-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3oXTdofTO0wKr1Hw"
Content-Disposition: inline
In-Reply-To: <20211210130651.3623725-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 7/9] Remove cipher_kt_t and change
 type to const char* in API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--3oXTdofTO0wKr1Hw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 10, 2021 at 02:06:51PM +0100, Arne Schwabe wrote:
> Patch v3: fix errors with mbed TLS without having md_kt to const char * p=
atch
>           also applied, fix logic inversion in tls_crypt_tk

Thanks, this is much better than v2 - now all client-side tests pass
that led to "openvpn exiting" previously, or SIGSEGV'ing.

*BUT* - it totally fails to work on a connection that negotiates BF-CBC,=20
though, both with mbedTLS 2.27.0 and with OpenSSL 1.1.1l - I did not see
it in the client side tests first (because I only ran a limited subset),
but it is easily triggered by connecting to a 2.3 server, requiring
fallback to BF-CBC.

It also fails all server side tests that end up in trying to use BF-CBC
(long e-mail cut short).

Most notable indication is: with an older binary, I get these lines
in the log:

2021-12-10 15:53:14 us=3D406619 cron2-freebsd-tc-amd64-24/194.97.140.21:401=
61 Outgoing Data Channel: Cipher 'BF-CBC' initialized with 128 bit key
2021-12-10 15:53:14 us=3D406645 cron2-freebsd-tc-amd64-24/194.97.140.21:401=
61 WARNING: INSECURE cipher (BF-CBC) with block size less than 128 bit (64 =
bit).  This allows attacks like SWEET32.  Mitigate by using a --cipher with=
 a larger block size (e.g. AES-256-CBC). Support for these insecure ciphers=
 will be removed in OpenVPN 2.6.

which are totally missing (!) for master + 7/9v3.


On further study, this is not so much "NCP" failing here, but "BF-CBC",
I think.  If I call up a client with "--data-ciphers BF-CBC", I see
on the server

2021-12-10 16:00:25 us=3D273260 194.97.140.21:42770 peer info: IV_VER=3D2.6=
_git
2021-12-10 16:00:25 us=3D273293 194.97.140.21:42770 peer info: IV_PLAT=3Dfr=
eebsd
2021-12-10 16:00:25 us=3D273307 194.97.140.21:42770 peer info: IV_CIPHERS=
=3DBF-CBC
2021-12-10 16:00:25 us=3D273322 194.97.140.21:42770 peer info: IV_PROTO=3D30
...
2021-12-10 16:00:25 us=3D283465 Outgoing Data Channel: Using 160 bit messag=
e hash 'SHA1' for HMAC authentication
2021-12-10 16:00:25 us=3D283527 Incoming Data Channel: Using 160 bit messag=
e hash 'SHA1' for HMAC authentication
2021-12-10 16:00:25 us=3D283561 WARNING: cipher with small block size in us=
e, reducing reneg-bytes to 64MB to mitigate SWEET32 attacks.
2021-12-10 16:00:25 us=3D283622 SENT CONTROL [cron2-freebsd-tc-amd64]: 'PUS=
H_REPLY,route 10.204.0.0 255.255.0.0,route-ipv6 fd00:abcd:204::/48,tun-ipv6=
,route 10.204.2.0 255.255.255.0,topology net30,ping 10,ping-restart 30,comp=
ress lz4,ifconfig-ipv6 fd00:abcd:204:2::1000/64 fd00:abcd:204:2::1,ifconfig=
 10.204.2.6 10.204.2.5,peer-id 0,cipher BF-CBC,key-derivation tls-ekm' (sta=
tus=3D1)

... but it is also never initializing BF-CBC for the data channel...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--3oXTdofTO0wKr1Hw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhs21pAAoJEB2Cnv7KVigSaVML+gOgj3ntLQDCFPOoQrEY4+2X
t/TgsWHeujW8+AmrnfKhA+5PuMVvXs4XWFLh0oX2q3ij60aBQWGZAg9KnTLFnHCU
G5j8uO7ABceFvJhP+Ff7XI9GFOf1mlAW6XTJvgMi6YlJdLSAhU7yCEndMfRnRFby
GmUOw0CHl2dqIR+nbYis0d+vel5WTq20df2PSpr+cTDZ4lmsuDrUkwfXlQQYhN3m
v4T9AbdY66nOzY+W4AAIh2Z30v2QwguI+uajBkIyVjX4piht0h7NoppKFBjPHREI
hKniHQW2QKaF2JSWnu7pogbZlYWy4zJIrDdtGMWueFbt5wyzPL2LObigpwRe0dqk
P7IqU13GI6HsU/qiHp/D/WkZjbChiQw9zcs40ZdsO/43dwMDahDlQLtAWhJq4y5H
Z8FJQE7zF3hbnA4DNPDqgQ4q6ZZ1Ytaoi8HISpxaPRUsCUNHdh1R8aFJVmTnF+oD
0Fac0vDLNK0GMVwVWVR6Et3NTd0hhUlY5hGa2NkUlg==
=Xi7+
-----END PGP SIGNATURE-----

--3oXTdofTO0wKr1Hw--

