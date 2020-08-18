Date: Tue, 18 Aug 2020 20:18:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200818181820.GZ75094@...1296...>
References: <CAAWBBYPw=TZg1wftWZL5ABKVWkp7=6hpdaumLN2D24Cgr-E4pQ@...278...>
 <20200818062335.GV75094@...1296...>
 <20200818063212.GW75094@...1296...>
 <CAKuzo_jEGvTnkbsgJVm5beW5SapWoy_xLk_LA+-N59oa6SbbkA@...278...>
 <81A6F618-2F74-417F-A476-BF290CCFF143@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3199z2xwsLUuj0Hj"
Content-Disposition: inline
In-Reply-To: <81A6F618-2F74-417F-A476-BF290CCFF143@...277...>
Subject: Re: [Openvpn-devel] 2.5-beta-1 Wintun requires SYSTEM privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marvin Adeff <volleynbike@...277...>
Cc: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3199z2xwsLUuj0Hj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 18, 2020 at 08:55:31AM -0700, Marvin Adeff wrote:
> > An additional check in openvpn.exe whether it's started as SYSTEM could=
 be
> > useful as well, but less critical, IMO.
> Yes Please!  We run 2500+ systems that run it this way as SYSTEM.=20=20

"this way" is quite a bit unclear here - in the thread context,
"this way" would be "run from the GUI", which never runs as SYSTEM.

Can you elaborate a bit more how you run OpenVPN?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--3199z2xwsLUuj0Hj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfPBtsAAoJEB2Cnv7KVigSqvoL/RJiup13ojWEwmpXh7BYRe3i
3vb8CHw+pSa0pr9LPTHWIEkWzhXGnSVOJ9xrTBgq28V+/Z5a6PCW5+uGFC+MQaig
GTFyO+zXiV+ZirzGOn+dj+R6MvyUQBDetKWHeBkzhdzyozCIR4ou9Z8P8Ix8KCgs
XnzCLCpUowZ20js7EcdNtjbiGzqG0hsO6Q45Ah5hDbiURr4X0TTm+Q27Yu0jF4X6
uZRQdkyu+nu1OAqbJpWJfzCE14lHSIOlLGZI3dDJyYypXMKew0ISqxneH0uRw3CM
s5D1KB+hMI33zyCEdapTAWyFyjgpsoboXln6MR1R0J8MWIC/trBL9str/krN6w50
9sEcJbeks/pLR+nbpxbcLA8+IkuN56oA8ZPtIpuRwEHhGiEmNdXUUurxuycYcuKh
iadoaZo5it7p7x74o1gvEiRfHvdnczd8RiasZBD0UZznHC4xguz0LyKqcxyAgc2p
x/xWhUs33ONCB34g8R9+5JVJA5M+hxF0TYXQ0YCe1A==
=75Sj
-----END PGP SIGNATURE-----

--3199z2xwsLUuj0Hj--

