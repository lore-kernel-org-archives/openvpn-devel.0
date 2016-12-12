Date: Mon, 12 Dec 2016 20:44:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161212194442.GQ78624@...1296...>
References: <20161209181303.20267-1-list@...1798...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jiGx5cYVmJx/T6kL"
Content-Disposition: inline
In-Reply-To: <20161209181303.20267-1-list@...1798...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] add more security features for
 systemd units
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>
Cc: Christian Hesse <mail@...1798...>, OpenVPN Development <openvpn-devel@lists.sourceforge.net>

--jiGx5cYVmJx/T6kL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 09, 2016 at 07:13:03PM +0100, Christian Hesse wrote:
> From: Christian Hesse <mail@...1798...>
>=20
> ProtectSystem=3Dstrict mounts the entire file system hierarchy read-only,
> except for the API file system subtrees /dev, /proc and /sys (which can
> be protected using PrivateDevices=3D, ProtectKernelTunables=3D,
> ProtectControlGroups=3D).

Unless the temp directories are still writeable, this will break=20
server configs with --client-connect scripts or plugins trying to hand=20
back config settings via temp files.

(I do not think an openvpn *client* config will need a to create
files, but this needs testing)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--jiGx5cYVmJx/T6kL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYTv4qAAoJEB2Cnv7KVigSd00MAKPMrXbpin9OcwgbUckMdgfs
+24BxBxYwQ2PhDmawMIyJw+mtb0sWd6dmeDOl4u7SDPK6+dW3q6g7O9xTgxnkhvN
SW6o+7+VUDSTV9iPm8BVDoMhLbFJXgWla7cbw+gf/eQuXjFBZcIrYS41MOoYJdam
gTnkdBvqsfsBsIJLVTY+blKtfNVOKePMtGE99oQYjOMGUZENfVwmkXeRkZAOKkQS
0n/GJa3RnIxxo9doVomN5i4YDkdnCuBPg+6vMbsO/mJVPqmJDwRrol1sEPsY3GK4
WNIjjCuzAJfuRMwcQXycFHSyB1kM/IcHhT6oV1sU1E5sEewPO4V4oXhv1QEUgwHM
vIJvG9/mn65StSBm5QZVOjRFtWXJkSgQZE8AiMt9D0Inmeys+0T5iEoImmfwKUJs
PPa2R2YRUj+U5YNA7GLrCeKXIf51XG4oiBhXVcpdlbKTxQLMOdy9UcxWTHrTnU/2
d8+55W0wpJjpzYWBcI4eLxHiSiKkZu8TSdNBFSAsVg==
=KncT
-----END PGP SIGNATURE-----

--jiGx5cYVmJx/T6kL--

