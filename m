Message-ID: <5215E945.7080105@...1114...>
Date: Thu, 22 Aug 2013 12:34:45 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <5215D0BA.6040009@...515...>
In-Reply-To: <5215D0BA.6040009@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="n6hNFgCGh8IPSNSQMcauA7d0up7e066Vf"
Subject: Re: [Openvpn-devel] Topics for today's community meeting
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n6hNFgCGh8IPSNSQMcauA7d0up7e066Vf
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

On 22/08/13 10:50, Samuli Sepp=E4nen wrote:
> Hi,
>=20
> We're having an IRC meeting today, starting at 18:00 UTC on
> #openvpn-devel@...1422... Current topic list is here:
>=20
> <https://community.openvpn.net/openvpn/wiki/Topics-2013-08-22>

I'm not able to attend the meeting today, but just wanted to quickly
comment on on a couple of the topics.

* --auth-user-pass - "Using a user-file (inline or not) with
challenge-response "

I think this is by design.  As I understand the purpose of
challenge-response, it is to avoid static passwords.  If it is possible
to detect the server uses a challenge-response setup, we should probably
bail-out with an error if --auth-user-pass is used with files anyway.
But I think it's how it is now, because detecting that was harder or
impossible.


* openvpn-build issues + snappy topic.

   "The problem is that snappy pulls in a 8MB library as a dependency,
    increasing installer size considerably "

Is this really a problem?  It's not a small library, but it could still
be worse.

Another way to "solve" this (if it is a real problem) could be to have
have two openvpn binaries shipped in the installer.  And ask at install
time if the user wants Snappy support or not.  If not, don't install
this library and use a openvpn compiled without snappy support.  If
support is wanted, install the library + openvpn binary with snappy
support.  The installer will be somewhat bigger, but the user has an
option to opt out of snappy support.


Just my 2 cents.


--=20
kind regards,

David Sommerseth


--n6hNFgCGh8IPSNSQMcauA7d0up7e066Vf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlIV6UgACgkQDC186MBRfrqFpQCggqhqlxaGNFuL5ffD5P7A+7HA
Ir4Anj+8R2oO9DIGuurYKR9XfU3zesns
=A2O2
-----END PGP SIGNATURE-----

--n6hNFgCGh8IPSNSQMcauA7d0up7e066Vf--

