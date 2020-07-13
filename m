Date: Mon, 13 Jul 2020 08:33:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200713063303.GM1431@...1296...>
References: <20200622113022.23047-1-davids@...515...>
 <CAKuzo_g7QxVL90ikT57H6b4+St2c860us6S3cN_6jbfeHujpzw@...278...>
 <a1cfd42d-e371-187a-55c2-f14a3a986b34@...1823...>
 <4562876f-45c1-d3bb-f725-52e9b78600de@...1227...>
 <20200623090252.GE1431@...1296...>
 <4f03e378-f327-21a6-9f11-fe06a42052b6@...1823...>
 <518ceb3d-e060-f777-f19f-4998b8d27170@...1227...>
 <3f6159de-c513-78d5-194c-989a8611c291@...1823...>
 <20200713061023.GK1431@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="s5zy/YTIAL5g/QNz"
Content-Disposition: inline
In-Reply-To: <20200713061023.GK1431@...1296...>
Subject: Re: [Openvpn-devel] git master crashes on connect of 2.3 client
 with --enable-small
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Dmitry Melekhov <dm@...1823...>
Cc: Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--s5zy/YTIAL5g/QNz
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 13, 2020 at 08:10:23AM +0200, Gert Doering wrote:
> Ouch.  This is not good.  My gut feeling is "2.3 with --enable-small =3D=
=20
> no OCC *and* no NCP =3D the server runs across a NULL pointer here".

B=E4m.  Fully reproduceable here

Program received signal SIGSEGV, Segmentation fault.
0x00007ffff7af51be in ?? () from /lib64/libc.so.6
(gdb) where
#0  0x00007ffff7af51be in ?? () from /lib64/libc.so.6
#1  0x00005555555d4a7b in ncp_get_best_cipher (server_list=3D<optimized out=
>,=20
    server_cipher=3D0x5555555f28da "BF-CBC",=20
    peer_info=3Dpeer_info@...1851...=3D0x5555556781c0 "IV_VER=3D2.3.18\nIV_=
PLAT=3Dfreebsd\nIV_PROTO=3D2\n", remote_cipher=3D0x0, gc=3Dgc@...1851...=3D=
0x55555565e070) at ssl_ncp.c:231
#2  0x000055555558f430 in multi_client_set_protocol_options (c=3D0x55555565=
e070)
    at multi.c:1823
#3  multi_connection_established (m=3Dm@...1851...=3D0x7fffffffc550,=20
    mi=3Dmi@...1851...=3D0x55555565deb0) at multi.c:2174
#4  0x00005555555908af in multi_process_post (m=3Dm@...1851...=3D0x7fffffff=
c550,=20
    mi=3D0x55555565deb0, flags=3Dflags@...1851...=3D5) at multi.c:2483
#5  0x0000555555590d32 in multi_process_incoming_link (
    m=3Dm@...1851...=3D0x7fffffffc550, instance=3Dinstance@...1851...=3D0x0=
,=20
    mpp_flags=3Dmpp_flags@...1851...=3D5) at multi.c:2847

I'll see what I find in there...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--s5zy/YTIAL5g/QNz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfDAAfAAoJEB2Cnv7KVigS+RwL/R6gp006ldk+ParQuGwAwn9s
9w0qaTW7ZFbXuP2RnArfhyRyqiwgt7O9S842sG+qAkQ2hM4c2984OJgHIsK0iZeG
/pu3r4NdZt6nc+R4GD/Bm8cSkWUEaUujsiFqd1lTABG8HGeCENMw4CfM1z2Ut30d
Qwhq3HkrdAFJooR7as5Gw0zRNIJFr3O+yAfO5rHQuyJMW4jHal0QrkteYUu5+Tk8
Nrz0NxZsCnI6GVRl17om/imPvxSD+UbOfG267hg3oVJfZstH6vzfmsS3OKQmfy/o
sdirqWro1EditGod1DQPnucjyt0Rf6DF/mURH1rqY7M08KrB3yfTnxiPYaXOgNao
O/oIpdgb7SQVt66ODs19sDsn1sfhP1X+x1RCyYbQj6ci3Euq6OES1Cd1YPNVSKB3
lFETBoDWK7h0az1mvlRjsClha8hUvwjZiPEK6PSAeQup6ip2FL5P8t5KriQy0x9a
iFSVEPq8AxUg4RyvejalNyJyrOoSkubcwYGJHXpW6A==
=JyGi
-----END PGP SIGNATURE-----

--s5zy/YTIAL5g/QNz--

