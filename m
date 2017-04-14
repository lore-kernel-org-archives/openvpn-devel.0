References: <e6f1b674-b382-0626-03c8-a20e0fbefc1b@...2080...>
	<1491996924-24576-1-git-send-email-steffan.karger@...1435...>
	<024c8d0b-b82d-4ea2-2445-9c57bf734c83@...1435...>
	<afa63dbb-715c-8775-2ac9-4dbdf0e7aaf5@...2080...>
	<193f3a1c-dab5-f1f1-7ed4-f34740c066a0@...1435...>
	<0f9ad475-2cf0-de38-f6ed-be2389a87947@...2080...>
	<ac344e5f-988e-9d0c-49a6-a56c6e97871a@...1435...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <3275c6bd-8194-2e23-2e64-3d3fd5d2f090@...2080...>
Date: Fri, 14 Apr 2017 14:37:09 +0200
MIME-Version: 1.0
In-Reply-To: <ac344e5f-988e-9d0c-49a6-a56c6e97871a@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bktXwLg2GIhXeTxnjfGMcWqRoQTeMXEUf"
Subject: Re: [Openvpn-devel] [PATCH v2] Add --tls-cert-profile option for
 mbedtls builds
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bktXwLg2GIhXeTxnjfGMcWqRoQTeMXEUf
Content-Type: multipart/mixed; boundary="2XCHvmLEDON84Omrx2uqfmPT1EdoBw7fD";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan.karger@...1435...>,
	openvpn-devel@lists.sourceforge.net
Message-ID: <3275c6bd-8194-2e23-2e64-3d3fd5d2f090@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add --tls-cert-profile option for
	mbedtls builds
References: <e6f1b674-b382-0626-03c8-a20e0fbefc1b@...2080...>
	<1491996924-24576-1-git-send-email-steffan.karger@...1435...>
	<024c8d0b-b82d-4ea2-2445-9c57bf734c83@...1435...>
	<afa63dbb-715c-8775-2ac9-4dbdf0e7aaf5@...2080...>
	<193f3a1c-dab5-f1f1-7ed4-f34740c066a0@...1435...>
	<0f9ad475-2cf0-de38-f6ed-be2389a87947@...2080...>
	<ac344e5f-988e-9d0c-49a6-a56c6e97871a@...1435...>
In-Reply-To: <ac344e5f-988e-9d0c-49a6-a56c6e97871a@...1435...>

--2XCHvmLEDON84Omrx2uqfmPT1EdoBw7fD
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 14/04/17 11:16, Steffan Karger wrote:
> Hi,
>=20
> On 13-04-17 18:40, David Sommerseth wrote:
>> On 13/04/17 15:37, Steffan Karger wrote:
>>> On 13-04-17 15:09, David Sommerseth wrote:
>>>> On a more generic note to this patch.  I wonder if we should keep
>>>> "legacy" the default in the v2.4 branch.  In the Fedora 26 (and
>>>> Rawhide/27) builds I had to do something similar [1] to keep users
>>>> happy.  As OpenVPN isn't ready for OpenSSL v1.1, I had to switch to mb=
ed
>>>> TLS.  Unfortunately that haven't been as successful as I really hoped =
it
>>>> would be, but that's an entirely different story (and mail thread).  As
>>>> long as the Fedora builds need to be built with mbed TLS, I will need =
to
>>>> ensure 'legacy' is the default there for a while.  For the coming Fedo=
ra
>>>> Rawhide (which will be F28), I can make some announcements preparing
>>>> users to move to stricter defaults.
>>>>
>>>> [1]
>>>> <http://pkgs.fedoraproject.org/cgit/rpms/openvpn.git/tree/0001-workaro=
und-Allow-weaker-RSA-keys-and-MD-algorithms-i.patch?h=3Df26>
>>>
>>> The current mbed TLS builds already reject legacy crypto (except the
>>> fedora packaged build, apparently).  With this patch users have the
>>> ability to use legacy stuff again, but I would prefer to not go any
>>> further than that.  I think we should encourage people to drop the
>>> legacy.  Just like the browser vendors are doing.
>>
>> I do agree.  But the pain as a package maintainer is quite noticeable
>> when you're getting complaints about configurations this breaks.  In
>> fact, I got quite some dissatisfied remarks even for moving from 2.3 to
>> 2.4 on the OpenSSL builds (F25 + EPEL) - as that also broke some setups
>> - mostly due to our option parser now doesn't ignore configuration
>> errors any more or we actually implement the dual stack IPv4/IPv6
>> properly on the transport side.
>>
>> [..snip..]
>>
>>> And for Fedora, they chose to experience intense pain when they chose to
>>> go for OpenSSL 1.1 this fast, that's their problem I guess...  If they
>>> want to be that cutting edge, they should also stop using legacy crypto.
>>>  And otherwise, it will be a simple patch in the fedora packaging.
>>
>> Well, they do make things move forward fast.  And they do a lot of work
>> to get upstream projects moving towards OpenSSL 1.1.  As there is a
>> major Fedora release roughly every 6 months, it is a fast moving target.
>>
>> But Fedora users as side, they know each major release is a huge step
>> forward in many areas.  For most OpenVPN users, regardless of OS or
>> distro, they are used to the more sloppy legacy crypto support of
>> OpenSSL.  So enforcing a stricter set of crypto parameters in OpenVPN
>> v2.4 only on mbed TLS seems a bit odd to me.
>=20
> I agree - which is why I plan to add similar behaviour to the OpenSSL
> builds.  I'm convinced by the argument to better aligning OpenSSL and
> mbed TLS behaviour, so I agree that we should default to 'legacy' as
> long as the OpenSSL counterpart is missing.
>=20
> Do you prefer a v3?

