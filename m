References: <20170115061718.3218-1-praiskup@...1347...>
	<3821af27-817b-9ee5-29db-bf3516bcdad3@...1856...>
	<20170115091201.GQ78624@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <2feb3ac7-93f3-e91c-05a9-2296fd60b9da@...1856...>
Date: Sun, 15 Jan 2017 10:17:41 +0100
MIME-Version: 1.0
In-Reply-To: <20170115091201.GQ78624@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kLHhq6JHlOwaPwfHFXCGD5Itdew3qKsud"
Subject: Re: [Openvpn-devel] [PATCH] options: allow setting default --ca
 argument value
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kLHhq6JHlOwaPwfHFXCGD5Itdew3qKsud
Content-Type: multipart/mixed; boundary="rNJeCn9iIodA5DgH2en22Ehe6shcPD0WP";
	protected-headers="v1"
From: Steffan Karger <steffan@...1856...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <2feb3ac7-93f3-e91c-05a9-2296fd60b9da@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] options: allow setting default --ca
	argument value
References: <20170115061718.3218-1-praiskup@...1347...>
	<3821af27-817b-9ee5-29db-bf3516bcdad3@...1856...>
	<20170115091201.GQ78624@...1296...>
In-Reply-To: <20170115091201.GQ78624@...1296...>

--rNJeCn9iIodA5DgH2en22Ehe6shcPD0WP
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable


On 15-01-17 10:12, Gert Doering wrote:
> On Sun, Jan 15, 2017 at 09:52:46AM +0100, Steffan Karger wrote:
>> On 15-01-17 07:17, Pavel Raiskup wrote:
> [..]
>>> This option is primarily designed for systems where users are
>>> allowed to manage trusted authorities for whole system (in one
>>> consolidated file; usually implemented in 'ca-certificates'
>>> package).
> [..]
>>
>> Feature-NAK.  OpenVPN should use it's own CA, not the system CA list.
>=20
> I could see the use-case (enterprise wide list of trusted CAs, and
> use of it compiled into an enterprise-distribute openvpn bundle),
> but I agree with Steffan that it's not something we need to have in
> OpenVPN - "--ca" can reference to a CA bundle today, and enterprise-
> distributed config files reference the enterprise-maintained CA bundle,
> it will just work without code changes.

Yes, I got that.  I'll be a bit more verbose: the use case is
sufficiently covered by --ca (as Gert says), and this option is *way*
too likely to be misinterpreted to 'point to
/etc/ssl/certs/ca-certificates.crt', which will in almost all setups
significantly reduces security.

We have plenty of confusing options, we really don't need another one :)

-Steffan


--rNJeCn9iIodA5DgH2en22Ehe6shcPD0WP--

--kLHhq6JHlOwaPwfHFXCGD5Itdew3qKsud
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYez4/AAoJEJgCyj0AftKI5ZYH/A1Rlfa4LMuWsD5eF6KlBB9r
B2fKWaGTL6sPW+B5pDjSWKFgKyEzys+adARH7yXMniZ99K4IqkrepU1BcqwrI38c
Ichu0bBxE0m/4BAIGjif3xTNIwnjPVCihwYJ9wRODlMU6oBQ8JRcQ+7lBrdr5GVw
unKh/9puUhfjcWwut06hiQMNiC9OJrQg8f+xhxmR13Ln1F0T6LBFiATuAEh2Kkh4
Crp2HSpY4O2GM6kgIJjCdbi6zgJYWjGPE2e1wYEPQ+U/1ktelKBBfoOVZmtZ3rbn
ipje4+ZDbHzG91zSic27WdHM+3ZVXPLdAwa+yGSVuIpHQdg2Pi1seJbJEpBHJ64=
=nWwL
-----END PGP SIGNATURE-----

--kLHhq6JHlOwaPwfHFXCGD5Itdew3qKsud--

