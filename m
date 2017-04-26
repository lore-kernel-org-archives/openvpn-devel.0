From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <96d637db-5213-9bd6-8628-a89bd755010d@...277...>
	<f55a40ec-830c-ce21-d096-c52738f6c2ff@...277...>
	<21b41a9e-c3b6-b0a7-a492-1e8cf4b2258e@...515...>
Message-ID: <95a192d1-940b-99e3-0ef1-957d113e6c9a@...515...>
Date: Wed, 26 Apr 2017 11:32:08 +0300
MIME-Version: 1.0
In-Reply-To: <21b41a9e-c3b6-b0a7-a492-1e8cf4b2258e@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d6Gal07jg43llNGqaILRSEIsb3cJ7piPb"
Subject: Re: [Openvpn-devel] For Windows: DHCP Client dependency
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d6Gal07jg43llNGqaILRSEIsb3cJ7piPb
Content-Type: multipart/mixed; boundary="J59MuJBlfXgFaADb4aTNIvkcsWgCOIhj6";
	protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: debbie10t <debbie10t@...277...>, "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Message-ID: <95a192d1-940b-99e3-0ef1-957d113e6c9a@...515...>
Subject: Re: [Openvpn-devel] For Windows: DHCP Client dependency
References: <96d637db-5213-9bd6-8628-a89bd755010d@...277...>
	<f55a40ec-830c-ce21-d096-c52738f6c2ff@...277...>
	<21b41a9e-c3b6-b0a7-a492-1e8cf4b2258e@...515...>
In-Reply-To: <21b41a9e-c3b6-b0a7-a492-1e8cf4b2258e@...515...>

--J59MuJBlfXgFaADb4aTNIvkcsWgCOIhj6
Content-Type: multipart/mixed; boundary="------------1BB51E793685ABC8230A739F"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------1BB51E793685ABC8230A739F
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 25/04/2017 15:29, Samuli Sepp=C3=A4nen wrote:
> On 25/04/2017 15:11, debbie10t wrote:
>>
>>
>> On 25/04/17 01:18, debbie10t wrote:
>>> Hi,
>>>
>>> generally, Openvpn on Windows is dependent on the "Windows DHCP Client
>>> service" .. if that Service is not started, is it possible for Openvpn
>>> to report a *specific* log message that: _DHCP_ has failed to assign an
>>> IP address to TAP Adapter ?
>>>
>>> thanks
>>
>> Looking closer at the log, it turns out there is a specific message:
>>
>> .. Initialization Sequence Completed With Errors
>>     ( See http://openvpn.net/faq.html#dhcpclientserv )
>>
>> The link [eventually] leads to this:
>> https://community.openvpn.net/openvpn/wiki/259-tap-win32-adapter-is-not-=
coming-up-initialization-sequence-completed-with-errors
>>
>> which is sufficient.
>> Thanks
>=20
> While the #dhcpclientserv anchor is definitely in the right place,
> perhaps usability could be improved somewhat.
>=20
> One simple option would be to make the anchor visible, so that the user s=
ees
>=20
> TAP-Win32 adapter is not coming up: "Initialization sequence completed
> with errors". [#dhcpclientserv]
>=20
> instead of
>=20
> TAP-Win32 adapter is not coming up: "Initialization sequence completed
> with errors".
>=20
> Thoughts?

So I made the anchor visible:

<https://community.openvpn.net/openvpn/wiki/FAQ>

Not necessarily very pretty, but should help users figure out which FAQ
item they should click on.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------1BB51E793685ABC8230A739F
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

--------------1BB51E793685ABC8230A739F--

--J59MuJBlfXgFaADb4aTNIvkcsWgCOIhj6--

--d6Gal07jg43llNGqaILRSEIsb3cJ7piPb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZAFsJAAoJEClYTZ9AhkV4oK0IAK6UjdaoA3lF7xbPoXmgtbd9
zh94Yn/MJrnbTxdfB7apFx4TOJ7BJOfWQzsEHK1BqElRSruwhSdNRLIbXaTHxt9/
Z7mn+WkHTAT3sHA377uyMtlrN06mTXxI0OO0IMUIEbTDTboPmgnxCAiHXDj4LAiu
oMWEnfhR4W+TISelpN0jxTDdk5KbE1PtiPtcuIm7rlntlYxg07xA0dTDzIui8QZc
7rNMMCMr4KZ+XTl/OyhsX4MbnjGNErRpuL4RHARLT/Ebn64yjd/Qby/5MMtdnqsN
I0NXfeClP6cNnqxPsb88z5Lg59O+dkKAbvFGDsD1CnvTt3lM7GaBN2//rOSzhZc=
=GD6/
-----END PGP SIGNATURE-----

--d6Gal07jg43llNGqaILRSEIsb3cJ7piPb--

