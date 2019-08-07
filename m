Date: Wed, 7 Aug 2019 13:17:14 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190807111714.GT1097@...1296...>
References: <CAKuzo_jTwnNZ_5QtFo8YqUyWWhEJWBCYgnO_xAqEaNkumGPgrw@...278...>
 <1563873663-25785-1-git-send-email-lstipakov@...277...>
 <CAKuzo_j7SxL_6Aerh9vnBDOgU20VteOCvH=da1yxK73Y1a-xLg@...278...>
 <CAGyAFMV2k0OWM6G9tH=CcMt9-yQ0hu-vLT7HP7o90mPZXkwG6A@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5NVDATmc8A1f9nDP"
Content-Disposition: inline
In-Reply-To: <CAGyAFMV2k0OWM6G9tH=CcMt9-yQ0hu-vLT7HP7o90mPZXkwG6A@...278...>
Subject: Re: [Openvpn-devel] [PATCH v6] openvpnserv: enable interactive
 service to open tun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5NVDATmc8A1f9nDP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 07, 2019 at 02:12:01PM +0300, Lev Stipakov wrote:
> So instead of having IPC call "open_tun_device(path)" it is probably bett=
er
> to have something like "open_wintun_device()", which both figures out
> device path
> and opens device.

That sounds like a plan.  Have one API call for tuntap, and one for
wintun.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--5NVDATmc8A1f9nDP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdSrM6AAoJEB2Cnv7KVigS8wcL/i6d7YgALnmiUu0fFrVTZ40a
ScWgPvQgKyVA0PcAWXejLDtaGpjJoDQMJ8VvnKvcJFmHm1jnU3TmEGHypJ6jCN2W
Cxe4dG0fAdhXPrw040BnGhODjpXdYipccwV8yWVT4masCTUGXxoakNNiyjftVcVQ
4Cklh4VhTDfZTTt7DVFB21ENsvDifZ/Qy9OO7HxhZurhOoD006gTi7AK9Cr5z4+o
Mb/v6BVSX3DDibDgwHkfHcu3pSbVYeWzi4igtKD6yTjDovsYZ9LfnBUB5yt34phe
33+p0/CW9C81MKBykQSZw+hub8OwGS1GYseoTeJegyWGmckZOJkp2cOyhBd5fEbc
sijpOI1PJ3UZPIfpxzBYkzTiJWnEnpCbKrhhw3VSMBsLqKeRWeJEugoaZFIfHrfm
WQlXyHuGYA0gbFwEUghbwdzQxPQMyV+k3+ijoOhOa6Z+4gKWvh2Yhyh/lBnndlJK
Zs/c416M4Hf/9razRVwEQ4oATpM3se3goMDugMV1Og==
=uYCF
-----END PGP SIGNATURE-----

--5NVDATmc8A1f9nDP--

