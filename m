References: <e79eb6bd-87bb-a8f7-eda6-e65b33addd24@...277...>
	<0440d93b-6ded-9efc-8fba-838b4e954261@...515...>
	<a4da2c12-b6ba-08c8-9de3-4ef127aafe3e@...2080...>
	<20170323031127.GB24725@...2182...>
	<59bf8d07-476f-bdb7-611d-154bdc4a1bbf@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <e971bbd2-8d2f-3b70-fc4a-5c44fc9350e6@...2080...>
Date: Thu, 23 Mar 2017 12:48:04 +0100
MIME-Version: 1.0
In-Reply-To: <59bf8d07-476f-bdb7-611d-154bdc4a1bbf@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TOJ1g0jGeg9s2KIoK4UXhxNgQWpro2B24"
Subject: Re: [Openvpn-devel] Consider git tags for I60x
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TOJ1g0jGeg9s2KIoK4UXhxNgQWpro2B24
Content-Type: multipart/mixed; boundary="bj3KN6M4tOIVCmUxiv5oSm79lCGVVIo4w";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
	Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Message-ID: <e971bbd2-8d2f-3b70-fc4a-5c44fc9350e6@...2080...>
Subject: Re: [Openvpn-devel] Consider git tags for I60x
References: <e79eb6bd-87bb-a8f7-eda6-e65b33addd24@...277...>
	<0440d93b-6ded-9efc-8fba-838b4e954261@...515...>
	<a4da2c12-b6ba-08c8-9de3-4ef127aafe3e@...2080...>
	<20170323031127.GB24725@...2182...>
	<59bf8d07-476f-bdb7-611d-154bdc4a1bbf@...515...>
In-Reply-To: <59bf8d07-476f-bdb7-611d-154bdc4a1bbf@...515...>

--bj3KN6M4tOIVCmUxiv5oSm79lCGVVIo4w
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 23/03/17 08:52, Samuli Sepp=E4nen wrote:
> Hi,
>=20
> On 23/03/2017 05:11, Antonio Quartulli wrote:
>> On Wed, Mar 22, 2017 at 02:11:56PM +0100, David Sommerseth wrote:
[...snip...]
>>> Currently we do not have anything providing a guaranteed match between
>>> openvpn-install-2.x.y-I60z and a particular git commit.  This helps
>>> understanding what a release really contains, especially if you have
>>> more commits in a release.  Then you just do:
>>>
>>>    $ git shortlog v2.4.0-I601..v2.4.0-I602
>>
>> I like this too - makes it really easy to revise what was changed betwee=
n two
>> releases/tarballs. It's basically one little step more to perform when c=
reating
>> the tarball.
>=20
> The git shortlog command will show us how openvpn-build's parameters in
> "generic/build.vars" and "windows-nsis/build-complete.vars" have
> changed. That is generally enough to know what openvpn-build has
> downloaded and from where.
>=20
> One shortcoming is the tarball version numbering scheme in openvpn-gui:
>=20
>   openvpn-gui-11.tar.gz

It's become fairly popular these days to skip the minor/patch level
numbers and just have a single revision number (firefox, chrome, systemd
are those instantly coming to my mind, but there are many more).
Perhaps the OpenVPN GUI can see a benefit of that too?

> So just the major number, not the full version number (e.g. 11.5.0.0).
> It would be good to have the full version in the tarball name, so that
> all the components combined by openvpn-build would be identifiable
> exactly from git diff. Another concrete benefit would be that old minor
> version tarballs would remain available on the download servers; right
> now they get overwritten on every openvpn-gui release.

All good points!

>>> Another aspect is when you do signed commits (git tag -s), then the tag
>>> is "cryptographically bound" to a particular git commit.  That is
>>> incredibly hard to manipulate.  If the branch itself is modified the
>>> committish will change, thus there will be a mismatch between the branch
>>> committis and the commit the tag points at.  In fact, if you do a git
>>> checkout using the tag name, you will most likely get the correct commit
>>> checked out and not the manipulated one.
>>>
>>
>> +1 on signing the tags - this increases the confidence in the code someb=
ody is
>> downloading. Manipulations are found immediately (unless done voluntaril=
y by
>> the committer).
>=20
> With the current build setup I can easily do signed tags for openvpn-gui.
>=20
> Openvpn-build would require some additional work, as the build computer
> is a shared EC2 VM which other OpenVPN Tech people can access. I don't
> want to have my private GPG key lying around on such a VM. That said,
> nobody else is using the EC2 VM, so I can fairly easily switch to using
> something in my own intranet.

There is nothing that mandates using a personal signing key if you have
some kind of automation behind it - as long as the signing key is is
signed by physical persons we trust.  So the shared VM could have its
own private key used for this and other package signing tasks.

If you're tempted going for full automation and still keep things fairly
more secure, have a look at the Tang project [1].  There is a video [2]
of a talk from devconf.cz the conference in January which describes the
challenge and how Tang fills the gap

[1] <https://github.com/latchset/tang>
[2] "Securing automated decryption"
<https://www.youtube.com/watch?v=3DCM_IOaBUJo0>


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--bj3KN6M4tOIVCmUxiv5oSm79lCGVVIo4w--

--TOJ1g0jGeg9s2KIoK4UXhxNgQWpro2B24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIbBAEBCAAGBQJY07X6AAoJEIbPlEyWcf3yifcP+Ob5cVMKsHjvqdSOfc7PHo4V
0qqBEc6jAkCHw0m1Tc+VWoxd6xBhmLQFf2qRBHHlCt/1lylWvBrrjpp1seK4Q88x
ZbzH9lDTEJKXk97OGuCZ/RX3+TTojPHrLh6g8Zl0Gzlz2mFGIHvZRYADSWxaMsi1
ZT7Y/aq2G7LjmfgwqDNwYNZCcq16QJdFIwrvmQ+IT9L0vXb8f+hqTI4O+8Y5OwgK
obKxTnyN/K1JFx4vl9w9V/frcSucpJIqoxU8LsHuflepJlIsWKgSb5Ls2oNRVZqJ
CRbGSKYcilhByBVxUo/E2FM5EULUdTU7cWQWna7sDXIVes91DA5mLccVxcKZ97cK
YJXX66MNfykreZfmRaMZ89QCRT4zmpzK8X8wG3LJCastTwDfSm4ypkLuALbsgMMO
tFUh01kT6hCxjmsgViD5UlC45SdZOitZC0xGw1hMdCWFXz2rS9/Uq+dyYliwjz/g
Kvm1p4g+HoMoRW/PbIVQvxCnBiIppPflIVogvFoC6GF3U16z3yFmbsfNW5gyzP5o
mWcIOClRVSRgR9m370ObOTzg3ssNed53nbY2jeUvbeJjpQ8CM2uryyMBJ8AgmMDR
tjmSuRRqe6Fr7GgPOwPWfs+tVX1iaZMOTU7xKYw/gnbVtbl7B+Eiszd66Epkm3v4
NuM1xYcIFUWJELi7xso=
=+cHf
-----END PGP SIGNATURE-----

--TOJ1g0jGeg9s2KIoK4UXhxNgQWpro2B24--

