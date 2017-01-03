Date: Tue, 3 Jan 2017 18:17:47 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170103171747.GR78624@...1296...>
References: <1483152307-15687-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EbMW37mHYzw0qvy8"
Content-Disposition: inline
In-Reply-To: <1483152307-15687-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Always release dhcp address in
 close_tun()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--EbMW37mHYzw0qvy8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 30, 2016 at 09:45:07PM -0500, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> Also make sure --dhcp-pre-release results in not just dhcp_release()
> in open_tun() but a subsequent dhcp_renew() as well. Else dhcp transaction
> gets aborted as this call to release() happens after the adapter status
> is changed to connected.
>=20
> Alternatively, the undocumented --dhcp-pre-release may be removed.
>=20
> Fixes Trac #807 (but can't say the same for Trac #665 without knowing
> how to reproduce it)

After thinking about this for a while, I agree we should do this, so
ACK (even if Debbie10t already has ACKed it).

I'd ask for a few changes, though :-) - if I'm reading this correctly,
tt->options.dhcp_release is now unused, so I think we should do it
all the way - get rid of that flag variable, print a message=20
("obsolete option detected, already on" or so) if --dhcp-release
is configured, and update the man page ("this option is a no-op now,
as the functionality is enabled by default starting in 2.4.1").

I'll take care of Changes.rst as these will differ 2.4 <-> master and=20
make cherrypicking a patch more annoying than necessary.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--EbMW37mHYzw0qvy8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYa9y7AAoJEB2Cnv7KVigSOdAL/2VT5vjpSZqi6+XrlRcJqkIJ
AC1hfXKpWjv1mm6ufZBeCQxEkGjjS4Hiwq4L77X/LpBzAzPne6B7Cj0l9Laizu4B
DZYga9dQWUPImSwpkCcIR1O6pX28Ln2oo/+mhccvBlkWAH5X0VtvoURNFCZGNTXt
LrlbLJYKAnFFumHSWnpW53pHOCuuOSyZnrdaeQoI0MDOYz9awD68vSngu6ihTmpP
Ntn5qaldEnQScg0C1UgcymNZTzJZWN8lk80nvgZPlXf39Pjowfz9WOlr2eWMqf/h
hawBfZYiQmdEgfTnV6qNfEouhQFm8eEF3ajUMBErM/CMZS08Ee/OrPj3TaGvF+Xf
q0lp6WPVmfbDhjl0q4UxzVTanHDz3GOs1LClMgrJgE9jmD9p4CgvNBf057DquL9a
IkdNO4pDtNu/zz2wHTHR+qVYBIOsueC+1LOj4SoIV3Xx0v7cgiUqZikd3eGzpLO0
+h5o9M052PnzpxXrYXQQhiCTYKSDnjHTV/Dm97SJUA==
=WGFd
-----END PGP SIGNATURE-----

--EbMW37mHYzw0qvy8--

