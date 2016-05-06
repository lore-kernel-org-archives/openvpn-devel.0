Date: Fri, 6 May 2016 11:30:29 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160506093029.GW53051@...1296...>
References: <572C454A.1060901@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GqkYCIxWRddlF0H7"
Content-Disposition: inline
In-Reply-To: <572C454A.1060901@...515...>
Subject: Re: [Openvpn-devel] Installation failure with
 openvpn-install-2.3.10-I003-i686.exe on Windows XP 32-bit?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--GqkYCIxWRddlF0H7
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, May 06, 2016 at 10:18:34AM +0300, Samuli Sepp=E4nen wrote:
> I received a report on IRC that "openvpn-install-2.3.10-I003-i686.exe"=20
> installer fails on Windows XP 32-bit with
>=20
> "This installer only works on Windows Vista, Windows server 2008 and abov=
e."
>=20
> Can anyone else reproduce the above problem on Windows XP?

Yes.  Happens on my XP VM too.

(It first refuses to run at all due to "unknown signature", but that is
easily fixed by right-clicking and permitting execution, but then this
error message shows up)

> The openvpn-build commit that made this error possible was 65e328c:
>=20
> <https://github.com/OpenVPN/openvpn-build/commit/65e328c89182c47d1a93398e=
04ca92199bf17af3>
>=20
> However, as it states in the commit log the code path was tested before=20
> merging it.

Was it ever tested on Win XP?  Seems the branch "has_tap_windows:" isn't
taken...

If you need someone to run test installers that print more diagnostic
(like, "what is in $0, and what is ${TAP_WINDOWS_INSTALLER}?") feel free
to throw stuff at me.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--GqkYCIxWRddlF0H7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVyxkNKkuBuNlUUl1AQLvDgQAjVSQPAbw8eMinn5wp7uQ5NjcGAzyf/TF
crjGSEYXT43bTAsmfXMlBoKL+rAwKEwja/rpiSmWwHg9sTi9bgUkpux4WK5pzEUG
29D+NABZbUR1/hf9wMs+LwZZnL5yni2wOWD3IkxlPqMB3rkUl7DiP844KE1h6ZQr
ab8/O6iTfvo=
=EqSN
-----END PGP SIGNATURE-----

--GqkYCIxWRddlF0H7--

