Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
From: Cyril Scetbon <cyril.scetbon@...260...>
In-Reply-To: <fe1c465a-b9d7-df65-b19c-19384c40b84b@...1227...>
Date: Thu, 22 Nov 2018 10:17:07 -0500
Message-Id: <139CFC1C-3260-458B-BF2B-05251A6F1906@...260...>
References: <11098166-9909-4011-83F9-C5BC3FEA769D@...260...>
 <20181122092047.GS962@...1296...>
 <DFA3F418-5C5E-46F6-A39B-9CF5D76F2EE9@...260...>
 <fe1c465a-b9d7-df65-b19c-19384c40b84b@...1227...>
Subject: Re: [Openvpn-devel] foreign_option_2 not set in 2.4
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
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Weird cause I was sure I had this error in 2.3 too. But I tried again and I=
 don=E2=80=99t get it. So I guess you=E2=80=99re right =E2=80=A6
I can=E2=80=99t really do anything as the server's config is out of my cont=
rol =E2=80=A6
Any idea on how to fix it other than by changing the server=E2=80=99s confi=
guration ?

> On Nov 22, 2018, at 9:43 AM, Arne Schwabe <arne@...1227...> wrote:
>=20
> Am 22.11.18 um 14:46 schrieb Cyril Scetbon:
>> OpenVPN 2.4.6 x86_64-alpine-linux-musl [SSL (OpenSSL)] [LZO] [LZ4]
>> [EPOLL] [MH/PKTINFO] [AEAD] built on Jul  8 2018
>>=20
>> Output with =E2=80=94verb 4 https://pastebin.com/huQmnGaU=20
>>=20
>=20
> Read your log closer. This is not a bug in OpenVPN but rather a broken
> config what we accepted in 2.3:
>=20
> Thu Nov 22 13:34:56 2018 us=3D235164 PUSH: Received control message:
> 'PUSH_REPLY,route 10.0.0.0 255.0.0.0,route 192.168.174.0
> 255.255.255.0,route 193.252.149.32 255.255.255.224,route 193.252.121.96
> 255.255.255.224,dhcp-option DNS 10.201.67.120,dhcp-option DOMAIN
> cyril.net cyril2.net,route 10.252.12.150,topology net30,ping
> 5,ping-restart 30,ifconfig 10.252.12.158 10.252.12.157'
>=20
> Thu Nov 22 13:34:56 2018 us=3D235314 Options error: Unrecognized option or
> missing or extra parameter(s) in [PUSH-OPTIONS]:6: dhcp-option (2.4.6)
>=20
> OpenVPN gets 'dhcp-option DOMAIN cyril.net cyril2.net' via push and
> using two arguments after DOMAIN is wrong but OpenVPN 2.3 ignored the
> second argument while 2.4 gives you an error and ignores the whole option.
>=20
> Arne
>=20


