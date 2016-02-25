Date: Thu, 25 Feb 2016 13:04:15 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160225120415.GB24952@...1296...>
References: <1456171237-43673-1-git-send-email-fish.thss@...277...>
	<1456173717-45378-1-git-send-email-fish.thss@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ldkySQ/AwNMpyl5X"
Content-Disposition: inline
In-Reply-To: <1456173717-45378-1-git-send-email-fish.thss@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3] Make openvpn and openvpnserv
 compilable under Visual Studio.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fish <fish.thss@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--ldkySQ/AwNMpyl5X
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 22, 2016 at 03:41:57PM -0500, Fish wrote:
> Compiled under VS 2010/2013 and Windows 10.
>=20
> The following major changes are made:
> - Remove all runtime function resolving code since OpenVPN 2.4 is
>   targeting Vista+.
> - Make sure local header inclusion uses double-quotes instead of angle
>   brackets.
> - Update openvpnserv.vcxproj to include new source files and headers, as
>   well as additional lib files.
> - Include <netioapi.h> in two source files.

I'm all willing to merge this (it makes sense) but want to ask you for
a v4 nevertheless - I've just merged & pushed Selva's "validate options"
patch, which adds new source files (validate.c, validate.h) so more=20
changes are needed.  So it would be nice to have this all in one slightly
larger change set...

(The patch itself looks good, it just conflicted with the other change)

thanks,

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ldkySQ/AwNMpyl5X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVs7tvqkuBuNlUUl1AQJzXwP/TPcBK1/pi83F8Lr2j9GkbipxxFysnvNv
0CX9pg7IKIaF9XotvQmVdnBvYlaa82Dl4PIhMLop5mKCoNyI81y3qa03vo/QqKyY
NFxDM1ZwrC0FIJqD6I8RvBVSz/JiIf8MFccOGJ/5AlD6gzK81aU5gmsWvBI7ljAr
qDZ/5eeMvsM=
=nWxX
-----END PGP SIGNATURE-----

--ldkySQ/AwNMpyl5X--

