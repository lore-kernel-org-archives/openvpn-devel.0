References: <96d637db-5213-9bd6-8628-a89bd755010d@...277...>
	<f55a40ec-830c-ce21-d096-c52738f6c2ff@...277...>
	<21b41a9e-c3b6-b0a7-a492-1e8cf4b2258e@...515...>
	<95a192d1-940b-99e3-0ef1-957d113e6c9a@...515...>
	<93db226d-6a48-faf7-5b35-3c5ca1880779@...2080...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <0f23f502-df5d-7ac1-5a78-8c557175cd7e@...515...>
Date: Wed, 26 Apr 2017 13:50:18 +0300
MIME-Version: 1.0
In-Reply-To: <93db226d-6a48-faf7-5b35-3c5ca1880779@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0nbtKRqQtCfBMPXJgNLHVDD8D3nGL0hfd"
Subject: Re: [Openvpn-devel] For Windows: DHCP Client dependency
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, debbie10t <debbie10t@...277...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0nbtKRqQtCfBMPXJgNLHVDD8D3nGL0hfd
Content-Type: multipart/mixed; boundary="gMmSao8iuBRiuqeSCOwbSQ0sXrpRApifK";
	protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net, debbie10t <debbie10t@...277...>
Message-ID: <0f23f502-df5d-7ac1-5a78-8c557175cd7e@...515...>
Subject: Re: [Openvpn-devel] For Windows: DHCP Client dependency
References: <96d637db-5213-9bd6-8628-a89bd755010d@...277...>
	<f55a40ec-830c-ce21-d096-c52738f6c2ff@...277...>
	<21b41a9e-c3b6-b0a7-a492-1e8cf4b2258e@...515...>
	<95a192d1-940b-99e3-0ef1-957d113e6c9a@...515...>
	<93db226d-6a48-faf7-5b35-3c5ca1880779@...2080...>
In-Reply-To: <93db226d-6a48-faf7-5b35-3c5ca1880779@...2080...>

--gMmSao8iuBRiuqeSCOwbSQ0sXrpRApifK
Content-Type: multipart/mixed; boundary="------------96528299602E0EB84062B8FF"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------96528299602E0EB84062B8FF
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 26/04/2017 13:12, David Sommerseth wrote:
> On 26/04/17 10:32, Samuli Sepp=E4nen wrote:
>>
>> So I made the anchor visible:
>>
>> <https://community.openvpn.net/openvpn/wiki/FAQ>
>>
>> Not necessarily very pretty, but should help users figure out which FAQ
>> item they should click on.
>=20
> It's not too ugly.  But I spotted something far more crucially
> important.  Lots of the information is aged, not necessarily correct and
> some needs to be updated.
>=20
> Like, RPM packaging.  Using rpmbuild on tar.gz packages might work.
> However, the openvpn.spec(.in) file we have is basically unmaintained.
> It does not tackle the new world of systemd specifics (which impacts at
> least RHEL/Fedora and SUSE).  There are also more RPM based distros,
> which I have little knowledge of.  I would rather suggest we skip
> providing this file.  Each distro have their own packaging guidelines
> and preferences how to do things.  We should rather point users at those
> maintained .spec files instead.
>=20
> The IPv6 entry is also in desperate need of an update.
>=20
> The bridging entries can be unified (at least have a common entry point,
> where to dive deeper).  And it should also include a pointer to
> http://community.openvpn.net/openvpn/wiki/BridgingAndRouting ... And we
> really should as much as possible lead people away from bridging; it is
> really not the right solution for most of our (community) users.
>=20
> We should probably also have another group of entries, "Networking" ...
>=20
> That's just the 5 minutes review of this page .... It's a good starting
> point, but I think we should improve it a lot.   And I call for help
> from the community! ;-)
>=20
> Join the #openvpn IRC channel on FreeNode ... and we can discuss these
> entries and how to organize things there.  (Nicks to really pay
> attention to are: ecrist, krzee, danhunsaker, ordex, plaisthos, syzzer,
> cron2, dazo - probably a few more, but those are at least a starting poin=
t)
>=20
>=20

+1 to everything. The FAQ items have not been maintained very actively
in many, many years. Many of them could probably be scrapped altogether.
For example, some probably still refer to Windows 2000. Going through
them in a IRC session would one option.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------96528299602E0EB84062B8FF
Content-Type: application/pgp-keys;
 name="0x40864578.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0x40864578.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

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
XuwT7RpGDZ6jBfphYQ=3D=3D
=3DFKLE
-----END PGP PUBLIC KEY BLOCK-----

--------------96528299602E0EB84062B8FF--

--gMmSao8iuBRiuqeSCOwbSQ0sXrpRApifK--

--0nbtKRqQtCfBMPXJgNLHVDD8D3nGL0hfd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZAHtrAAoJEClYTZ9AhkV4zf4H/Ap0PIq/6GlJzCUx7uFsky52
kRgJDwvk72J5e7Xu9QImIWTNp9bzDzi4dD7rQIrbA4JM2UB0NF7ydltzCl8fbWFy
Uln4jomqIKGiRvxRmqY3LzfdnEYSsWvVK8r4tvNwMZtK+na7Zt5TT4KhbpJDaTR7
wcpsJGCsOikeL8X9GFNuDvt/pyTVb0+YrtE9cudc2MODAieAav9gQRierZt7eHcy
+dACek0ViQoYYXj+ZlFA4UYY/evDJGSq/HnaubSAa5iTXIAkLrgHzZJCqac/pdPw
s50/z+Bu+nRz7YZOkjgw1bTqMyFAFimJkU2NYAxMhvp+a3cKHimj7RYNAgg4UZY=
=VBhE
-----END PGP SIGNATURE-----

--0nbtKRqQtCfBMPXJgNLHVDD8D3nGL0hfd--

