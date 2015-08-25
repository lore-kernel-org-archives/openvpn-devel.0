Date: Tue, 25 Aug 2015 14:04:45 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150825120445.GG34798@...1296...>
References: <55DB4C39.9040105@...2010...>
	<CAD2Ti2975xFpu4FrozJgptc4nti3V7aXGebZGfnRS1ynTgaZyw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cnBsrynPgIOyCJkL"
Content-Disposition: inline
In-Reply-To: <CAD2Ti2975xFpu4FrozJgptc4nti3V7aXGebZGfnRS1ynTgaZyw@...278...>
Subject: Re: [Openvpn-devel] Log cert serial no if it is revoked
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: grarpamp <grarpamp@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--cnBsrynPgIOyCJkL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 25, 2015 at 02:38:20AM -0400, grarpamp wrote:
> Cert serial numbers found in the wild are hardly unique (witness

They are not "in the wild" in this context, as the issueing CA in
OpenVPN contexts is typically in-house - and serial numbers for certs
issued by a single CA(!) *are* unique.

If the cert cannot be verified at all (not revoked, but "issued by
another CA" or "not signed at all"), I agree, the serial number does not
carry meaningful information - but this is not the case this patch is
about.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--cnBsrynPgIOyCJkL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVdxZ3KkuBuNlUUl1AQLrSgQAxHl8cxnjdUjrLVPmhZBoriz75gw3slA4
lS7Jz9ZlrUwn1u0lFtx9QsXm+LUDzdYEK5WfqUQyn4pI5mIkC6new6QfM6bLdZ3O
oUknMeX2b0VlKxTYOShKYgZznKS+K4nURFas3Lv8PVank3sr/mXhYNnJmvMHwXPi
usdDC8KsCzc=
=a0PC
-----END PGP SIGNATURE-----

--cnBsrynPgIOyCJkL--

