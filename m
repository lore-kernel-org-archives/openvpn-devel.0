Message-ID: <5326D101.1030802@...1114...>
Date: Mon, 17 Mar 2014 11:40:01 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1395017376-24554-1-git-send-email-james@...515...>	<20140317083335.GB16637@...1296...>
	<1CED409804E2164C8104F9E623B08B90155646CEF6@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B90155646CEF6@...1436...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ul2PfQR9bB7tJ89Qjs1d9QJo0BcA17aS4"
Subject: Re: [Openvpn-devel] [PATCH] Set SSL_OP_NO_TICKET flag in
 SSL	context for OpenSSL builds, to disable TLS stateless session resumption.
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, Gert Doering <gert@...1296...>, James Yonan <james@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ul2PfQR9bB7tJ89Qjs1d9QJo0BcA17aS4
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 17/03/14 11:08, Steffan Karger wrote:
> Hi,
>=20
>> -----Original Message-----
>> From: Gert Doering [mailto:gert@...1296...]
>> Sent: maandag 17 maart 2014 9:34
>> Subject: Re: [Openvpn-devel] [PATCH] Set SSL_OP_NO_TICKET flag in SSL
>> context for OpenSSL builds, to disable TLS stateless session
>> resumption.
>>
>> Hi,
>>
>> On Sun, Mar 16, 2014 at 06:49:36PM -0600, James Yonan wrote:
>>> OpenVPN doesn't want or need SSL session renegotiation or resumption,
>>> as it handles renegotiation on its own.
>>>
>>> For this reason, OpenVPN always disables the SSL session cache:
>>>
>>> SSL_CTX_set_session_cache_mode (ctx, SSL_SESS_CACHE_OFF)
>>>
>>> However, even with the above code, stateless session resumption is
>>> still possible unless explicitly disabled with the SSL_OP_NO_TICKET
>>> flag.  This patch does this.
>>
>> I assume this should go into all OpenVPN branches, that is, master,
>> 2.3, and if we ever do another 2.2, into that one as well?
>>
>> (not ACKing or NAKing the patch itself, this is not my field of
>> expertise)
>=20
> I think this should go into all releases we'll do from now on.
>=20
> Also, ACK on the patch. Together with SSL_SESS_CACHE_OFF, this seems
> to fully disable TLS session renegotiation and resumption.

This patch only covers OpenSSL.  Is there an equivalent for PolarSSL as
well?  Or isn't it needed at all on PolarSSL?


--=20
kind regards,

David Sommerseth


--ul2PfQR9bB7tJ89Qjs1d9QJo0BcA17aS4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMm0QQACgkQDC186MBRfrrzegCdGE34uVbWYYo+1E3nFgKQYNnB
WV0AoIliY9M7n+4QSgwoA9ximZusNxBD
=Qmfx
-----END PGP SIGNATURE-----

--ul2PfQR9bB7tJ89Qjs1d9QJo0BcA17aS4--

