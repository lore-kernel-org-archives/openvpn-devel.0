Date: Mon, 22 Oct 2012 10:48:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20121022084853.GF742@...1296...>
References: <CAEsd45Q6PbNZoutzKMXVP7xPSEmb0C3A3jQEQYidcTRGJaXTmQ@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6IGTAXksYJqONypD"
Content-Disposition: inline
In-Reply-To: <CAEsd45Q6PbNZoutzKMXVP7xPSEmb0C3A3jQEQYidcTRGJaXTmQ@...278...>
Subject: Re: [Openvpn-devel] Bug in program, bug in documentation,
	or something else?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--6IGTAXksYJqONypD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jonathan,

On Sun, Oct 21, 2012 at 06:40:08PM -0400, Jonathan K. Bullard wrote:
> A Tunnelblick user has reported odd behavior with name resolution failure=
s.
> I can't tell if it is a bug in OpenVPN, a bug in the documentation, or
> something else. The behavior is apparently the same in OpenVPN 2.2.1 and
> 2.3alpha1.
[..]
> Any ideas if this is a program bug, a documentation bug, or something els=
e,
> for example, a problem that only occurs on OS X?

"One of those" :-) - I don't know yet, and haven't looked into the code yet
(will do ASAP).

The resolver code has been changed for 2.2 (getting rid of the old
randomization stuff), so it might be a bug introduced there, or a much
older bug that nobody ever noticed.

Do you have an OpenVPN log that shows this behaviour?  Might help in
digging down to it...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--6IGTAXksYJqONypD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUIUIdKkuBuNlUUl1AQIr2gP+L8WbYYi8iCd9dILHKNKM+4p0K5nCFN18
4XGjnQDkEEAYbPr4nHy6vzbqmkTrxMehp7cAVz4WVHpdQacK0Govfa3VPFK7YV6B
B/HCDy1QWqTkOTIKqT7R6mM/pooSJfrbvGZXnGNTb7+YCBBAJqfWJI4mWrOzCuf4
y8YmrLFLTBQ=
=PXzF
-----END PGP SIGNATURE-----

--6IGTAXksYJqONypD--

