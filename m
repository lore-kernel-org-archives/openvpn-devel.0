Date: Sat, 17 Sep 2016 12:05:41 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160917100541.GR78279@...1296...>
References: <1474105455-26414-1-git-send-email-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RfsCC5usvn/kAfha"
Content-Disposition: inline
In-Reply-To: <1474105455-26414-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] t_client.sh: Add support for
	Kerberos/ksu
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--RfsCC5usvn/kAfha
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Sep 17, 2016 at 12:44:15PM +0300, David Sommerseth wrote:
> +        else
> +            RUN_SUDO=3D"ksu -q -e $*"

NAK :)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--RfsCC5usvn/kAfha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV90VdakuBuNlUUl1AQKI8wP9F/ZBF8bz9oTTz4sIgEmHlMNbeYMv2mmz
kcT4B+NTM8NqFBzq0tb6k9Q3KtKXisuTFlsVWBGZcnbaEVEJkWFzrAfoy0128J9w
VmXp5wBuJlyy8xnYJp6feqU4vbLXPESGVmAMedRWMlyQ+URIG8cKTBNR9I72JzAu
yxjajLwdmsg=
=rQBH
-----END PGP SIGNATURE-----

--RfsCC5usvn/kAfha--

