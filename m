References: <e6f1b674-b382-0626-03c8-a20e0fbefc1b@...2080...>
	<1491996924-24576-1-git-send-email-steffan.karger@...1435...>
	<024c8d0b-b82d-4ea2-2445-9c57bf734c83@...1435...>
	<afa63dbb-715c-8775-2ac9-4dbdf0e7aaf5@...2080...>
	<193f3a1c-dab5-f1f1-7ed4-f34740c066a0@...1435...>
	<0f9ad475-2cf0-de38-f6ed-be2389a87947@...2080...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <ac344e5f-988e-9d0c-49a6-a56c6e97871a@...1435...>
Date: Fri, 14 Apr 2017 11:16:21 +0200
MIME-Version: 1.0
In-Reply-To: <0f9ad475-2cf0-de38-f6ed-be2389a87947@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dXN51M8dJeQrViSvrdOPjoCrei4s4EbfX"
Subject: Re: [Openvpn-devel] [PATCH v2] Add --tls-cert-profile option for
 mbedtls builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--dXN51M8dJeQrViSvrdOPjoCrei4s4EbfX
Content-Type: multipart/mixed; boundary="dLtlVgvPi3Bgd9smLdj5FWTTMgfH7PulD";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <ac344e5f-988e-9d0c-49a6-a56c6e97871a@...1435...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add --tls-cert-profile option for
	mbedtls builds
References: <e6f1b674-b382-0626-03c8-a20e0fbefc1b@...2080...>
	<1491996924-24576-1-git-send-email-steffan.karger@...1435...>
	<024c8d0b-b82d-4ea2-2445-9c57bf734c83@...1435...>
	<afa63dbb-715c-8775-2ac9-4dbdf0e7aaf5@...2080...>
	<193f3a1c-dab5-f1f1-7ed4-f34740c066a0@...1435...>
	<0f9ad475-2cf0-de38-f6ed-be2389a87947@...2080...>
In-Reply-To: <0f9ad475-2cf0-de38-f6ed-be2389a87947@...2080...>

--dLtlVgvPi3Bgd9smLdj5FWTTMgfH7PulD
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 13-04-17 18:40, David Sommerseth wrote:
> On 13/04/17 15:37, Steffan Karger wrote:
>> On 13-04-17 15:09, David Sommerseth wrote:
>>> On a more generic note to this patch.  I wonder if we should keep
>>> "legacy" the default in the v2.4 branch.  In the Fedora 26 (and
>>> Rawhide/27) builds I had to do something similar [1] to keep users
>>> happy.  As OpenVPN isn't ready for OpenSSL v1.1, I had to switch to mbed
>>> TLS.  Unfortunately that haven't been as successful as I really hoped it
>>> would be, but that's an entirely different story (and mail thread).  As
>>> long as the Fedora builds need to be built with mbed TLS, I will need to
>>> ensure 'legacy' is the default there for a while.  For the coming Fedora
>>> Rawhide (which will be F28), I can make some announcements preparing
>>> users to move to stricter defaults.
>>>
>>> [1]
>>> <http://pkgs.fedoraproject.org/cgit/rpms/openvpn.git/tree/0001-workarou=
nd-Allow-weaker-RSA-keys-and-MD-algorithms-i.patch?h=3Df26>
>>
>> The current mbed TLS builds already reject legacy crypto (except the
>> fedora packaged build, apparently).  With this patch users have the
>> ability to use legacy stuff again, but I would prefer to not go any
>> further than that.  I think we should encourage people to drop the
>> legacy.  Just like the browser vendors are doing.
>=20
> I do agree.  But the pain as a package maintainer is quite noticeable
> when you're getting complaints about configurations this breaks.  In
> fact, I got quite some dissatisfied remarks even for moving from 2.3 to
> 2.4 on the OpenSSL builds (F25 + EPEL) - as that also broke some setups
> - mostly due to our option parser now doesn't ignore configuration
> errors any more or we actually implement the dual stack IPv4/IPv6
> properly on the transport side.
>
> [..snip..]
>=20
>> And for Fedora, they chose to experience intense pain when they chose to
>> go for OpenSSL 1.1 this fast, that's their problem I guess...  If they
>> want to be that cutting edge, they should also stop using legacy crypto.
>>  And otherwise, it will be a simple patch in the fedora packaging.
>=20
> Well, they do make things move forward fast.  And they do a lot of work
> to get upstream projects moving towards OpenSSL 1.1.  As there is a
> major Fedora release roughly every 6 months, it is a fast moving target.
>=20
> But Fedora users as side, they know each major release is a huge step
> forward in many areas.  For most OpenVPN users, regardless of OS or
> distro, they are used to the more sloppy legacy crypto support of
> OpenSSL.  So enforcing a stricter set of crypto parameters in OpenVPN
> v2.4 only on mbed TLS seems a bit odd to me.

I agree - which is why I plan to add similar behaviour to the OpenSSL
builds.  I'm convinced by the argument to better aligning OpenSSL and
mbed TLS behaviour, so I agree that we should default to 'legacy' as
long as the OpenSSL counterpart is missing.

Do you prefer a v3?

The thing I still don't buy is that we have to jump through hoops
because Fedora pushes openssl 1.1 (even though 1.0.2 is fine and
supported and all), but we have to keep enabling deprecated crypto *by
default* that people should not be using anymore, and can easily
re-enable with a --enable-old-cruft flag if they really want to.

-Steffan


--dLtlVgvPi3Bgd9smLdj5FWTTMgfH7PulD--

--dXN51M8dJeQrViSvrdOPjoCrei4s4EbfX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJY8JNlAAoJEEEwndWOY1w5G1wH/3dWsaj7TXWGLOH5kdqfiplm
EltNWt/kgBaWKBg0PjxyMUN+dprjmzSmH7LZzygobTr5DjJou7hj9IjL1ex5Sa8h
ZlHUlk4te6yih2NbX9kmkP/BRBj4tts2lOxOVnGjZrgsbbhB5hWNNdPc7Qq21Trm
J7V1t4PWzjG7iC4QIv9rKpnF5YO6n343BxMZYmA75aYLIWIB9Ey/pjAymux+14+O
LJ0eKVox4taxCyOTfCwW1CVD1e7+f4JQx6ppiWm6IhEnjBk39AVITwx3DiHjJ3wF
iYmjFWKqslJY7yY9T1jd3XMakNmHFMkAUCjX8zmU2/bfBvfrIa1KwwIQfIvDUS4=
=/F4G
-----END PGP SIGNATURE-----

--dXN51M8dJeQrViSvrdOPjoCrei4s4EbfX--

