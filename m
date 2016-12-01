Date: Thu, 1 Dec 2016 09:01:32 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161201080132.GC78624@...1296...>
References: <1480545687-19365-1-git-send-email-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <1480545687-19365-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] push: Provide a warning if
 --ifconfig-push have argument mismatch with --topology
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

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 30, 2016 at 11:41:27PM +0100, David Sommerseth wrote:
> +      if ((c->options.topology =3D=3D TOP_SUBNET || c->options.topology =
=3D=3D TOP_NET30)
> +          && (c->c2.push_ifconfig_remote_netmask & 0xff000000) !=3D 0xff=
000000)

Are you sure of that?  I would assume that this is stored in network
byte order (as it's an in_addr_t) so you can't directly compare it to
a number but need to run through ntohl() first.

On *intel* it might end up being the same, but code dealing with IPv4
addresses and ports always needs to be checked on both endiannesses.

Some random code I just found in a BSD header file does it that way:

#define INADDR_ALLHOSTS_GROUP   (u_int32_t)0xe0000001   /* 224.0.0.1 */
#define in_allhosts(x)  ((x).s_addr =3D=3D htonl(INADDR_ALLHOSTS_GROUP))=20=
=20=20

... so it certainly needs the htonl()

(What you can do is "peek at byte 0", which will always be the same
part of the netmask [network byte order!], and which might actually
make this easier to read .-) )

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYP9jcAAoJEB2Cnv7KVigSi1UL/15HAGLMoCtkdxaguS8hIPv7
oxpkRYrAtRfKArUCy+xA+MEdJ3A/QIQfVDX3x/Zc1uUyfiSjxn9vf3z68eHDg5/i
5Yi+M8+dFPUnFgzitPHuQkS8pMFgQOTL+Q9AVnNG6aC9+o95L6ntpCIZEMK7rdze
7MpMz1qC7UifHT8VBjNCJlPgD4DrKb/mkj18K1TBMHyVDBRdB4+T3ky2tEypWAmc
WFkQd4w6IMEiVxdiihXtkF7b+GlY87CWwiBuJo+ybAPpu37i2G6zxkzmcT/5S9gc
TKjww5jkOBYkQhvg5cdwWFv/VRzHEmPFGCaVPoP0vNcX5imHzNahh983jW1FSU0W
FboILh8wftb6WBYz6JRMK79dLoe1OyRSEyuDm6wsaJDY7mlTKUT2VsHgZLwl6wIx
l5pWx0a3MtkdHVk5c94hf4lPgmtxe354XkynhQZGtRCH0W/gXwXbqHlQITr0cOHO
ep3SMIVkB/XTqJDC/UiUUnZthqBcmQHhaZhs4M6kxg==
=dm6Z
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--

