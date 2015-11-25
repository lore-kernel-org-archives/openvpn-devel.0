Date: Wed, 25 Nov 2015 15:54:39 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151125145439.GV24952@...1296...>
References: <564BA6DB.4070703@...2070...>
	<564DE8B3.9030803@...2070...>
	<20151124083944.GY24952@...1296...>
	<5654A314.3080607@...2070...>
	<20151124201135.GM24952@...1296...>
	<CAKuzo_jdcOjunyVmpT8er3HqWG7yh6pr+i8Tn8kD3omj=G_Pqw@...278...>
	<565547AB.9030607@...2070...>
	<20151125075416.GR24952@...1296...>
	<CAKuzo_iUzeYSWWvbpyV5RY_FwoNMm=97cfo0-uzeMFQKki3sWg@...278...>
	<5655C387.40805@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HRprdJFjV/kUnvOW"
Content-Disposition: inline
In-Reply-To: <5655C387.40805@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v4-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--HRprdJFjV/kUnvOW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 25, 2015 at 03:19:51PM +0100, Arne Schwabe wrote:
> I am not sure if we want to ship separate WIN XP and Vista+ versions.

We are in agremeent that we do *not* want that :-) - but we *do* want this=
=20
patch to work around Win10 DNS brokenness, and that binary won't run on XP.

Which of the options do we want less...?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--HRprdJFjV/kUnvOW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVlXGNakuBuNlUUl1AQJPUAP8DOMMMN3ksvhbKaNARJWGoN01E9EMkbde
/UIf/aAYFdcfQ1hlswjVIC2V+6xRRa7oPuo7dbVXQW9vkOe4j48ZQp4fsneUzglP
p5fh679fn+W7jSShMVF68t8np9G39oCtkcW9ibqnoInsfLRpw2sPBXI1dPDthvGI
myf3dG0GUO8=
=RcVX
-----END PGP SIGNATURE-----

--HRprdJFjV/kUnvOW--

