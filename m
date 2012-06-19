Date: Tue, 19 Jun 2012 13:04:35 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120619110434.GX1059@...1296...>
References: <1340044749-10694-1-git-send-email-arne@...1227...>
	<1340044749-10694-4-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lqtP4FxvQo6hb6bg"
Content-Disposition: inline
In-Reply-To: <1340044749-10694-4-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 3/6] Remove ENABLE_INLINE_FILES
	conditionals,
	this code is always enabled and removing the #ifdef make the code a
	little bit clearer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--lqtP4FxvQo6hb6bg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 18, 2012 at 08:39:06PM +0200, Arne Schwabe wrote:
> @@ -95,9 +95,7 @@ typedef unsigned long ptr_type;
>   * A sort of pseudo-filename for data provided inline within
>   * the configuration file.
>   */
> -#if ENABLE_INLINE_FILES
>  #define INLINE_FILE_TAG "[[INLINE]]"
> -#endif

I'm generally OK with this, as the mass of #ifdef in the code really
make everything hard to read.  Formally, I'd like to see an ACK from
James, though, as this is "his code base" and maybe there is indeed
some use case where ENABLE_INLINE_FILES is not desired.

Samuli, can you put these two (3/6 and 4/6) on the next meeting agenda?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--lqtP4FxvQo6hb6bg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT+BcwqkuBuNlUUl1AQI9jwQAjIT+ErZMDjHcsmlTiCO2S/h/yCXzZkod
iN08N4zCBWK3c/4GhkaRrJ0SQzUZcWeysKTvNbvIO9Y+dPiB2lyL7lB9E0CVQ6a7
NcTwlgVudimtw7VxpCqWs9sbtWSAIG4VkoEep4q1A9fetf+23YVtHa9SByHzu+Ft
eF3Y2cJkiNc=
=nUSV
-----END PGP SIGNATURE-----

--lqtP4FxvQo6hb6bg--

