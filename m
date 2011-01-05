Message-ID: <4D24763A.1050406@...1114...>
Date: Wed, 05 Jan 2011 14:46:34 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4D24703E.70504@...515...>
In-Reply-To: <4D24703E.70504@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Changed snprintf to _snprintf
	in	service-win32/openvpnserv.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/01/11 14:21, Samuli Sepp=E4nen wrote:
> This fixes a generic Windows/VC++ issue:
>=20
> <http://thedailyreviewer.com/dotnet/view/strncasecmp-and-snprintf-functio=
ns-not-available-in-vc-109235975>
>=20
> Does this change affect the automake/gcc-based Windows builds?
>=20

I'm leaning towards a NAK on this one, as it might influence
non-Visual C builds.  OpenVPN have openvpn_snprintf() which is a
portable snprintf() function, and this one should be used instead.  It's
found in buffer.[ch].


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0kdjgACgkQDC186MBRfrq+/ACfZ0XlQpSSJpEatxvnoQY0MQU7
RA4AoI6ahmFBh1QugQt/EG7WrIQchNQu
=3DrRM9
-----END PGP SIGNATURE-----

