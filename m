Message-ID: <52A586E7.4050703@...1114...>
Date: Mon, 09 Dec 2013 10:01:27 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <528B8225.3040206@...515...>	<1384882574-28242-1-git-send-email-heiko.hund@...1489...>	<529EF77C.5020603@...68...>	<CAEsd45SF1fcVPJfOmhmm6GzB7=WvnBg95k=+nX25aRwKf2X-kQ@...278...>
	<CAFHpkQFx+3QHie71FTGKk6ieKMwC-7X8M=O58qbtnj8-99MVYA@...278...>
In-Reply-To: <CAFHpkQFx+3QHie71FTGKk6ieKMwC-7X8M=O58qbtnj8-99MVYA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="whWW1esAIX1QIXuvdE4HLNfqqTMgvxG0u"
Subject: Re: [Openvpn-devel] English language? Re: [PATCH] Support non-ASCII
 characters in Windows tmp path
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--whWW1esAIX1QIXuvdE4HLNfqqTMgvxG0u
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 04. des. 2013 13:22, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD wrote:
> I've looked through the code and I do not understand why do we need
> that temporary directory on windows platfrom ?
> anyone can explain idea behind initializing tmp-dir ? especially on
> Windows platform.

The client side most likely won't need --tmp-dir at all.  But if running
a server on Windows, OpenVPN will create some temporary files upon
client authentication.

See commit ca4c6d618d7 for more info.


--=20
kind regards,

David Sommerseth


--whWW1esAIX1QIXuvdE4HLNfqqTMgvxG0u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKlhusACgkQDC186MBRfrrKtwCgpgTuUqOfpQrOoZDV2iGtMsJi
wpMAn07JgGXvxR+bS3e4x/sNQIQEiH/d
=LmnF
-----END PGP SIGNATURE-----

--whWW1esAIX1QIXuvdE4HLNfqqTMgvxG0u--

