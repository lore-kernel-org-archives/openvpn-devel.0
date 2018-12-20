References: <a3b6dcb2-9c04-3001-797f-fa49fccda790@...1879...>
 <d4d4f37c-b5a3-4bf3-361c-ff4ae2e9ec8d@...515...>
 <325823f7-1c48-d86a-fd22-3e8eac2971b6@...1879...>
 <56cdde83-aa02-5b75-beae-629a2d480355@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <bf3f61cf-6ff5-4c24-4878-2c646f704138@...515...>
Date: Thu, 20 Dec 2018 14:45:01 +0200
MIME-Version: 1.0
In-Reply-To: <56cdde83-aa02-5b75-beae-629a2d480355@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fTA1uCtgYkB9tF9tjXgo9tFS6l7MOfRBm"
Subject: Re: [Openvpn-devel] sbuild_wrapper: state of official openvpn
 repository
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Enno_Gr=c3=b6per?= <groepeen@...1879...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fTA1uCtgYkB9tF9tjXgo9tFS6l7MOfRBm
Content-Type: multipart/mixed; boundary="79UVfc1HPOHisTfHkAvIawSJdP2HhOZbR";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: =?UTF-8?Q?Enno_Gr=c3=b6per?= <groepeen@...1879...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <bf3f61cf-6ff5-4c24-4878-2c646f704138@...515...>
Subject: Re: [Openvpn-devel] sbuild_wrapper: state of official openvpn
 repository
References: <a3b6dcb2-9c04-3001-797f-fa49fccda790@...1879...>
 <d4d4f37c-b5a3-4bf3-361c-ff4ae2e9ec8d@...515...>
 <325823f7-1c48-d86a-fd22-3e8eac2971b6@...1879...>
 <56cdde83-aa02-5b75-beae-629a2d480355@...515...>
In-Reply-To: <56cdde83-aa02-5b75-beae-629a2d480355@...515...>

--79UVfc1HPOHisTfHkAvIawSJdP2HhOZbR
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Il 17/12/18 16:17, Samuli Sepp=C3=A4nen ha scritto:
> Il 17/12/18 16:06, Enno Gr=C3=B6per ha scritto:
>> Hi,
>>
>> Am 17.12.18 um 14:29 schrieb Samuli Sepp=C3=A4nen:
>>> Somebody needs to do it. I started the work, but my sbuild_wrapper VM
>>> was too old (Debian 7) and it gave me serious issues with the Ubuntu
>>> 18.04 shcroot. So I decided to upgrade the builder. Then other work
>>> slowed that project down and I haven't been able to really resume it
>>> yet.
>>
>> I'm currently trying with Ubuntu 18.04 as build machine.
>=20
> That should be perfect. My new build VM is Ubuntu 18.04 as well.
>=20
>>> I think I might actually setup a Vagrant environment for
>>> this - we have it for openvpn-build already. That would make it easier
>>> for others to setup the sbuild_wrapper environment and provide
>>> contributions to it. I could do this fairly quickly.
>>
>> I fully agree with that. Currently I'm trying to follow your README and
>> it's not that easy-going.
>=20
> Ok. I will, as a first step, publish a Vagrant VM in
> https://github.com/OpenVPN/openvpn-vagrant that sets up everything
> needed to use sbuild_wrapper. I'll do the provisioning so that I can
> reuse the same code in production. Launching the VM will require
> Virtualbox, at least until somebody is sufficiently motivated to make
> the VM run on something else (e.g. via libvirt).

I added a Vagrant VM called "sbuild" to openvpn-vagrant. Its
provisioning script will fully configure sbuild_wrapper so that you can
just do

$ vagrant ssh sbuild
$ cd sbuild_wrapper
$ scripts/build-all.sh

and you will end up with all the packages under the "output" directory
and in output.tar.gz. The provisioning part will take quite a while to
finish.

The changes that make all of this possible have not, however, been
merged upstream and need review and independent testing:

https://github.com/OpenVPN/sbuild_wrapper/pull/1
https://github.com/OpenVPN/openvpn-vagrant/pull/6

While the provisioning script (sbuild.sh) can be run outside of Vagrant,
it may fail due to minor differences in the base OS.

I'll look into adding Ubuntu 18.04 support next.

>>> Fixed. The CreatingUnixPackages page was truly obsolete.
>>
>> Nice. Since I wasn't sure about the state, I didn't want to change
>> things prematurely.
>>
>> Kind Regards,
>> Enno
>>
>>
>>
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>=20



--79UVfc1HPOHisTfHkAvIawSJdP2HhOZbR--

--fTA1uCtgYkB9tF9tjXgo9tFS6l7MOfRBm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlwbjtEACgkQKVhNn0CG
RXhwLAf+OQpG/Hkq8Mc0MVkKBqa0dK1KqID5KHhxlRCXpo2vkwTIMSztNr8woJHv
9fNDsOic6AM06bF9R9ZIqFfyrkoqWs+n2TVl86RF8BHkDFKLigXBwBf8+FeOhPR2
9xl2gG8yBsPX5WRZgNCaluNmnXLgvvv+honh7CpTc2w5xZCrxS71/Gji8w/PKxri
LN3J7KgWFpCabK9PD7ZDVawI359A0ouBRqvrWfGFFUMnjefSTIJ+LMzueokXd8eU
4F0/4UdkPJ+J1lY5ZCGKjjNQ+CAPT4FzUWdK84UN3hJzZUIqoEhpFLmVR0qSN1/E
WCLK5MzrtiE4Xmh6hsFHGI6iZ+4Ipg==
=RsdR
-----END PGP SIGNATURE-----

--fTA1uCtgYkB9tF9tjXgo9tFS6l7MOfRBm--

