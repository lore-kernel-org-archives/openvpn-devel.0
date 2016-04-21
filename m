Date: Thu, 21 Apr 2016 20:18:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160421181857.GL53051@...1296...>
References: <B32C1FDE-D0CF-49A7-A231-28267BB89B46@...2127...>
	<CAA1AbxL3ZRGrig+j9uTdn17NDaM=WGbE4XgZf1nAyvXBxTwfBg@...278...>
	<A4F03DE4-3E70-4815-B4B4-CC185E35CF2C@...2127...>
	<20160421172555.GI53051@...1296...>
	<1C1BCB62-CE17-4A33-BC64-B05B5839EA38@...2127...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7TOCTzdPF11K2/Qe"
Content-Disposition: inline
In-Reply-To: <1C1BCB62-CE17-4A33-BC64-B05B5839EA38@...2127...>
Subject: Re: [Openvpn-devel] [PATCH] auth-pam:Fix buffer overflow by user
 supplied data
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jens Neuhalfen <openvpn-devel@...2127...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

--7TOCTzdPF11K2/Qe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 21, 2016 at 07:48:01PM +0200, Jens Neuhalfen wrote:
> *sigh*. Thanks for finding out && providing the patch!
>=20
> Learning: Try on multiple machines (It ???compiles on my machine [Mac]???=
 apparently is not enough)
>=20
> My test vm (precise) fails with the same error.

Mac is special, Solaris is special, Windows is :-) - all the others are
usually "close enough" as far as C standards and header files go.

If you delve into the ugly details of networking, it's "Linux" vs. "Windows=
"=20
vs. "BSD and MacOS"...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--7TOCTzdPF11K2/Qe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVxkZkKkuBuNlUUl1AQLYfwQAmjiXekXKDXNGdbsDnd6W/1yI+R7LxyHA
Jpib5fGRIooy8faWzObsOC9RtM82WmYynaCjzUFFYxwwMGokVIhWFoKxxI+TFRie
99ZIrLGvvhTERXU6EBOE7eKO9Zftc6Nsc6xfUcARVjy+UbtasdRqpyAq1YVnpdzg
BWrGG+Rh/wk=
=2MlH
-----END PGP SIGNATURE-----

--7TOCTzdPF11K2/Qe--

