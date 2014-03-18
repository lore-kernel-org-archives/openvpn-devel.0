Message-ID: <532843D3.7070206@...1114...>
Date: Tue, 18 Mar 2014 14:02:11 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1395017376-24554-1-git-send-email-james@...515...>	<20140317202910.GM16637@...1296...>
	<532775DD.4050106@...515...>
	<1CED409804E2164C8104F9E623B08B90155646D4C1@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B90155646D4C1@...1436...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="qMkElbQOcOd51SD3g0pH4RsNNkW1X2UxN"
Subject: Re: [Openvpn-devel] [PATCH] Set SSL_OP_NO_TICKET flag in SSL
 context for OpenSSL builds, to disable TLS stateless session resumption.
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, James Yonan <james@...515...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qMkElbQOcOd51SD3g0pH4RsNNkW1X2UxN
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 18/03/14 10:39, Steffan Karger wrote:
> Hi,
>=20
>> On 17/03/2014 23:23, James Yonan wrote:
>>
>> On 17/03/2014 14:29, Gert Doering wrote:
>>> Right now, if I read configure.ac correct, we require 0.9.6 or later
>>> (and check this only if pkg-config is available) - but obviously,
>>> SSL_OP_NO_TICKET was added later on.
>>>
>>> Fix 1: only use SSL_OP_NO_TICKET if available Fix 2: require a more
>>> recent OpenSSL version
>>
>> I would think an #ifdef should be fine.
>=20
> SSL_OP_NO_TICKET was added in OpenSSL 0.9.8f / 1.0.0. The
> ECDH-patchset (for 2.4) already requires 0.9.8, so I would prefer to
> require 0.9.8f or newer for master/2.4, but just add #ifdef's for 2.3.

There's JJK's comments, which makes sense.  In addition, RHEL 5 (which
we're supposed to support) only ships openssl-0.9.8e.


--=20
kind regards,

David Sommerseth


--qMkElbQOcOd51SD3g0pH4RsNNkW1X2UxN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMoQ9cACgkQDC186MBRfrr2FwCglRB8j6z3cKfaIVPHxW449S2H
mO8AmwWSkE8ROZcRSuC5eQDkEClfO2bu
=bMT/
-----END PGP SIGNATURE-----

--qMkElbQOcOd51SD3g0pH4RsNNkW1X2UxN--

