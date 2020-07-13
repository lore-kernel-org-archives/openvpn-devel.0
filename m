From: Marvin Adeff <volleynbike@...277...>
Mime-Version: 1.0 (1.0)
Date: Mon, 13 Jul 2020 07:23:59 -0700
Message-Id: <6B6A4240-A4F4-4388-BD1D-ABF049535351@...277...>
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
 <9b4e2c49-8ef4-efb6-0b04-c273b077dc70@...1227...>
In-Reply-To: <9b4e2c49-8ef4-efb6-0b04-c273b077dc70@...1227...>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

I=E2=80=99m wondering if the opposite of this scenario has been tested, whe=
re the server is running 2.3.18 (on Linux) and a client running 2.5 (on Win=
dows) tries to connect?

I know, I know, we should upgrade.  Unfortunately in this case OpenVPN serv=
er is running on an appliance that cannot be upgraded past Linux 2.6, and I=
 don=E2=80=99t think 2.4.x can run on Linux 2.6.=20

Marvin=20


Sent from my iPhone

> On Jul 13, 2020, at 1:57 AM, Arne Schwabe <arne@...1227...> wrote:
>=20
>> Am 13.07.20 um 08:58 schrieb Gert Doering:
>> Hi,
>>=20
>>> On Mon, Jul 13, 2020 at 08:33:03AM +0200, Gert Doering wrote:
>>>> On Mon, Jul 13, 2020 at 08:10:23AM +0200, Gert Doering wrote:
>>>> Ouch.  This is not good.  My gut feeling is "2.3 with --enable-small =
=3D=20
>>>> no OCC *and* no NCP =3D the server runs across a NULL pointer here".
>>>=20
>>> B=C3=A4m.  Fully reproduceable here
>>>=20
>>> Program received signal SIGSEGV, Segmentation fault.
>>> 0x00007ffff7af51be in ?? () from /lib64/libc.so.6
>>> (gdb) where
>>> #0  0x00007ffff7af51be in ?? () from /lib64/libc.so.6
>>> #1  0x00005555555d4a7b in ncp_get_best_cipher (server_list=3D<optimized=
 out>,=20
>>>    server_cipher=3D0x5555555f28da "BF-CBC",=20
>>>    peer_info=3Dpeer_info@...1851...=3D0x5555556781c0 "IV_VER=3D2.3.18\n=
IV_PLAT=3Dfreebsd\nIV_PROTO=3D2\n", remote_cipher=3D0x0, gc=3Dgc@...1851...=
=3D0x55555565e070) at ssl_ncp.c:231
>>=20
>> ... and this is why (added a msg() call):
>>=20
>> 2020-07-13 08:36:59 us=3D802772 ncp_get_best_cipher(), peer_ncp_list=3D,=
 tmp_ciphers=3DAES-256-GCM:AES-128-GCM:AES-128-CBC:AES-192-CBC:AES-256-CBC,=
 remote_cipher=3D(null), server_cipher=3DBF-CBC
>>=20
>> if "remote_cipher" is NULL (=3D no OCC) we pass that to "strcmp()", and =
that
>> does not want it.
>>=20
>>=20
>> Returning NULL from ncp_get_best_cipher() if there is nothing the client
>> has to offer works fine, though it triggers this warning
>>=20
>> 2020-07-13 08:43:01 us=3D483904 cron2-freebsd-tc-amd64-23/194.97.140.21:=
30927 PUSH: No common cipher between server and client.Expect this connecti=
on not to work. Server ncp-ciphers: 'AES-256-GCM:AES-128-GCM:AES-128-CBC:AE=
S-192-CBC:AES-256-CBC', client supported ciphers ''
>>=20
>>=20
>> which we might want to reword for this case ("No information about ciphe=
r=20
>> support received from client, cannot ensure correct operation" or so).
>>=20
>> Patch appended.
>>=20
>> Comments?
>=20
>=20
>=20
>=20
> +                }
> +                else
> +                {
> +                    msg(M_INFO, "PUSH: No cipher info received from
> client "
> +                        "(no NCP and no OCC).  Cannot ensure
> compatibility.");
> +                }
>                 gc_free(&gc);
>=20
>=20
> This is misleading. peer_chipers =3D=3D "" only says that the peer does n=
ot
> send IV_CIPHERS/IV_NCP.  I think I would rather do something change the
> message to:
>=20
>=20
>    msg(M_INFO, "No NCP data received from peer, falling back to --cipher
> '%s'. Peer reports in OCC --cipher '%s'", o->ciphername,
> np(tls_multi->remote_ciphername));
>=20
>=20
> This avoid adding another if else for now. And yes for clients without
> occ you get that annoying warning in the log but that is okay.
>=20
>=20
> Otherwise ACK.
>=20
> Arne
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

