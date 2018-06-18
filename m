From: Jon Kunkee <jkunkee@...2393...>
Date: Mon, 18 Jun 2018 21:56:07 +0000
Message-ID: <DM5PR2101MB11120F3A5F61835EE906C481B0710@...2412...>
References: <42bafab6-9e6f-56b5-2c44-b449ec503ce7@...515...>
 <20180611075242.GF57262@...1296...>
 <bb55cab5-2523-b899-0ead-6f34886c4d2b@...515...>
 <DM5PR2101MB1112279487CBA7B6DE9A3ABDB0710@...2412...>
 <20180618205610.GI57262@...1296...>
 <20180618205916.GJ57262@...1296...>
In-Reply-To: <20180618205916.GJ57262@...1296...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256     ; boundary="=-=geBuWE2axUjA7B=-="
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
To: Gert Doering <gert@...1296...>
Cc: =?iso-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--=-=geBuWE2axUjA7B=-=
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

 Hi Gert,

>>> Our projected deadline for the next tap-windows6 release is June 
>>> 20th. 
>>
>> Is this still the target? 
>
> No, we moved it to (tentatively) June 27th.  There was some sort of 
> major outage of Samuli's Infrastructure which took too much time to 
> fix. 

Ouch for Samuli.

My motivation is simple: The Microsoft partner that asked for this port
wants to know ASAP when it's released so they can tell people about it.
That said, as long as I get the final release date to them promptly
they can deal with whatever ends up happening.

Thanks for the update!

> The goal is to have the 3 ARM64 related PRs plus the version number PR 
> merged after a bit of smoketesting on other platforms

Wonderful.

Samuli, let me know if you think I can help.

> Most likely this release will be "get things out with compromises" - 

This makes sense, no worries. It's already a fairly complex release.

> Then, focus on make nicer installers - .msi for the tap driver, .msi 
> for openvpn proper, return to *one* driver that has proper signatures 
> for everything. 

I'll take a closer look at WIX support for ARM64. This timeline is easier to
work with.

Cheers,
Jon

--=-=geBuWE2axUjA7B=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEQ6s+QnGone4JL4whoCohEJkRnX4FAlsoKmwACgkQoCohEJkR
nX6crw/9EBqwKo79RkI0bUE7NJD5W6hrjtP5tMALXFcMUmtn0j3RztqhF+he4XIR
izkYyIMOzTsJbynWzmKQSoWtmmLyMlDr2J+VpyFOAkDYMponAlyd2OmIaWHHpxLq
KQ9uzdywSSHYhmX2x2KOKmciW8l1w1U0O0nymmuIE/r1hmEk6UzZ1stc5hk54jAj
t3/6XBGz/7A1OIIXtHvkRvWpLrO6lzyJQGoNVpBYN3SrIvjJtGk1MvLjyOF1/dT7
VlIluOgbfJ4Gb9DTSEJCrQARDrNyZC9GYAKst2BiWZhHaLskate2RwjrzUcpDEHC
JtEw1n9dSKbWILKkoE+WFQz7Q3/6e+2XaReIo54NjBBXO5cPV1xfjQkPVVTKQWWA
XmlH/UBtNAGNJkh1Lvvp+QWGjEqU7/DNfTLaiIlAEKHxD28fHECvgjXtgt2DJhRD
AP1cZ9gfQTpj3FX2BSynIaIO8CbfdYojC5YxtJaHTzQwJYXw9nz/1B86o2CbZeo7
5XFKf0F5VGAtIrQP9qGanlKFiDMtPAkMJtjfPz9B3MAIA8TIKEDPzr2Q/Pj0vr7u
H2UnH/GGMvfhaoTglmEDx1D8a6t08FYBh9cs3GqhRBISomoljcxRl5H1VTzrP4yE
v9E4jlGDbF3VPWEPb/Fg8KILQ26PINBK5+er72up4+Am0JRdrvo=
=R7A/
-----END PGP SIGNATURE-----


--=-=geBuWE2axUjA7B=-=--

