References: <1456171763-44172-1-git-send-email-fish.thss@...277...>
	<20160225122928.GC24952@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <56CEF9E5.3090508@...2080...>
Date: Thu, 25 Feb 2016 13:56:05 +0100
MIME-Version: 1.0
In-Reply-To: <20160225122928.GC24952@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="s8ifRuuLlSpL5ShQ2da970OWjOAQpCCKS"
Subject: [Openvpn-devel] The puprose of the Signed-off-by: line
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fish <fish.thss@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s8ifRuuLlSpL5ShQ2da970OWjOAQpCCKS
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 25/02/16 13:29, Gert Doering wrote:
> Please re-send (and it would be nice if you could do "git commit -s"
> for the signed-off-by: - David can explain better what the significance
> of that is, but "since we all do it", it's convention)

The reason of adding the Signed-off-by is to have a better understanding
of whom have been involved in particular commits/patches.  While the
"Author field" in the git log (git log --pretty=3Dfuller) can only have
one name, more people can have been involved in the patch.  Using the
Signed-off-by is a way to credit them as well.

And when everyone is consistent using the Signed-off-by line, writing
tools which parses our git log is also far more easier.

The other aspect of the Signed-off-by: line has to do with juridical
stuff, to protect the OpenVPN project.  By adding the Signed-off-by:
line you basically sign-off to "Yes, I am the author of these changes
and I am permitted to share them with the project".  For more
information, these pages explains it even better (same info, two
different sources):
<https://git.eclipse.org/r/Documentation/user-signedoffby.html>
<https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Docum=
entation/SubmittingPatches#n409>


--=20
kind regards,

David Sommerseth


--s8ifRuuLlSpL5ShQ2da970OWjOAQpCCKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlbO+egACgkQDC186MBRfrq0LACfcM6ijX5+c0zzcvDAPd16ICh3
RqMAn1ACpWvc7fF2J7dHzuCykrd4gWmX
=nR2E
-----END PGP SIGNATURE-----

--s8ifRuuLlSpL5ShQ2da970OWjOAQpCCKS--

