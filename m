References: <cover.1487368114.git.logout@...260...>
	<e5e93420586b24b7df5b2f5ac2df02ccec5ffdb1.1487368114.git.logout@...260...>
	<66d4f562-4786-f3fd-a6ae-27ebe10abf59@...1856...>
	<20170302212621.GE93896@...1296...>
	<735306eb-5dc4-19b0-75ad-2141fb2905b2@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <72797fe3-23f7-8b10-19df-29cc4f31ef98@...2080...>
Date: Sat, 4 Mar 2017 23:38:21 +0100
MIME-Version: 1.0
In-Reply-To: <735306eb-5dc4-19b0-75ad-2141fb2905b2@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ttkQQmcdfpoTjw39M9q8iuKk4ha47mplM"
Subject: Re: [Openvpn-devel] [RFC PATCH v1 05/15] OpenSSL: don't use direct
 access to the internal of X509
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ttkQQmcdfpoTjw39M9q8iuKk4ha47mplM
Content-Type: multipart/mixed; boundary="IUwBQeqHqgMxVCC2Ec7GsX3j24GGkMABr";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <72797fe3-23f7-8b10-19df-29cc4f31ef98@...2080...>
Subject: Re: [Openvpn-devel] [RFC PATCH v1 05/15] OpenSSL: don't use direct
	access to the internal of X509
References: <cover.1487368114.git.logout@...260...>
	<e5e93420586b24b7df5b2f5ac2df02ccec5ffdb1.1487368114.git.logout@...260...>
	<66d4f562-4786-f3fd-a6ae-27ebe10abf59@...1856...>
	<20170302212621.GE93896@...1296...>
	<735306eb-5dc4-19b0-75ad-2141fb2905b2@...1856...>
In-Reply-To: <735306eb-5dc4-19b0-75ad-2141fb2905b2@...1856...>

--IUwBQeqHqgMxVCC2Ec7GsX3j24GGkMABr
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 04/03/17 16:13, Steffan Karger wrote:
> As a last resort, we could consider keeping the old code inside #if
> OSSL_VER < 1.1.0 in release/2.4, but that might just create more
> confusion...

Just a very quick thought here ... I do dislike different behaviours
depending on which OpenSSL version being used.  But given that this
feature is already deprecated and even removed in OpenSSL-1.1, I think
that gives us some options.

I agree with Gert that breaking --ns-cert-type isn't good at all.
However, consider when people upgrade from OpenSSL v1.0 to v1.1 - that
is most commonly when there is major distro update.  It is not something
which happens "mid-term", as OpenSSL is quite commonly used by lots of
base system packages these days.

Regardless of OpenSSL version, I agree to loudly deprecate
--ns-cert-type, through documentation, --help and log files.

But I think we need to carry the existing behaviour for --ns-cert-type
when built against OpenSSL v1.0.  And we can solve through some
compatibility wrapper when built against OpenSSL v1.1 - with even louder
warnings in the logs that this may break apart.

The reason I say this, is that Fedora users are quite unhappy that
--tls-remote disappeared in v2.4.0 *despite* a more recent
NetworkManager-OpenVPN plug-in actually making it easy to switch to
--verify-x509-name.  But IIRC, this wasn't backported to all older and
still valid Fedora releases, so that caused additional pain for the
users.   And don't get me started with the attempt of temporarily build
against mbed TLS instead of OpenSSL in Fedora Rawhide (which will become
Fedora 26), as that broke lots of configurations with CA certificates
using RSA 1024 bit keys.  All this results in very little OpenVPN 2.4
adaptation among many Fedora users.

I can barely imagine what happens if we break --ns-cert-type on top of
that ... Just that the behaviour might change for a minority of users in
when Fedora 26 hits the streets, with OpenSSL v1.1, might hit us bad
again.  But at least with OpenSSL v1.1, many users knows that things
will be somewhat different too.  And we can actually point at OpenSSL
and explain why it broke, which is not something we could do with
the --tls-remote option.


Just my way too many cents ..... :)


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--IUwBQeqHqgMxVCC2Ec7GsX3j24GGkMABr--

--ttkQQmcdfpoTjw39M9q8iuKk4ha47mplM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJYu0HiAAoJEIbPlEyWcf3yxkQP/Rz3jmLrvKF3SlFkMFRajb1A
vUzlwtg9f7BrwDnppQo884ddQpVqA8uGZLkNOSJVw54PVEbGL+noooHmAH8VkW/h
ins7vpqCZkOeyq9EWNDkJxZ+fwJrTXCwFwgs1tonbTJH/sfnjiQoe8QLLgE/C1mx
VEzd4Ohpsh/rnFPekrfS7jLJFB+9tAYyz3koQ7oiYKPDS92i5ytaddIwzb+gKiCz
ZktWN3xKTBAwIPk7ZeAIHN/l02yTd38eMk8qs34x8yhBlW306Qe19TRSWNqSPpMx
hU0WaRKAkT4LMfFf9waU1m0wfFa9Mw5skoV84y3oOOlRou5JFiiLnYzxvtVl02uE
ajzwsSR8YH+qoOZsA1qjy9Se8gjwxXmYm7qwcb3HdVF5QTC7dGwbVcsjljiP8vKK
iKbsLoVovroDTasiv4M+3ztkrNU8i/zl05yh93VetU1YY2tHsY/ObJm+cE1UmLFT
xSBxvTd2l23faEouONYVPrdbt9TX3pYpQmLvDCLX4TDbtcOgeCEcrKITXq7RWmaa
MJ9gTYtq9fLA/fC39H0I5gy9tm2wd809j0bHkjBW8DkgHe8aP5D4zJKOhk56Y4/3
W7XRjSZkbvkY2VViGG4gwU9vWYhr7dfRGKO7Fcq3IilgUyhwI7izDLE4iauYpYMk
Sq7dGtUY5ZnlPlkhmEZe
=C3iN
-----END PGP SIGNATURE-----

--ttkQQmcdfpoTjw39M9q8iuKk4ha47mplM--

