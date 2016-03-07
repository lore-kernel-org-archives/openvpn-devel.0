Date: Mon, 7 Mar 2016 09:04:15 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160307080415.GZ24952@...1296...>
References: <CAKuzo_jrTKkAWGv7gRoADPWz5VTDFPqfrHxUDppPuQ63Y+RFKA@...278...>
	<20160306214850.GY24952@...1296...>
	<CAKuzo_ic11Et-56qi4OR62hErRaE1E=qcDyyP8kuyExkecEi6g@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tUoukL4yPdgSjtW8"
Content-Disposition: inline
In-Reply-To: <CAKuzo_ic11Et-56qi4OR62hErRaE1E=qcDyyP8kuyExkecEi6g@...278...>
Subject: Re: [Openvpn-devel] operations that still require elevation on
 windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--tUoukL4yPdgSjtW8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 06, 2016 at 05:03:21PM -0500, Selva Nair wrote:
> Oh, I missed that. Based on the Trac ticket (#71) discussion on fatal err=
or
> after sleep-resume, which was apparently caused by netsh failures treated
> as FATAL,  and seeing some comments that ipv6 setup needs to use netsh
> command, I just assumed this is not done. Sorry for jumping into that
> conclusion.

Trac#71 is way before iservice was even on the horizon :-) - and yes,
OpenVPN itself only uses netsh.exe today, "because this is all I had,=20
back then on Windows XP".

When discussing iservice and IPv6, we decided "back then" that iservice
should not care about WinXP - because we do not have the permission issues
on XP anyway (it wasn't clear back then whether OpenVPN 2.4 would support
XP or not, but we decided that we do not need XP support in the iservice).

> Then its only register-dns that remains...

Yep.  Its semantics are not totally clear to me (the code does more, like
turn off dns cache off/on) and I have no idea whether there's a real API=20
for that...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--tUoukL4yPdgSjtW8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVt01/qkuBuNlUUl1AQIG9QQAltzPUzNYjduto+fFevLQ5IzYlXNPjUO4
Gl7BMx/ekmYoP6iELgmY9vZhq+zleLzMuzZXfhssMgZTdtmeZ9+rs1B+DzjFMeNV
iQm3MT8pWPmefrA6K5+ZXva5Z8tEyGDtFBs22XhAzbyJNHn+zzVbsGNkp9zcXq8K
an2UqurhNvc=
=/zWy
-----END PGP SIGNATURE-----

--tUoukL4yPdgSjtW8--

