Date: Sat, 9 Jul 2016 19:00:45 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160709170045.GR78279@...1296...>
References: <169423fa-c98c-1e3b-42e9-f4bd9165bbb5@...2150...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qgEfXXHyyarqcYJd"
Content-Disposition: inline
In-Reply-To: <169423fa-c98c-1e3b-42e9-f4bd9165bbb5@...2150...>
Subject: Re: [Openvpn-devel] [PATCH: tap-windows6] Implement option to
 disable source IP check of ARP requests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Noel Kuntze <noel@...2150...>
Cc: openvpn-devel@lists.sourceforge.net

--qgEfXXHyyarqcYJd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jul 09, 2016 at 06:16:05PM +0200, Noel Kuntze wrote:
> Attached to this email are 8 patches that extend the NDIS6 TAP driver for=
 Windows with an

Please don't do that.  Squash the change set into one patch, with a good
commit message, and then send that with git-send-email.  *Way* easier to
process on our end.

> diff --git a/src/device.c b/src/device.c
> index 2b9e58e..a13ff4a 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -697,7 +697,7 @@ Return Value:
>              if (inBufLength >=3D sizeof(ULONG))
>              {
>                  adapter->m_source_check =3D (BOOLEAN) ((PULONG) (Irp->As=
sociatedIrp.SystemBuffer))[0];
> -                Irp->IoStatus.Information =3D 1
> +                Irp->IoStatus.Information =3D 1;
>              }
>              else
>              {

... especially avoiding hunks like this one, which really just fixes=20
something that was introduced 3 patches before.

> From f4c5968201a1eff00748f31048509bea8173ad9a Mon Sep 17 00:00:00 2001
> From: Noel Kuntze <noel@...2150...>
> Date: Sat, 9 Jul 2016 00:20:25 +0200
> Subject: [PATCH 6/8] tap-windows.h: Fix accidental reuse of ioctl value.

... and this one...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--qgEfXXHyyarqcYJd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV4EtvKkuBuNlUUl1AQI3IQQAuW4XE5/oWRwOBzxGipqmOXgQtFkL1Opl
9YSSLUHWsfKkQb0o6fNlp6Sr+QRcQDKU/HVPBOcQgdvbJFwrygbW9zMO/eu7jTFq
eALw3OkzYL5vakS+mi8ly3SYdOXz9FfwpHCUH28YwdkH4WjMBrIBVIfpLVZlSyUz
+YDKCBNL7Jc=
=BFhD
-----END PGP SIGNATURE-----

--qgEfXXHyyarqcYJd--

