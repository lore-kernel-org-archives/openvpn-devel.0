Message-ID: <4E130E87.4070202@...1114...>
Date: Tue, 05 Jul 2011 15:15:51 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4E12BE97.3000308@...1432...>
In-Reply-To: <4E12BE97.3000308@...1432...>
Subject: Re: [Openvpn-devel] Bug: extended x509-username-field broken in git
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Markus_K=F6tter?= <koetter@...1432...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/07/11 09:34, Markus K=F6tter wrote:
> Hi,
[...snip...]
>=20
> I had a look on the diff for 2.2-beta3 to 2.2.0 and saw no suspicious=20
> changes - maybe because I just don't know how one would suppress the=20
> extensions from being accessible in the certificate.
>=20
> So for now I have to use 2.2-beta3.
>=20
> Suggestions?

Can you please use git bisect to locate the offending commit?

   $ git bisect start v2.2.0 v2.2-beta3

then you build and try to run your test routine.  If this worked, then you =
do:

  $ git bisect good

Or if it failed, then you do:

  $ git bisect bad

Do this good/bad thing until git have located the commit which changes the
behaviour.  You will get a result similar to what you see here:
<https://community.openvpn.net/openvpn/ticket/108#comment:1>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk4TDoUACgkQDC186MBRfrqczgCfTnHHJTyFgHWwqhrG7+9DcDVQ
uWwAn2zUHMQSrwnIvT+fgXpzaEveuppk
=3D7juI
-----END PGP SIGNATURE-----

