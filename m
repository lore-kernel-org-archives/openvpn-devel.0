References: <20200903114455.29341-1-themiron@...2010...>
 <0ec2c2a7-61d5-69c6-76a4-af83c283c64c@...2080...>
 <020d01d68612$75dbca00$61935e00$@gmail.com>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <4c221e26-be61-cda4-32a0-7350e7f0be2f@...2080...>
Date: Wed, 9 Sep 2020 19:49:11 +0200
MIME-Version: 1.0
In-Reply-To: <020d01d68612$75dbca00$61935e00$@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="LB6k75b3KVTogeR5Aw29S83CfAx7vpWt5"
Subject: Re: [Openvpn-devel] [PATCH] Fix --remote protocol can't be set
 without port argument
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladislav Grishenko <themiron.ru@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LB6k75b3KVTogeR5Aw29S83CfAx7vpWt5
Content-Type: multipart/mixed; boundary="SNyogX5Q9FDUeA4ul9lYpqw4lBT76oBZ1";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Vladislav Grishenko <themiron.ru@...277...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <4c221e26-be61-cda4-32a0-7350e7f0be2f@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Fix --remote protocol can't be set
 without port argument
References: <20200903114455.29341-1-themiron@...2010...>
 <0ec2c2a7-61d5-69c6-76a4-af83c283c64c@...2080...>
 <020d01d68612$75dbca00$61935e00$@gmail.com>
In-Reply-To: <020d01d68612$75dbca00$61935e00$@gmail.com>

--SNyogX5Q9FDUeA4ul9lYpqw4lBT76oBZ1
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 08/09/2020 21:01, Vladislav Grishenko wrote:
> Hi David,
>=20
>> -----Original Message-----
>> From: David Sommerseth <openvpn@...2080...>
>> Sent: Tuesday, September 8, 2020 6:23 PM
>> To: Vladislav Grishenko <themiron@...2010...>; openvpn-
>> devel@lists.sourceforge.net
>> Subject: Re: [Openvpn-devel] [PATCH] Fix --remote protocol can't be set =
without
>> port argument
>>
>> On 03/09/2020 13:44, Vladislav Grishenko wrote:
>>> According client-options.rst additional argumets ``port`` and
>>> ``proto`` are both optional and it's allowed to have port absent and pr=
otocol
>> set:
>>>     --remote args
>>>       Examples:
>>>          remote server.example.net tcp
>>>
>>> But when protocol is set without preceeding port argument, it is being
>>> misparsed as a port with subsequent error:
>>>     RESOLVE: Cannot resolve host address: server.example.net:tcp
>>>     (Servname not supported for ai_socktype)
>>>
>>> Since protocol names are predefined and don't match service names, fix
>>> this behavior by checking second argument for valid protocol first.
>>>
>> Uhm ... I'm leaning towards a NAK to this patch and would rather suggest
>> updating the man page to be correct.  This is a mistake from my side when
>> converting the man page to .rst files.  The example should be:
>>
>>        remote server.example.net 1194 tcp
>>
>=20
> Hum. Initially all variants were supported, by checking numeric port and
> taking it as proto, if not numeric. Later port became string servname and
> optional logic was lost.

The man page history disagrees ... even though, it doesn't say this order is
explicit.

2.4 - <https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage#lbAG>
2.3 - <https://community.openvpn.net/openvpn/wiki/Openvpn23ManPage#lbAG>
2.2 - <https://community.openvpn.net/openvpn/wiki/Openvpn22ManPage>
2.1 - <https://community.openvpn.net/openvpn/wiki/Openvpn21ManPage#lbAG>

> Man pages still has all of them since that time:
>> 	remote server.exmaple.net
>> 	remote server.exmaple.net 1194
>> 	remote server.exmaple.net tcp

These lines comes from this commit:
<https://github.com/OpenVPN/openvpn/commit/f500c49c8e0a77ce665b11f6adbea402=
9cf3b85f>

Where the last line (missing port number) is incorrect.

I also don't see any commit changing the "remote" parsing in options.c in t=
he
way you describe.  This section has just few changes over the years, but ev=
en
back to changes 7-12 years ago, the second argument has always been process=
ed
as a port number and the third one protocol.  Both causing an error if it is
not a valid value.  So putting protocol in the second argument would trigger
an error in 2.1, 2.2, 2.3 and 2.4 as far as I can see.

>=20
> At first look there is no need for proto w/o port set,  why it can be
> important? With support of server host & port discovery (DNS SRV RFC 2782=
),
> port info is not required, only host and protocol make sense. So I though
> about this one little step forward toward ~consistent syntax. Does it mak=
es
> any sense?
I don't see why OpenVPN's --remote parsing needs to comply with DNS SRV RFC
standards.  How is that related at all?  I know we have patches for adding =
DNS
SRV query support, but that doesn't imply passing this information via
add_option(), does it?

If you use --remote vpn.example.com --proto tcp .... that will already work.
What will not work is --remote vpn.example.com tcp

Also, this will work in config files:
-------------------------------
port 5000
proto udp

<connection>
remote vpn1.example.com
</connection>
<connetion>
remote vpn2.example.com
proto tcp
</connection>
-------------------------------

All of these use cases makes sense, as it depends on a pre-set value.  What
does not make sense to me is to muddy a pretty clearly defined argument ord=
er
which has been the standard since the beginning of OpenVPN.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--SNyogX5Q9FDUeA4ul9lYpqw4lBT76oBZ1--

--LB6k75b3KVTogeR5Aw29S83CfAx7vpWt5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfWRWXAAoJEIbPlEyWcf3y7NUQAJt9yYdyVx6FM6x401+XmxSp
eSHIZPpCEcVXnviGP9BQEE/zUEHFEHTQ6dmNrNCuHR9D6LxOUhnPAp2drUms1/HK
ifrUufxjR4eESrv1+N5lv9m7ZSaJbuIEsmcjOqiMrQaGJm8/OwCrGBbUHONXnsQW
rxBPZEI3y157jjkAEi96EPssAP7PsPBM0kK8Wh3eqCnMpe/I6NHc1azTCpUiu644
W5cYibcgsaFCnH+2Iap5LFN9FpKUmpKtfBlzJ8Os4BckquEIa1LnCy0sO5pbh3SR
hOgp0Srcw8DwhVFiKQcvUvsH2otqOXODpKQpOEAqieWVSeVk3ROTLAVOetWTmr9U
5zey23LEAthOqNyf6mVikJ3WHzcsYfzingyS5TcjJEdeKDdgsrblTJ1cjBlEIg7c
bIPz/RqDImhJucv5Jc+ByzzsKU18HOk9awvXJLS5mwrhyAdL1mKXMwbSw4R4LBsY
FW+pD0H6vFhVcRxDvYVJSEbz3A4+ZeCdDv/CPZWVOJZ5srBqdBhy0hrDcs8raftK
BtWO2F1cY5/ErmpZglpFO4KAP/Y2qkEY0/+G1uIMM1+dDFsuGXhZ31S1++gDD9pt
FKR+7Z/dCt7/71vHdyXZbw+sY8C2iFSnC4tjhFsDIuV2FggdWNLMebJNaX2+EiXe
dpcaINEmv4ehFMt84EJl
=LCXu
-----END PGP SIGNATURE-----

--LB6k75b3KVTogeR5Aw29S83CfAx7vpWt5--

