Date: Fri, 26 Jun 2020 11:54:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200626095432.GB1431@...1296...>
References: <CAGyAFMXj7Ei4ALL_zg91=YJ15qM7eS2MzS-wP3nd-KwECmb0FA@...278...>
 <20200625103139.365-1-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="oRUJHtSneeYikQVH"
Content-Disposition: inline
In-Reply-To: <20200625103139.365-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3] msvc: fix various level2 warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--oRUJHtSneeYikQVH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 25, 2020 at 01:31:39PM +0300, Lev Stipakov wrote:
>              case AF_INET:
>                  if (setsockopt
> -                        (sd, IPPROTO_IP, IP_MTU_DISCOVER, &mtu_type, siz=
eof(mtu_type)))
> +                        (sd, IPPROTO_IP, IP_MTU_DISCOVER, (const char *)=
&mtu_type, sizeof(mtu_type)))

If windows really needs a cast here, please cast to (void *).

Windows can then cast to "const char *" under the hood - which should be
warning free.  But for all other platforms, casting to "const char *" is
not a good change (other parts of socket.c use "void *" already today).

If you are touching the lines anway, please add sensible line wrapping,=20
like:

            case AF_INET:
                if (setsockopt(sd, IPPROTO_IP, IP_MTU_DISCOVER,=20
                               (void *) &mtu_type, sizeof(mtu_ type)))

and not this very weird style with wrapping after the function name.

(Whatever uncrustify might have been thinking, it's ugly)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--oRUJHtSneeYikQVH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe9cXYAAoJEB2Cnv7KVigSSA8L/RfZj8iYsGUMBYfhTjxU2hFb
Z8+G94bPfqTMXYKZFSEmSD65ELpceqSlKiUGOzJmFWkiVYm719VSMfhaOEzP5vfP
QdvUL8hHu/6MS+rz0f6a32j2DOl8qgLIO6aMvLfl52MOk12zePxOnWRhDV3jqSbs
5NWOl0RBGtp6161DoIMbCh0Rz07CQLijGk/9/l6IOMD0pxi8hby9pGkqABiE9naD
EfiH08V2DQ1hOnKsAGhIC8qmhXiu7DRKf2zlmmjVDXdlQzWJgm7FQVDHiw9xqbOK
A8PTeN7sHoku1WTRNi8FWtNMFTs7m8FgD3xU1qKvJ3/NldH9Q2GF0SEczfaAGmtr
exeuctWRte9WbfDrdE+U6CqNHN4Ko7VSenKEIkg64IZwSPfsleOL259pmQQU9u9Z
KJB1NQlax1bt2sYHCB6ezNRoL286ZzQOx1ENci+Xnnb/nycdGS4aFZDkXzMGqKw9
oAHYZXXEgdIU9NDlFG2YpNdXHZ0AmXyfmB6+2zEuEg==
=X/40
-----END PGP SIGNATURE-----

--oRUJHtSneeYikQVH--

