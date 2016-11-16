Date: Wed, 16 Nov 2016 13:35:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161116123512.GG28918@...1296...>
References: <1478027207-28651-1-git-send-email-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cMiKjQOw8u33VrUM"
Content-Disposition: inline
In-Reply-To: <1478027207-28651-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v3] Restore pre-NCP cipher options on
 SIGUSR1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--cMiKjQOw8u33VrUM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 01, 2016 at 08:06:47PM +0100, Steffan Karger wrote:
> As reported by debbie10t on the openvpn-devel list (Message-ID:
> <326b8ff7-39a6-1974-c0b0-82fd2abdc7b7@...277...>), an NCP client will
> attempt to reconnect with the previously pushed cipher, instead of the
> cipher from the config file, after a sigusr1 restart.  This can be a
> problem when the server is reconfigured (as debbie10t explainted), or when
> roaming to a differently-configured server.  Fix this by restoring the
> cipher options from the config file after a sigusr1 restart.
>=20
> This makes the cipher options behaviour different from other pushable
> options, because those are also cached until a sighup restart.  We might
> want to change this behaviour in general, but for now let's just fix the
> issue at hand.
>=20
> v2: also cache and restore keysize, as that parameter is relevant too.
> v3: inherit cached cipher options from parent context.
[..]

ACK.

After extensive discussion on #openvpn-devel - the code looks quite=20
harmless, but now I think I understand the flow of things and when and
why the SSL/TLS context is re-used on client and server, and what happens
if it is *not* re-used (client re-inits from config file, server re-inits
from global context which still has the config-file settings).

David, since you currently hold the "not fully pushed" tree (due to sf),
can you please merge?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--cMiKjQOw8u33VrUM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWCxSf6kuBuNlUUl1AQJh+AP/SEbCVWiwHIId4NqiQzP+7Td8YlvK2s3p
Sg8LX4mD4lL0+zeOlte3cYQ/k5O6V6H4FObpMckQI5TwfxYB5LYjsgOC0dTyD9AP
TNthUggdbhBjsi5aVwIGB82SiRUB+JE9XQbDekAzfIJ84vBdCMTlCH+Qsi6oJ3YA
WtDKZu+8NJA=
=UE/9
-----END PGP SIGNATURE-----

--cMiKjQOw8u33VrUM--

