Date: Mon, 16 May 2016 14:03:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160516120332.GH53051@...1296...>
References: <5731B295.4040301@...515...>
 <5736E6CF.7030205@...68...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5kMEDl2nh7y6XqcI"
Content-Disposition: inline
In-Reply-To: <5736E6CF.7030205@...68...>
Subject: Re: [Openvpn-devel] OpenVPN 2.3.11 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

--5kMEDl2nh7y6XqcI
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, May 14, 2016 at 10:50:23AM +0200, Matthias Andree wrote:
> Am 10.05.2016 um 12:06 schrieb Samuli Sepp=E4nen:
> > The OpenVPN community project team is proud to release OpenVPN 2.3.11.=
=20
> > It can be downloaded from here:
> >=20
> > <http://openvpn.net/index.php/open-source/downloads.html>
> >=20
> > This release fixes two vulnerabilities: a port-share bug with DoS=20
> > potential and a buffer overflow by user supplied data when using pam=20
> > authentication. In addition a number of small fixes and improvements ar=
e=20
> > included. A full list of changes is available here:
> >=20
> > <https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn23>
>=20
> I was wondering... do we have CVE references or similar unique
> identifiers, which I could then use - for instance - in the FreeBSD
> vulnerability database?

Not for these two - these sound scary, but are really edge cases that
are very unlikely to be a problem for most users in practice.  So we
didn't go out and fetch a CVS number - maybe we should have, but we're
still learning.  And we need more people to do the routine chores, like,
"organize proper handling of possibly security relevant patches"...

After release, I saw a note about Fedora issueing updates, which referenced
"OPENVPN-2311-1" and "OPENVPN-2311-2" - though I'm not sure if these are
Fedora-assigned or DFN-CERT...

https://portal.cert.dfn.de/adv/DFN-CERT-2016-0739/

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--5kMEDl2nh7y6XqcI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVzm3FKkuBuNlUUl1AQLlXwP/RIfh1s1v5OqBoeCudWWSsmgwTb6LIUWo
PtNnMhz8woE2oIrSZxyVk0Pj6kscY1kB4g64cCjmb7fHBad54h9v7GSjc0gnEYsE
sWFolw5gV4Sj1eT0pqJfWzuTVP66o/Njp1TMRliC4CZceFKHxQYe2THz3YFcLj6x
G8V2RuPlT1Y=
=bUnR
-----END PGP SIGNATURE-----

--5kMEDl2nh7y6XqcI--

