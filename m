Date: Fri, 27 Feb 2015 19:28:32 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20150227182832.GE8134@...1296...>
References: <20150225160718.GA6306@...2009...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ithwq2VAKZXg2OxI"
Content-Disposition: inline
In-Reply-To: <20150225160718.GA6306@...2009...>
Subject: Re: [Openvpn-devel] [PATCH v4] Mac OS X Keychain management client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vasily Kulikov <segoon@...2008...>
Cc: openvpn-devel@lists.sourceforge.net

--ithwq2VAKZXg2OxI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Feb 25, 2015 at 07:07:18PM +0300, Vasily Kulikov wrote:
> The patch is against commit 3341a98c2852d1d0c1eafdc70a3bdb218ec29049.
>=20
> v4:
>  - added '--management-external-cert' argument
>  - keychain-mcd now parses NEED-CERTIFICATE argument if 'auto' is passed
>    as cmdline's identity template
>  - fixed typo in help output option name
>  - added '--management-external-cert' info in openvpn(8) manpage
>  - added 'certificate' command documentation into doc/management-notes.txt

Sorry to be nagging...  something in your patch was garbled, it contained
stuff like

-----------------------
only in patch2:
unchanged:
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -777,6 +777,28 @@ correct signature.
 This capability is intended to allow the use of arbitrary cryptographic
 service providers with OpenVPN via the management interface.
...
-----------------------

(the diff for doc/management-notes.txt is in there twice), and there
is a patch for .gitignore in it as well.

Please generate the patch with "git format-patch", that should avoid=20
spurious stuff.


Also, in the doc/management-notes.txt, it has

+COMMAND -- certificate (OpenVPN 2.3 or higher)

please make that "2.4", as this code change is too large to go into 2.3
(where we only do bug fixes and long-term stability stuff, but no new
features generally)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ithwq2VAKZXg2OxI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVPC3UKkuBuNlUUl1AQLgXQQAmA8cAg92fO/mpty63y7XTd98M9a8egay
RjQsu1pfKr3GEzPLWKtoDuFQ7LLfhfpW1N5EjQQaw+QdzqFbozE1/feJsn8Jdz/k
Dy/GMFFGuhapCoBYauORYzryokBa/qxWEXgs6lc243HNVneLzLMyE/Ye7v2BOVln
2M4yIfLAvR8=
=s7IU
-----END PGP SIGNATURE-----

--ithwq2VAKZXg2OxI--

