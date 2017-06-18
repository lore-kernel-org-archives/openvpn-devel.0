Date: Sun, 18 Jun 2017 22:43:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170618204325.GA2343@...1296...>
References: <20170618194104.25179-1-gert@...1296...>
	<201706182035.v5IKZcCt002247@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <201706182035.v5IKZcCt002247@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix potential 1-byte
 overread in TCP option parsing.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jun 18, 2017 at 10:35:38PM +0200, Gert Doering wrote:
> Patch has been applied to the master, release/2.4, 2.3 and 2.2 branch.
>=20
> commit 22046a88342878cf43a9a553c83470eeaf97f000 (master)
> commit 529de430ce07d0c3210a4636b1cb4c89cc6c8fc1 (master)
> commit 4d343fbe9166e14187775567db00c0a91017df83 (release/2.3)
> commit 2cc3583ddbc7ce98d859475422cb4e1c217c8083 (release/2.2)

The second "master" up there is obviously a "release/2.4" - sorry, and
thanks to Arne for noticing.  Too many numbers (try opening up all the
sub-levels in wireshark for a single TCP SYN, then you understand :-) ).

Here's the correct block:

  commit 22046a88342878cf43a9a553c83470eeaf97f000 (master)
  commit 529de430ce07d0c3210a4636b1cb4c89cc6c8fc1 (release/2.4)
  commit 4d343fbe9166e14187775567db00c0a91017df83 (release/2.3)
  commit 2cc3583ddbc7ce98d859475422cb4e1c217c8083 (release/2.2)

(verified against "git branch -v")

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZRuXsAAoJEB2Cnv7KVigS0GwL/12xoVFHy9sHCCHqMWJ8JC+X
90BHGytuprdBXQMuCVccIpTL90JJn7EKAfoWM5wB6yN74KduUELNHkXXvT87lQ/p
4BpBHSUMadV61/Zh/6YAt7LXIOW25bl5Ey3Y98PR+GKE95lIqy5qM3i5lF46BjYV
RG5c1NMhdWeF8ddw0swKEKYxYERyemZ1emCDkf0NaPO6Yndw/EGnxn7kMT5Gv78B
81/NzeiPl09zEPSmHFWNzU3XuzruLEusx90ADX8XSwo2FllZfzwKri2WiSR+rYFf
vocEf9gBuQStosCwdZCX4+2LbQs0BcBCN9xJ1ZiwWeQz3rKhyM5JDbNtxkSpfaU0
40mnBydA+wQnwiIJm5l1+Pn96TDw2+dtLBMsZVYdWE+REskOQkuxRSNoVLOFndpc
GE9p+6mmJPvtfPDNbdwhOB/WGnitXf8Xzrru8++Km1Bfyty8M9J/LDxGDrwBcdjx
wQbxCwOYQ9Ino94vKTKw0dotK9ps0Zkg5XUSdqGz2w==
=gLPE
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--

