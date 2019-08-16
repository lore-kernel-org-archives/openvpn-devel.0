References: <65530ded0938659345877e870f49d2ad4b9768ae.camel@...2524...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <3852ddc0-a136-3e28-9925-2c597a1cfaca@...2080...>
Date: Fri, 16 Aug 2019 13:45:19 +0200
MIME-Version: 1.0
In-Reply-To: <65530ded0938659345877e870f49d2ad4b9768ae.camel@...2524...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="66kWpoMsIgLnYiXJ5H4vfpLBPwX2S0o4b"
Subject: Re: [Openvpn-devel] ***UNCHECKED*** Patch: Export NotBefore and
 NotAfter items to the environment in client-connect
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rolf Fokkens <rolf.fokkens@...2524...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: Valentin Bajrami <valentin.bajrami@...2524...>, Jasper Siero <jasper.siero@...2524...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--66kWpoMsIgLnYiXJ5H4vfpLBPwX2S0o4b
Content-Type: multipart/mixed; boundary="F8eLK7PY7DCCzpXwFIkU74xgPlSrDfQo0";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Rolf Fokkens <rolf.fokkens@...2524...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: Valentin Bajrami <valentin.bajrami@...2524...>,
 Jasper Siero <jasper.siero@...2524...>
Message-ID: <3852ddc0-a136-3e28-9925-2c597a1cfaca@...2080...>
Subject: Re: ***UNCHECKED*** [Openvpn-devel] Patch: Export NotBefore and
 NotAfter items to the environment in client-connect
References: <65530ded0938659345877e870f49d2ad4b9768ae.camel@...2524...>
In-Reply-To: <65530ded0938659345877e870f49d2ad4b9768ae.camel@...2524...>

--F8eLK7PY7DCCzpXwFIkU74xgPlSrDfQo0
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 16/08/2019 10:27, Rolf Fokkens via Openvpn-devel wrote:
> We're considering to use shorter-lived client certificates for our VPN
> users. In an effort to prevent negative impact for our staff due to
> expired certificates, we 'd like to keep track of imminent expiration
> of certificates in the client-connect script (which we're using anyway
> to check is the certificate matches the user id). Many certificate
> attributes are passed to the script, but not the "NotAfter" and
> "NotBefore" attributes.
>=20
> The attached patch adds these to the mix.

This gets a Feature-ACK from me.  This is useful information, and something
other users in the community have asked for earlier too.  But there are a f=
ew
things here before starting to dive into the details.

First of all, we want to have patches first into git master, and then we ne=
ed
to discuss in the community if this feature is something we want to backport
to the 2.4 release.  After a new release has stabilized (which 2.4 has), we
are quite reluctant to add new features to those releases.

Another thing is that I think it would be valuable to also print this
information into the logs as well.  The X509_get_notBefore() value is proba=
bly
not so important unless that has a value which is in the future.  The
X509_get_notAfter() is fine to always log, but would be nice if it would co=
me
a M_WARN log entry if it has expired.

To achieve this logging feature, setenv_ASN1_TIME() would need to be
refactored a bit - possibly by returning a string as well as "is now() after
the time stamp?" bool flag.  The "printing" could happen to a gc_arena
allocated buffer (which is available in verify_cert_set_env()).  The logging
should probably already happen in verify_cert(), which also has its own
gc_arena.  There are various alternatives to avoid doing the ASN1_TIME_prin=
t()
preparations and processing multiple times (for logging and setenv), but I
don't have a clear idea right now what could be a reasonable approach.

And lastly, this code will break compilation if using
./configure --with-crypto-library=3Dmbedtls ... This should also be improve=
d.

Other than that, the code looks reasonable at first glance (I have not comp=
ile
tested it yet)

--=20
kind regards,

David Sommerseth
OpenVPN Inc



--F8eLK7PY7DCCzpXwFIkU74xgPlSrDfQo0--

--66kWpoMsIgLnYiXJ5H4vfpLBPwX2S0o4b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJdVpdVAAoJEIbPlEyWcf3yS1EP/0xNaTFEBjRaNsxmYh8tKstc
3plDVnsoW3FGuRAa1Zv7UXtpTgaQS+3nb7YnU5Ao42+u8RR6ZStJ9j6Cy7hsW0Mw
6Tm1a45QHMxjLGhnEAMdfur1CX+GMC440ZANMBvlZtFvcJ1WwFfjpLJGyhGOVzZb
8TfIEmtXGvXJT40pmlQq90rgbdg20KdFU4yCBAg0fipGd414lK3NXc3om0VCtnQH
4uvgzdfEP3Fi5GWHPdeMl0ZXFxoDdhHCmvrhdlXuqdchcPCjdsE8g+nDtlK0ih9W
oH03/SDoI3qRgxUxmvXoDG590DWjSqHTGBhpp3j8mu9OPLD1anQEGQ2rC8hRCpK0
UWUIusQzpExPcLWQjcbSokLnaHewPCD7SbOkFUfQRPpxrgfGxOkrBqdvccMfe0DD
x+9giwbXaiXRxzPwoFISF/wo0m2OGshKVYJTdZFGUmyzNpKoxT001C8RDt02IJPd
81YH03b6Kjl7QKDj8jQ9P8Yaej45+zHQJE7NLwqSXCJFvvvXK2fGWhUmPMRP1Kzc
v4luGe7DtBOW5N+55tC6y1A7zFQ++xA513Ii1f+GIxAut1cxytxgzZ++Z5BEJl6f
Xwnnct25ocMYLf6SO+SN0sJagx4rtBpys2tGo7mMx4MmkPu2wGCwYubO1HMYlJg3
0IGkyrkPU3dN4jPMeVxL
=9W5z
-----END PGP SIGNATURE-----

--66kWpoMsIgLnYiXJ5H4vfpLBPwX2S0o4b--

