From: Jon Kunkee <jkunkee@...2393...>
Date: Wed, 27 Jun 2018 19:05:17 +0000
Message-ID: <DM5PR2101MB1112C9A57ACD44437ECCFBC7B0480@...2412...>
References: <42bafab6-9e6f-56b5-2c44-b449ec503ce7@...515...>
 <20180611075242.GF57262@...1296...>
 <bb55cab5-2523-b899-0ead-6f34886c4d2b@...515...>
 <DM5PR2101MB1112279487CBA7B6DE9A3ABDB0710@...2412...>
 <20180618205610.GI57262@...1296...>
 <20180618205916.GJ57262@...1296...>
 <DM5PR2101MB11120F3A5F61835EE906C481B0710@...2412...>
 <f7cffd19-6db7-a622-3268-fbb198531387@...515...>
 <DM5PR2101MB1112A510BA8E7FCE6FA1166FB0760@...2412...>
 <20180626191511.GI57262@...1296...>
 <DM5PR2101MB1112FF96189404007097878FB0490@...2412...>
 <a412d044-3a0a-a312-8bc8-0e6114f1e56f@...515...>
 <6a6ad2e7-7390-3ad1-29ad-4c68eaca6e5a@...515...>
In-Reply-To: <6a6ad2e7-7390-3ad1-29ad-4c68eaca6e5a@...515...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256     ; boundary="=-=nldMlY6YfRYgkz=-="
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Regarding tap-windows6 driver signatures and
 driver distribution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?iso-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--=-=nldMlY6YfRYgkz=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

>> Our test environment currently has the following nodes:=20
>>=20
>> - One combined HLK Studio/controller=20
>> - Four identical HLK client nodes=20
>> - OpenVPN test server=20
>>=20
>> The HLK nodes are all Windows Server 2016 as that is our primary target.=
=20
>> The OpenVPN test server provides the HLK clients with an IPv6 address=20
>> and IPv6 gateway - this is required for almost all "Run" tests. All of=20
>> the nodes are in Amazon EC2. With the above setup 54 tests pass and 9 fa=
il.=20

This sounds great.

>> The "Support machine" you mentioned is still missing. I will try to set=
=20
>> it up today and check how many of the currently failing tests start pass=
ing.=20

If the failures look network-topology-related, this should be the missing l=
ink.
The "support machine" should be a second host on the VPN that the HLK serve=
r can
talk to for generating traffic.

If I get access to the HLK machine I'll be inspecting the detailed errors
reported by the failing tests.

> I looked at "LAN Testing Prerequisites" in HLK documentation and it not=20
> entirely clear what is needed:=20
>
> https://docs.microsoft.com/en-us/windows-hardware/test/hlk/testref/lan-te=
sting-prerequisites=20
>
> The document hints thats we would need to have at least one real=20
> physical HLK client with 4 or 8 cores. It is also mentioned that Windows=
=20
> Server Core is needed as well.=20
>
> Anyways, some of these things may not be applicable to us. I guess the=20
> best we can do is go through the test failures individually and see what=
=20
> is happening.=20

Guesswork sucks. :( Maybe I can help a little...

Windows Server 2016 has two installation modes: Core and Desktop Experience.
--=-=nldMlY6YfRYgkz=-=--