I think it's needed to improve some details in the man page and
Changes.rst.  Perhaps also extend the man page to state that
--tls-cert-profile is currently a NOOP builds against OpenSSL?

For git master (future v2.5) I have no issues having 'preferred' being
the default.  And we need to start announcing that things will be
stricter in v2.5 already now.   But for v2.4 I think we should go for
'legacy' as the default.

> The thing I still don't buy is that we have to jump through hoops
> because Fedora pushes openssl 1.1 (even though 1.0.2 is fine and
> supported and all), but we have to keep enabling deprecated crypto *by
> default* that people should not be using anymore, and can easily
> re-enable with a --enable-old-cruft flag if they really want to.

Fedora was just an example of what was needed to avoid a rebellious
revolution against the package maintainer.  But it illustrates the
trickiness of pushing such changes too quickly to a user base.  Hence,
how I see it, for the whole OpenVPN user base regardless of OS/distro,
to have legacy being the default for v2.4 users.  Which also aligns well
with the default chosen for the OpenVPN 3 user base (which includes all
OpenVPN Connect users).

But be sure, I think we need to move towards 'preferred'.  But doing it
in a good way for all.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--2XCHvmLEDON84Omrx2uqfmPT1EdoBw7fD--

--bktXwLg2GIhXeTxnjfGMcWqRoQTeMXEUf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY8MJ/AAoJEIbPlEyWcf3ypbsP/0y7k/BhOKf1yfQ9zAP2fIyV
zu7K6GzmLoyKKLopvzdQNGO7pPSdreAdpqbrPB2RJ0raK6DJbU1IN2om5gzgCRVo
Fo0vnilRTA1sK0Ts5skDELpPBfOU1IGZ/+ckUS6zAdhl5ldBdqhR/nfcM3aafQ0N
f8EKACgAz6WIadamZLvR0WhqnIxLyZ4GWSnDViYMrN5y7GcXC7WYDNnrzlvZQQDk
jYWJW/g+z6VN0du5VZvC6l8sZQ63AT0ciztAnjuyFCrquEIw6iNPB4uyKQq/xQ/R
5ipYHgXL/9HL6VnxqbqFUvpvDXIwORNqjGpIVaMqO0MJc+3GxZ54c3pZvg8kIh4W
xQw2qCDdF7ynq4H9CJhLucjIBtkSsTBA/tZsQWi+t1YJD3zeq1uufGZKL8TtIJEo
9hjnSUKxrgl8efHA49lDvpv893jrFxR5lv8DgEeMgrLXg7mp5GRPQm2ujjz5v2Jr
3FKMt+lrM23bWikMkFcbRnINwvP07tj20MrzegdzFz8TJniwDqoLpJvC22At1see
cjyO0Dd9c2PW5D5Se85Aqa0e8n3WWYQv4UXQSPgnoQEgU8SM9PglFIRuiDmw18cV
gVdVIKV/rIEcO/yxsNVjpnmdfI6HAsLb0e530SUrZAg307hLBO4sjnViU7gYPDYB
q/zhrty92mJ8oh+wuxA2
=ILHl
-----END PGP SIGNATURE-----

--bktXwLg2GIhXeTxnjfGMcWqRoQTeMXEUf--

