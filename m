References: <20200622113022.23047-1-davids@...515...>
 <CAKuzo_g7QxVL90ikT57H6b4+St2c860us6S3cN_6jbfeHujpzw@...278...>
 <a1cfd42d-e371-187a-55c2-f14a3a986b34@...1823...>
 <4562876f-45c1-d3bb-f725-52e9b78600de@...1227...>
 <20200623090252.GE1431@...1296...>
 <4f03e378-f327-21a6-9f11-fe06a42052b6@...1823...>
 <518ceb3d-e060-f777-f19f-4998b8d27170@...1227...>
 <3f6159de-c513-78d5-194c-989a8611c291@...1823...>
 <20200713061023.GK1431@...1296...> <20200713063303.GM1431@...1296...>
 <20200713065828.GN1431@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <9b4e2c49-8ef4-efb6-0b04-c273b077dc70@...1227...>
Date: Mon, 13 Jul 2020 10:57:48 +0200
MIME-Version: 1.0
In-Reply-To: <20200713065828.GN1431@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XAaEP9XaH1tBCaCjqsVlFPoUw4Ve9mt4t"
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
To: Gert Doering <gert@...1296...>, Dmitry Melekhov <dm@...1823...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XAaEP9XaH1tBCaCjqsVlFPoUw4Ve9mt4t
Content-Type: multipart/mixed; boundary="bSOlzqN5d5y2A0lLNIsI9jsgyuRcT5ukz"

--bSOlzqN5d5y2A0lLNIsI9jsgyuRcT5ukz
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 13.07.20 um 08:58 schrieb Gert Doering:
> Hi,
>=20
> On Mon, Jul 13, 2020 at 08:33:03AM +0200, Gert Doering wrote:
>> On Mon, Jul 13, 2020 at 08:10:23AM +0200, Gert Doering wrote:
>>> Ouch.  This is not good.  My gut feeling is "2.3 with --enable-small =
=3D=20
>>> no OCC *and* no NCP =3D the server runs across a NULL pointer here".
>>
>> B=E4m.  Fully reproduceable here
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> 0x00007ffff7af51be in ?? () from /lib64/libc.so.6
>> (gdb) where
>> #0  0x00007ffff7af51be in ?? () from /lib64/libc.so.6
>> #1  0x00005555555d4a7b in ncp_get_best_cipher (server_list=3D<optimized =
out>,=20
>>     server_cipher=3D0x5555555f28da "BF-CBC",=20
>>     peer_info=3Dpeer_info@...1851...=3D0x5555556781c0 "IV_VER=3D2.3.18\n=
IV_PLAT=3Dfreebsd\nIV_PROTO=3D2\n", remote_cipher=3D0x0, gc=3Dgc@...1851...=
=3D0x55555565e070) at ssl_ncp.c:231
>=20
> ... and this is why (added a msg() call):
>=20
> 2020-07-13 08:36:59 us=3D802772 ncp_get_best_cipher(), peer_ncp_list=3D, =
tmp_ciphers=3DAES-256-GCM:AES-128-GCM:AES-128-CBC:AES-192-CBC:AES-256-CBC, =
remote_cipher=3D(null), server_cipher=3DBF-CBC
>=20
> if "remote_cipher" is NULL (=3D no OCC) we pass that to "strcmp()", and t=
hat
> does not want it.
>=20
>=20
> Returning NULL from ncp_get_best_cipher() if there is nothing the client
> has to offer works fine, though it triggers this warning
>=20
> 2020-07-13 08:43:01 us=3D483904 cron2-freebsd-tc-amd64-23/194.97.140.21:3=
0927 PUSH: No common cipher between server and client.Expect this connectio=
n not to work. Server ncp-ciphers: 'AES-256-GCM:AES-128-GCM:AES-128-CBC:AES=
-192-CBC:AES-256-CBC', client supported ciphers ''
>=20
>=20
> which we might want to reword for this case ("No information about cipher=
=20
> support received from client, cannot ensure correct operation" or so).
>=20
> Patch appended.
>=20
> Comments?




+                }
+                else
+                {
+                    msg(M_INFO, "PUSH: No cipher info received from
client "
+                        "(no NCP and no OCC).  Cannot ensure
compatibility.");
+                }
                 gc_free(&gc);


This is misleading. peer_chipers =3D=3D "" only says that the peer does not
send IV_CIPHERS/IV_NCP.  I think I would rather do something change the
message to:


	msg(M_INFO, "No NCP data received from peer, falling back to --cipher
'%s'. Peer reports in OCC --cipher '%s'", o->ciphername,
np(tls_multi->remote_ciphername));


This avoid adding another if else for now. And yes for clients without
occ you get that annoying warning in the log but that is okay.


Otherwise ACK.

Arne


--bSOlzqN5d5y2A0lLNIsI9jsgyuRcT5ukz--

--XAaEP9XaH1tBCaCjqsVlFPoUw4Ve9mt4t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8MIgwACgkQFRhsZwKx
RFTzMw/9E/rcTQZ5xAnK24v3icggG0J9kPejA129kQrpMExuQ8VIUgomLw2Evfn7
GHf7gXIitc+JoOFmrHGvoZXTwfnfxdkByUT6Wr1oYZi+4b5fmJS0e+0RgD7HDPNM
WolOVoHpHHPGmZfm/M2xfjXYTaCwpjkOnOJtVvQDVGuIt4gfvCE1VptdbUcQd2RY
ClT0NzlqFY7ekue2GdyWgTYdOg0E1cP4ZgPr1q7EW89eo6OXltgga2wrqKt3etzK
aKYjL8lhNDl/nteDxC9dh2Pon2wEeH4zAxpJmsX6/XtBNi7QmZL61ZOiBkDbfiHo
mDV1EUSmOCs0DXQLkvLnvsUA5jImco4QmIGwtgASYOYH0/zs4lE8QNR2FnIVL/y0
uKGyd6TcEJxHVl3nYa9KVVAw0SabJq0dx7zX+W3s6dePEW6ryBBiS2w3zS7iq13U
acwVJe1yc85WFisAssb3LgAdzXfZsDwOey/Q6Xern34XrMKromVHD4f8dWo+8rl2
vM8wpjVPeHGqLwX7ViJRNlopfj2rECrs9a1g6Vvrz/9xyNf+RjKLxXXB3fyL8+Yk
afEeCQ7YqS/JhSrjWBOhpb84sU6A+9ksPJ7e2Qv8bxVrb5EafBzcAVJffTzi41x/
jRXapRcXLMpX9nx5ajVUYC2HpDJD609TwEXluhZrny7NZlw5rbk=
=CwfW
-----END PGP SIGNATURE-----

--XAaEP9XaH1tBCaCjqsVlFPoUw4Ve9mt4t--

