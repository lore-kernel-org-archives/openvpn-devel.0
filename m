Date: Mon, 2 May 2016 09:50:06 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160502075006.GM53051@...1296...>
References: <CAFHpkQHwNFdNm1WjApkby4h4C-_R-pEhVT3sZgE2XfQ1HUaOwQ@...278...>
	<D881287C-058C-495C-888E-1EE40262550F@...2127...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="71H8RJdeoX6JglLe"
Content-Disposition: inline
In-Reply-To: <D881287C-058C-495C-888E-1EE40262550F@...2127...>
Subject: Re: [Openvpn-devel] automatically close PR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jens Neuhalfen <openvpn-devel@...2127...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--71H8RJdeoX6JglLe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, May 02, 2016 at 09:14:02AM +0200, Jens Neuhalfen wrote:
> I kind of understand why openvpn does not use github pull requests to mer=
ge (although I might debate that).
>=20
> Personally I like the github PR workflow, because it makes it
> much easier to view larger changes in context. Especially more
> complex patches typically need a few roundtrips.

This is true (though we usually succeeded quite well with "discuss the
idea by mail or IRC, and then base the first round of patch on that,=20
and the second round gets in" :-) )

> What I would like to know is: Wether ???please give feedback to this PR, =
before I send it to the list??? is considered a viable (maybe even polite) =
way to only send (large) patches that have already been peer reviewed on th=
e list.

I've seen you do it, but as we're notoriously short of reviewer brain=20
cycles, nothing has happened yet - but that does not mean it's a bad
idea (or a good idea)...


> IMHO: If there is consent that we do not want to allow GitHub PRs for any=
 use case - disable it.
>=20
> I have a strong preference for using GitHub at least for vetting out most=
 bugs.

We're not going to use GitHub for the actual patch merging process - that
is "mailing list, public ACK, merge, push to github + sourceforge", at
least today.

For review, PRs should be doable.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--71H8RJdeoX6JglLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVycGrakuBuNlUUl1AQL2ZgQAjra83koMfALkeefFQybEbA9mlScyNDrb
woFH6XmjNDyZ8zXXN156OvhNcue/iGyLCowlGPp/quzKzb9V9UYo7mH0BUkt3q7N
JVvEJQ0FPoGo+kE7e5O0yfJbsu/7FzSosXP2Tsi7cA2d3uCUVhF2xTk8DFqslG8N
/rolv3oVGwg=
=7J/a
-----END PGP SIGNATURE-----

--71H8RJdeoX6JglLe--

