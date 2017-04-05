Date: Wed, 5 Apr 2017 08:57:45 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170405065745.GI93896@...1296...>
References: <ee5a8207241568cedcccc4f7f2ea5bc8.squirrel@...2257...>
	<b6bac00d6d7260eea944814b0c995806.squirrel@...2257...>
	<53a21cf3f4e04fcf5d6b9798e04be3ce.squirrel@...2257...>
	<20170404064534.GC93896@...1296...>
	<6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nt+vFqn/aPO6zu0j"
Content-Disposition: inline
In-Reply-To: <063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
 component to --reneg-sec intervals
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>
Cc: openvpn-devel@lists.sourceforge.net

--nt+vFqn/aPO6zu0j
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Apr 05, 2017 at 06:34:34AM +0200, Simon Matter wrote:
> I've attached v2 now which works without any config change:
[..]
> I prefer this version as it allows everybody to profit from it without
> touching any config files.

I can see the reasoning, but 25% feels a bit on the high side :-) - so
let the ratholing begin what the number should be.

Steffan, any views from the crypto side of things?

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--nt+vFqn/aPO6zu0j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJY5JVoAAoJEB2Cnv7KVigSQHYL/RJ+QXzQJ4zqg3kIsQ9eVUxi
MM/iKs3C256wvIkXIonjhspYQiNBBni2UeFRb557NplD3aC6tI51QjB9gMwNiYYJ
tOz9FL8hm8ZJirMrHrfzKQ59Yvifu6IORrvag0xYa4gTZ4WU0RWfV3bryWiqORyI
DafclMTDCvW4tFRHh7hTMIsbeqiq8cZOB4aJ0SWqpMEHMkyuGawMR4Fe4jBxqdL9
0OeLNeM4Izgmm1rdudFIJ3zPUGsvtNplkmLQZ/wCGXFbjB7Gsf+BnTZQrSQM0JpD
6p/PtUR9VaUA1leZzUixzFvkdN6N2wJFfWTIeH6KhtHbmYCKb9ReT+ZtSTJDlzkT
HneMFTT+PeeO1qA/rgq4zaTrwdmXgjOfdywLDWPVJ+uJbwSCKsmn9YYQzzxw7vlr
xq3aKTEjiFbNK7Q3/odWY1IoFchFToXkLuwW7W/Yc+9jXeMRYX7nkS9JLZ3wuOLV
dt5ltwTDCkvGR1RFpkg3kBFQW3NV/4IaQMZhKeM4Dw==
=d9Xc
-----END PGP SIGNATURE-----

--nt+vFqn/aPO6zu0j--

