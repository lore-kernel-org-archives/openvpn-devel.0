Date: Mon, 2 May 2016 11:47:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160502094733.GQ53051@...1296...>
References: <CAFHpkQENgyAaaWCsWOS1vj+9YR=Cc65muXmsYfmcKc8n09BkPQ@...278...>
	<5727056E.1000701@...515...>
	<CAA1Abx+hbUT6ZpdeCrYVEiRdQ+awA7woZyTm7DD=Lv8OyPDQ2Q@...278...>
	<CAFHpkQFtepY8_FD24+VBWV8e6OAe_Ka=eU_n1yHNpMcP-6YSVQ@...278...>
	<CAFHpkQH448HotUH2JwKAPd2ZD6_8cnAf7Ly8Uvmqhtwv7Akv6w@...278...>
	<CAFHpkQG+gvd9cTMphjp6Y8AnaZ3Vn_2rt=XJaAOvfEA4tuH-Og@...278...>
	<572717AD.8060102@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WSf/+y6apGpKq+5a"
Content-Disposition: inline
In-Reply-To: <572717AD.8060102@...515...>
Subject: Re: [Openvpn-devel] CI for openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--WSf/+y6apGpKq+5a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, May 02, 2016 at 12:02:37PM +0300, Samuli Sepp=E4nen wrote:
> At minimum we should clearly state why we prefer email patches=20
> over GitHub PRs. Then revisit the arguments every now and then, and=20
> adapt as necessary.

"Our workflow relies on public availability of patch and ACK, referenced
by Message-ID:"

Github could go away any day, and then any documentation based on github PRs
is just gone.

Right now, if github (or sf.net, for that matter) goes away, we just push
elsewhere, or set up our own official git repo server.

(I wonder if we should start running our own mailing list archive, and
point *there* for the commit URLs - gmane is down again, which is quite
a bit inconvenient for me)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--WSf/+y6apGpKq+5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVyciNakuBuNlUUl1AQJpQQP/Xs1fOO2sHGAM9VkqMBtGJcW6DQ0T9Q2H
lX/X5cAHPOBDv2SAfth1ZjHJx8vV20T89+3lEE7VbEGU0/jN8OlhtJ4pWdU2mKgu
JcJXLZZlea9ADFQFUkk/JdyeYZhukUevTgXheEQDMp3nyz9KkXPIZcQeJvrHuiNK
Gvkze+DV2nY=
=MlKq
-----END PGP SIGNATURE-----

--WSf/+y6apGpKq+5a--

