Reply-To: openvpn-devel@lists.sourceforge.net
References: <1496177444-18373-1-git-send-email-steffan@...1856...>
	<29f51139-a525-fd92-0fe1-195d308d2924@...2080...>
	<20170531070258.GC97029@...1296...>
	<ae93b702-4edd-6772-0f1d-ac9629589ee8@...2080...>
	<20170531092817.GH97029@...1296...>
	<7bb03bbe8955dacd3a3130f64724024f.squirrel@...2257...>
	<8fb2b96f-67c8-73ba-3dfd-13ddce59b599@...2080...>
	<b18b1487fb12a6eb6b4ccb7c7f6ca517.squirrel@...2257...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f3799853-eece-2f39-dd81-333f1b681297@...2080...>
Date: Fri, 2 Jun 2017 11:02:38 +0200
MIME-Version: 1.0
In-Reply-To: <b18b1487fb12a6eb6b4ccb7c7f6ca517.squirrel@...2257...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HDFa3DuvL6LkIM2RmlMj8vLGPIpdTCLPI"
Subject: Re: [Openvpn-devel] [PATCH release/2.4] configure.ac: fix building
 against static openssl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HDFa3DuvL6LkIM2RmlMj8vLGPIpdTCLPI
Content-Type: multipart/mixed; boundary="o2k4sOAQ2PVCXtNXe4bi3vPEM4lEWRJDB";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Simon Matter <simon.matter@...2249...>, openvpn-devel@lists.sourceforge.net
Message-ID: <f3799853-eece-2f39-dd81-333f1b681297@...2080...>
Subject: Re: [Openvpn-devel] [PATCH release/2.4] configure.ac: fix building
 against static openssl
References: <1496177444-18373-1-git-send-email-steffan@...1856...>
 <29f51139-a525-fd92-0fe1-195d308d2924@...2080...>
 <20170531070258.GC97029@...1296...>
 <ae93b702-4edd-6772-0f1d-ac9629589ee8@...2080...>
 <20170531092817.GH97029@...1296...>
 <7bb03bbe8955dacd3a3130f64724024f.squirrel@...2257...>
 <8fb2b96f-67c8-73ba-3dfd-13ddce59b599@...2080...>
 <b18b1487fb12a6eb6b4ccb7c7f6ca517.squirrel@...2257...>
In-Reply-To: <b18b1487fb12a6eb6b4ccb7c7f6ca517.squirrel@...2257...>

--o2k4sOAQ2PVCXtNXe4bi3vPEM4lEWRJDB
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 31/05/17 17:48, Simon Matter wrote:
[...snip...]
>>
>> Do you depend on building against OpenSSL 0.9.8?  If so, which
>> OS/distribution do you use?
>=20
> Yes, I have a case with very customized CentOS 5 systems where we also
> backport security related patches.=20

Well, officially we no longer support RHEL 5 or older as of v2.4.
AFAIR, we even agreed late last year when getting ready for the 2.4
release that we won't intentionally break 2.4 builds on unsupported
distros but we will not bother supporting it when we want to move forward.

It is good you take care of backporting security related patches.  But
wanting the OpenVPN community to maintain new OpenVPN releases buildable
on those old distros is effectively shifting that responsibility over to
the OpenVPN community.

Had the v2.5 release been in the pipe for the next 6-7 months or so,
then I would be more easily persuaded to let v2.4 keep support for
openssl-0.9.8 around.   But the reality is that we don't currently have
a release plan for v2.5.

> Of course the same could be done for openvpn but it's easier to just
> follow the current 2.4 stream.=20
Right, having others doing your work is always the easiest path for
yourself ;-)

> That's why my suggestion to keep all the compat hacks in 2.4.x and
> kick them out only in the main devel branch.

Which is really speaking against what was the agreement when the 2.4
release started to take shape late last year.

But AFAIR, there also exists compat-openssl10 in RHEL5.  Which could
resolve this issue for you.

> I guess that's what most package maintainers expect to happen and
> it keep mailing lists quiet

Most package maintainers wants to have as little work as possible while
providing the latest and greatest to their users.  But how that is
achieved is primarily the package maintainer's responsibility.

We as a the upstream project will strive to make life as easy as
possible for package maintainers, but not at any cost.

I further encourage you to read chapter 6.9 in the Quarklabs security
audit [1].  Their recommendation is:

    "We thus recommend suppressing these workarounds and to return an
     error during compile time if the OpenSSL version is too old. Only
     versions 1.0.2 and further should be satisfactory."

Also have in mind that this audit is performed against the v2.4 code base.

So when we're having 1.0.1e as the oldest supported OpenSSL version (as
that is what RHEL6 and RHEL7 ships and gets security fixes), I think
that enforcing v2.4 to comply to this strengthens the overall security
in OpenVPN.

If package maintainers want to run OpenVPN v2.4 on older OS/distro
releases with older OpenSSL libraries, then that is their own decision
and they need to take care of the additional work themselves.  Insisting
on upstream OpenVPN developers to make package maintainer's life easy
and disregarding recommendations from security auditors at the same time
is at best a fairly ignorant attitude.

And in practicality, package maintainers will then need to revert the
two commits which removes support for older OpenSSL versions.


[1] <https://ostif.org/wp-content/uploads/2017/05/OpenVPN1.2final.pdf>


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--o2k4sOAQ2PVCXtNXe4bi3vPEM4lEWRJDB--

--HDFa3DuvL6LkIM2RmlMj8vLGPIpdTCLPI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZMSm3AAoJEIbPlEyWcf3ybc4P/iza6wCGguo0zegWoFLC88hg
KIEtTyVOsHxGBCtIZ7ZJMHdJWkgvSYjAZ3x6MUWPLcWhMSC3Wmh3dUiZAGjxBKn/
9O9WKb01nOmmjvjyeRsUebdu7sGNlsLvuqQS9+8oldClsXP+qXS0QWtDBdH1GFdU
8o+18AW7+bkDnzQSZ/x/PlEivhT+F5m7IkF5viEDqvfxj3W7eJryMnk7Czwbth9g
Zu7gGp51lXIVgrdaifSVMk3Tya1rN19Tf8LFBc24N2m3idMs69v7A/2bptBOd9cX
0IvAfG4qJtOCoKldlVY8E14eCDnkAjxonE3k3n7MQ6g3xOPKwcKsVbSS/E+8DxE8
uBQe1vJKKmN/Kb9ZYaX0sAYcMz0LlnJPfqNS3q/EFvF1Ud4LA5Iiwf9h1Gruj/z6
VjdPdyxRuxuuNdgyKsgLXgOMJKfkT5xTieZTzTeJVTy3xGFvL6W/tMXHuPo09ZCE
6Lkv/n9+7/6W+Wa9QD38U3QwuaH2vGUHOe6YJcfPKJhJl4i+SU+3+KlG+dMDB1/j
9NeQXVEWqvOuVGYWGvpi4geUBAtBrRPpsyY4EvumwZc6kmjTJnwrxsyDEWdku+pD
tHqzCdsx9tnzQFBDHg4kOAYRd4vtj5amKeyKULnUJJvw4AQgxsqPm2v+fK2RG3oP
8BvjSEwWoDhajcPkgJAp
=+d+r
-----END PGP SIGNATURE-----

--HDFa3DuvL6LkIM2RmlMj8vLGPIpdTCLPI--

