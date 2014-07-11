Message-ID: <53BFC4E6.9080207@...1921...>
Date: Fri, 11 Jul 2014 13:05:11 +0200
From: Philipp Hagemeister <phihag@...1921...>
MIME-Version: 1.0
References: <53BF9998.5020906@...1921...> <53BFA5AA.4070305@...1147...>
In-Reply-To: <53BFA5AA.4070305@...1147...>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="kStfLtxleJ1JOJlfwLTlPq08Av9x84vJ6"
Subject: Re: [Openvpn-devel] [PATCH] Add topology in sample server
 configuration file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kStfLtxleJ1JOJlfwLTlPq08Av9x84vJ6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

After applying Arne's patch, would you ACK this?

In any case, the default is untouched by this patch. Can you enlist the
"few" critical bugs? I'll document them then on
https://community.openvpn.net/openvpn/wiki/Topology .

Best,

Philipp

On 07/11/2014 10:51 AM, Jan Just Keijser wrote:
> On 11/07/14 10:00, Philipp Hagemeister wrote:
>> On modern systems, topology subnet should always be set, but it's
>> missing in the configuration file.
>> Add it with a short explanation.
> NACK
> There are a few annoying issues with
>   topology subnet
> esp when using server side things like
>   route <remote subnet> <mask>
>=20
> that will *fail* with 'topology subnet' ; until this is fixed this
> should NOT be considered the default.
>=20
> JJK
>=20
>=20
>> Signed-off-by: Philipp Hagemeister <phihag@...1921...>
>> ---
>>   sample/sample-config-files/server.conf | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/sample/sample-config-files/server.conf
>> b/sample/sample-config-files/server.conf
>> index f483b6b..6a2b4c2 100644
>> --- a/sample/sample-config-files/server.conf
>> +++ b/sample/sample-config-files/server.conf
>> @@ -86,6 +86,13 @@ key server.key  # This file should be kept secret
>>   # 2048 bit keys.
>>   dh dh1024.pem
>>
>> +# Network topology
>> +# Should be subnet (addressing via IP)
>> +# unless Windows clients v2.0.9 and lower have to
>> +# be supported (then net30, i.e. a /30 per client)
>> +# Defaults to net30 (not recommended)
>> +;topology subnet
>> +
>>   # Configure server mode and supply a VPN subnet
>>   # for OpenVPN to draw client addresses from.
>>   # The server will take 10.8.0.1 for itself,
>>
>>
>> ------------------------------------------------------------------------=
------
>>
>> Open source business process management suite built on Java and Eclipse
>> Turn processes into business applications with Bonita BPM Community
>> Edition
>> Quickly connect people, data, and systems into organized workflows
>> Winner of BOSSIE, CODIE, OW2 and Gartner awards
>> http://p.sf.net/sfu/Bonitasoft
>>
>>
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20
>=20



--kStfLtxleJ1JOJlfwLTlPq08Av9x84vJ6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTv8TnAAoJENtLVMukgmoYcfIP/3jeXgc1EMxwzYQkn6+8tUse
3cUrZy86l9etnjYxc1uGA4niIPC06nB4Qp7YLOjYdMQ2bHzu819RF2j3C5cIN1Yd
hl9+bP8aklqgUm0EtA/7PpsKMIlLk0HRPSlHtlcBt2tcAdYFcVVk4LWgG+ogjo53
rzmKu/7GK9aUoCNmQ1C4W66njl44e8j2MXhO2avRPK0zlC2FmQIchgSRYs/gUC3b
6uNoj8VRNPy1WCFg1k7+euy7sbYBuIW+yvDgYTbuDdyQwnFbCLeciSWjJs4b6ueK
8tvyFwWK5JD6UMx9pBbsWbi851JqzBQhlFromanlaG6WHVJQOStcdAu6ogllkG6V
iEywec787of28e85CWOvvNOMQxDLwxKA8bK+KLCoZBemhKuCGqvxo12f6EStIbpF
WLHdK2sIkO3a4DDu6U1GFAb2FUWmpY65DR2BRFyWRhmG9a8sESynB7cIG+KumXOp
Be+JhI5xPmvYKWNb714pr4R+maZUNS+yuEAj1bws7fECXVsx1568AP3uScR2MKxj
GiCn7nsqPiTMyEq+Lx6W+sgeLQZHt7q/fMaXNFt85dTQjNXJBlC7hng1p60MN7LH
4vV/qI+0Sy/d8XZJ1ITL1zQsLxsW46mAEtm9nQ5mLFiqwzXFLcpM6CKSPgtr+uBT
mMIPXcEwbaQv3mJ1J8LI
=xgqB
-----END PGP SIGNATURE-----

--kStfLtxleJ1JOJlfwLTlPq08Av9x84vJ6--

