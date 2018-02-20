Date: Tue, 20 Feb 2018 20:59:20 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180220195920.GQ69387@...1296...>
References: <1511026858-23281-1-git-send-email-selva.nair@...277...>
 <1511026858-23281-2-git-send-email-selva.nair@...277...>
 <20180220161429.GB69696@...1296...>
 <CAKuzo_iDwg6YJX4GaXPOU8tGhRoKL3-025N9=a+jNwDaZWSy2A@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fKMJiToQsVzOkqLC"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iDwg6YJX4GaXPOU8tGhRoKL3-025N9=a+jNwDaZWSy2A@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Make most registry values optional
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fKMJiToQsVzOkqLC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 20, 2018 at 11:19:23AM -0500, Selva Nair wrote:
> Hmm.. I thought I had tested the patch.. Looking at it right now -- hold =
on :)

Missed you on IRC...

18:21 < selvanair> cron2: iservives in 2.4 local build and snapshot build w=
orks=20
                   on Windows 10. Have to go now, but will test Win7 later=
=20
                   today when I can get hold of a one.
18:22 < selvanair> s/iservives/iservice

... seems this is different on Win7...?

To be sure it's not something messed up on my system, I have checked
the HKLM\Software\OpenVPN\(null) path that it's trying to access - and
all is there

(standard)  REG_SZ  c:\Program Files\OpenVPN
config_dir  REG_SZ  c:\Program Files\OpenVPN\config
...


and according to the documentation in

https://msdn.microsoft.com/en-us/library/windows/desktop/ms724868(v=3Dvs.85=
).aspx

passing "lpValue =3D NULL" really should work...  the error code 0x57
OTOH is documented as

	ERROR_INVALID_PARAMETER
	87 (0x57)
	The parameter is incorrect.

... which isn't exactly helpful to see *which* argument it does not like=20
- everything *should* be according to specification...

(It does happen for my own binary and for the installers Samuli builds,
so it's not "my build environment" - theoretically it could be part 1/2
of that patch set, which I haven't run yet)

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--fKMJiToQsVzOkqLC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJajH4YAAoJEB2Cnv7KVigSzpQL/Atjmi0vkZ1P75vK2zIsueVC
kkWVogTRu7Sb0m2GzRkuxrwNC9xgzLTmYL6FZD8D5Lby/SvX1EnvQbjbEv/s5pzf
+pGT24MHw0ZDUYZ6H56x1CQVd9TAB4Kx+YtmZAN59YCbYc7W5y5G7Cyno1SL9K0G
3ptjVgy0jDHKlLHIAwuqcSceiLrjw3ja1Myv2M7/a+eBRt10iisJID+Kitw/KyoK
MFD9JlDQUtu5+m+YaDvVYItjnUqhIrWx9etVOoXMlxr/6NtoLOw052vS7wCemjhi
oqo9ZBlNQR+IAakK1hMaj6PT1YwNc69H/djKhOzIqe/HfPXEVS4CRjMkiLiWNLYT
Ff+OhPNe3uOGgVduneseGMGCemMytjHEhg9i9o8TbVOZKZOCXltJP61Ut6Y5SMkr
BEN3BONXeBL/S6gA22MzSjPLkDc+PWgOxgo3VZNrCCXW/BATInp54k4D0xtOGa63
/nBrVQz/vYKAL7trlf+B54XIiLanE+xoQ97wRQtYGw==
=e6a1
-----END PGP SIGNATURE-----

--fKMJiToQsVzOkqLC--

