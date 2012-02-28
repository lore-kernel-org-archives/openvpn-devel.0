Message-ID: <4F4D1D5F.2090208@...1114...>
Date: Tue, 28 Feb 2012 19:30:55 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F4CE4FE.3010009@...515...>
	<1848924920.20120228183103@...449...>
	<CAOazyz0x4hKsREcGi+9TGc+AO0d+i1d5qbmPJ2hQfCsUbVanNQ@...278...>
	<1111951883.20120228191750@...449...>
In-Reply-To: <1111951883.20120228191750@...449...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/02/12 19:17, Carsten Kr=FCger wrote:
> Hello Alon,
>=20
> ABL> This is *THE* missing functionality in Windows environment. ABL>
> It seems that nobody interested in developing proper UI using ABL>
> management interface for Windows. ABL> Same goes to proper smartcard
> support.
>=20
> Developing the UI (command line) would be trivial but to my knowledge=20
> (I'm reading the mailinglist for last 7 years) there is no management=20
> interface in openvpn that would allow this.
>=20

Have you seen this document?  (management/management-notes.txt)
<http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn-test=
ing.git;a=3Dblob_plain;f=3Dmanagement/management-notes.txt;hb=3Dmaster>

Especially look for all the 'pkcs11' prefixed calls, like
pkcs11-id-count, pkcs11-id-get.  Further James implemented a new feature
for the management interface where you can pass the certificate this way
too.  Unfortunately, as Alon pointed out, this has not yet been
documented well - except in the commit log.

<http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn-test=
ing.git;a=3Dcommit;h=3Dcf69617bbea45a15423c4188daa9386debcbe1ec>

So things are happening here too.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9NHVwACgkQDC186MBRfrr/qgCdF2BT+TqE+h2x/Aqoin271bc0
wfAAn2va1LDzeRo9Km8eQqmYWlsvFJ4E
=3DdhKu
-----END PGP SIGNATURE-----

