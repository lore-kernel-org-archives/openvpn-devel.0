Date: Fri, 11 May 2012 08:41:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120511064110.GU1359@...1296...>
References: <CAArKS8hPVLQSNrX4HtB+6UA+UU-63PmyN0BNmFuPdu4W0ZFEMw@...278...>
	<20120508073716.GM1359@...1296...>
	<CAArKS8gibawt-LNQws_7iiewyhAkH6TborXMiamsn1WqbLSr4g@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uFSSoCA2+0++ptqO"
Content-Disposition: inline
In-Reply-To: <CAArKS8gibawt-LNQws_7iiewyhAkH6TborXMiamsn1WqbLSr4g@...278...>
Subject: Re: [Openvpn-devel] OpenVPN in the Hypervisor
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tom Kent <lists@...1718...>
Cc: openvpn-devel@lists.sourceforge.net

--uFSSoCA2+0++ptqO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 10, 2012 at 08:45:04PM -0400, Tom Kent wrote:
> The other thing I tried was to have openvpn up and running, then to attach
> the VM to the tap0 device that it created...that ended with this error:
> libvirtError: internal error Failed to add tap interface to bridge. tap0 =
is
> not a bridge device

Try what David suggested: creating a bridge device.

Start OpenVPN with "tap0", then run=20

  "brctl addbr br0"
  "brctl addif br0 tap0"

and then have libvirt attach to br0.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--uFSSoCA2+0++ptqO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT6y0hqkuBuNlUUl1AQJO/QQAqIWBvI27rmF7ppAWfDRubkIG2IV2OIjy
nIYMttnPZURZFI36pUW7pr4YCKfkwBLKQNAPfTqrrEo/G8+S/gXdLhjxeMFzZuxt
0//e9ACAXkjnXCa/Y9vB16JP/w5ieD/4h1KQqbVlfl7ttTpCFzcC+SIPakiQT9G7
Xs4Y4Br9/Q0=
=USz+
-----END PGP SIGNATURE-----

--uFSSoCA2+0++ptqO--

