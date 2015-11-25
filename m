Date: Wed, 25 Nov 2015 08:52:45 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151125075245.GQ24952@...1296...>
References: <564BA6DB.4070703@...2070...>
	<564DE8B3.9030803@...2070...>
	<20151124083944.GY24952@...1296...>
	<5654A314.3080607@...2070...>
	<20151124201135.GM24952@...1296...>
	<CAKuzo_jdcOjunyVmpT8er3HqWG7yh6pr+i8Tn8kD3omj=G_Pqw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zp4J6pIOF3L3ZAe7"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jdcOjunyVmpT8er3HqWG7yh6pr+i8Tn8kD3omj=G_Pqw@...278...>
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Zp4J6pIOF3L3ZAe7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 24, 2015 at 07:13:17PM -0500, Selva Nair wrote:
> Not sure I understand this.  The patch I had tested all along had ifdef
> _WINNT_WIN32 >=3D 0x0600 around everything. So the code nicely silences
> itself when built for XP (I did not try this though). I built only 64 bit
> version for vista+.

That was the v3 patch, and we decided that we always build master with=20
VISTA+, and do not want extra #ifdef's if we can avoid them.

> And this was against the master. Now the new sets of patches have differe=
nt
> ifdefs: _WINNT_WIN32 >=3D 0x600 for 2.3, and if defined(WIN32) for master.
> This appears unnecessary. Two patches are still needed as some context
> lines have changed between 2.3 and master, but the code could be the same,
> and, in particular, the ifdefs could be just _WINNT_WIN32 >=3D 0x600.

No #ifdef if they are not needed.

In 2.3 they are needed, because we need to build for XP and Vista+ - in
master, XP support has been dropped and we always build Vista+, so we do=20
not need the #ifdef bits for _WINNT_WIN32

I'm not sure why we grew #if defined(WIN32) though...  that might be due
to "other platforms do not have the functionality at all, so we should
not pretend to understand the option" (comment from Arne).  But maybe
these should be #ifdef HAVE_BLOCK_EXTERNAL_DNS which itself is=20
conditionalized on WIN32 today - it might appear for other platforms,
who knows.  No really strong opinion there yet.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Zp4J6pIOF3L3ZAe7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVlVozakuBuNlUUl1AQJnFAQAj6RwLKEcs8W68HVC6hu6OBVvFheaYsog
K2R42rW6xbjXHs0Z4y9FTswPsbsjJYVzQXRR54I+rZnpYz+PrZsCf5HZLLL2gptF
EON70ST7bS6dRL0g4VYEejsaSCnFIzTTwxYIVxUPNU8IzGsF8iHSZTtN2eZhh0Ac
qFuck7+C5CQ=
=z804
-----END PGP SIGNATURE-----

--Zp4J6pIOF3L3ZAe7--

