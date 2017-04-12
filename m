References: <20170411173133.18060-1-davids@...515...>
	<429bda10-5a65-785f-661e-f4ae2708349f@...1435...>
	<050f70e9-1558-a354-ea36-8b786f0af086@...2080...>
	<dd084b32-6e96-b9d0-9477-9fcff9c4a7df@...68...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <6c164552-40f6-f039-c829-03653ef9b26d@...2080...>
Date: Wed, 12 Apr 2017 11:17:57 +0200
MIME-Version: 1.0
In-Reply-To: <dd084b32-6e96-b9d0-9477-9fcff9c4a7df@...68...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="t606DqhoEls4hqnksGEtc61a2KaJwKCDn"
Subject: Re: [Openvpn-devel] [PATCH] Require minimum OpenSSL 1.0.1
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t606DqhoEls4hqnksGEtc61a2KaJwKCDn
Content-Type: multipart/mixed; boundary="s85tVtdCSUa0hUotgkor0BnKJmt80td80";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Matthias Andree <matthias.andree@...68...>,
	openvpn-devel@lists.sourceforge.net
Message-ID: <6c164552-40f6-f039-c829-03653ef9b26d@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Require minimum OpenSSL 1.0.1
References: <20170411173133.18060-1-davids@...515...>
	<429bda10-5a65-785f-661e-f4ae2708349f@...1435...>
	<050f70e9-1558-a354-ea36-8b786f0af086@...2080...>
	<dd084b32-6e96-b9d0-9477-9fcff9c4a7df@...68...>
In-Reply-To: <dd084b32-6e96-b9d0-9477-9fcff9c4a7df@...68...>

--s85tVtdCSUa0hUotgkor0BnKJmt80td80
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 12/04/17 03:06, Matthias Andree wrote:
> Am 11.04.2017 um 23:56 schrieb David Sommerseth:
>> On 11/04/17 23:20, Steffan Karger wrote:
>>> For release/2.4: I wonder whether we need to keep 0.9.8 support, as
>>> SLES11 still ships with 0.9.8h, and has general support until 31 Mar 20=
19.
>> While it is James who insisted on RHEL being the oldest supported distro
>> many years ago, I have no issues with keeping SLES *or* RHEL as the
>> oldest supported distro, in regards to package dependencies.
>>
>> Do we know if we have a large group of SLES 11 users?  Initially I
>> thought it was related to OpenVPN-NL ... until I recalled that
>> OPenVPN-NL should be built against mbed TLS :)
>=20
> How many of the enterprise users will want to update and then can't be
> bothered to install a newer OpenSSL into /opt?
> Older OpenSSL versions are EOL, I don't think the community edition
> should waste any energy on support such stuff. I'd even discontinue
> 1.0.1 support on master for the same reason because 1.0.1 is also past
> the end of its life.

On Enterprise Linux (at least RHEL and SLES), OpenSSL 1.0.1 *is*
supported by the distro.  I can't speak for SUSE, but I know for a fact
that Red Hat have people ensuring important OpenSSL issues are
backported and fixed during the life time of RHEL.  So on RHEL 5,
OpenSSL 0.9.8 was even fully supported and updated all up until March
31, 2017.  But it isn't supported by the OpenSSL community.

And the packaging side of side-loading libraries into /opt will also be
a complete mess.  *EL distributions are updated continuously for at
least 7-10 years.  Those basing their environment on these distributions
will not be bothered manually maintaining an /opt based OpenSSL version;
what will happen is that they make it run once and forgets to update it
until OpenVPN installs breaks again.  And if the OpenVPN package
maintainer need to maintain an /opt based OpenSSL package on-top of that
and to ensure /usr/sbin/openvpn picks the right OpenSSL version ....
nah, that's not going to fly well.

So as long as the *EL distributions keep their OpenSSL packages updated
and backports fixes ... I see no reason why we shouldn't leverage on
their work.  At least for RHEL, every RPM update goes through several QE
steps, where regression testing happens for a lot of known issues in
addition to package install/upgrade/downgrade/uninstall tests.  So the
long-term package stability should be reasonably high.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--s85tVtdCSUa0hUotgkor0BnKJmt80td80--

--t606DqhoEls4hqnksGEtc61a2KaJwKCDn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY7fDRAAoJEIbPlEyWcf3ytlAP/06/SpL+agbhcxlDvYmdKOEI
ZTK0M+9YSB2jiMqlxUpaznfeG2RywdPVG1tn6Na0SkpSU3su/jtRFDjhfq6LQ1n0
++qhmBiUTcrLZJuFSVtsigyAbhXu4Gh1phJyd/3cuwj88W5B6jCYjr8Q0iIXEOgu
kZd0g0W/lZVumy3o/jsDy81mNN65JpNSnyOhiqqOPPE8POAKthSNE+lonJ0LJ/cH
9/VGAtz4HkaV99aIU2vTzFWSIbRpnBz//TjbbMVtjaJ+1JcJ95PUkr1ZGTor4+Bt
Rgso48N46kMxRcj0SsHJDq7asllG+10StQFf5M/rrC5fMwzBhethkb/KmEQUY2ff
Zi7oauUD/LCs4gpP7QFZU79+5/6/8kaZrbmwBvP+yE6xwYQP8fP/tpaboh0fA3zN
R2Zx2JfglPwo3l69KfCN5gTP3bMbPSdl934Mg3nBtqMsxEt4q3IlYDbAIuIsRapr
l4LyAIAjpb8hqZ41nz+/DbKAgz5nDdHwTmFo5QB6zC6HCRMBUkPot9CxnD/6ky/H
WwyAxoiGFSWpSgaIQJWO1uzoQxULgnkIzSPu6nY/4QvJY7rP2VnWM7xRzyl035tf
qOjKk50VjjJheeK3uTUDaHfVR2nvpBzDuokqdRogHtbdrDlu+seWfUJk9eJTt6na
YwqObce6UeneU9HeBAN9
=hoZD
-----END PGP SIGNATURE-----

--t606DqhoEls4hqnksGEtc61a2KaJwKCDn--

