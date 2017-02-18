Date: Sat, 18 Feb 2017 10:43:14 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170218094314.GX93896@...1296...>
References: <20170213183826.73008-1-O2Graphics@...2243...>
	<201702160747.v1G7l61Y058076@...2054...>
	<CAOAUwZHZGVh+zWZJg8+JT6FzqhokyuaXT6YGiDHLtvu99SFCFg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/IQTGW+1SjCkQmn"
Content-Disposition: inline
In-Reply-To: <CAOAUwZHZGVh+zWZJg8+JT6FzqhokyuaXT6YGiDHLtvu99SFCFg@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix building with LibreSSL
 2.5.1 by cleaning a hack. Similar to what is done in curl:
 https://github.com/curl/curl/blob/028391df5d84d9fae3433afdee9261d565900355/lib/vtls/openssl.c#L603-L619
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Olivier W <olivierw.ml@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--W/IQTGW+1SjCkQmn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Feb 18, 2017 at 02:37:30AM +0100, Olivier W wrote:
> 2017-02-16 8:47 GMT+01:00 Gert Doering <gert@...1296...>:
> > Your patch has been applied to the master and release/2.4 branch.
> >
> > Not sure if it is something we want in release/2.3, but it wouldn't app=
ly
> > with "git cherry-pick" - too much formatting changes, so one would need
> > to do it manually ("but we knew this").
>=20
> I just had a quick look at release/2.3 and the code I patched (around
> the SSL_get_privatekey() call) isn't present at all. So there's no
> need for a patch there.

That's even easier, then ;-) - I didn't check, just tried to cherrypick,
it didn't apply, and I *assumed* that it was due to the massive formatting
cleanup.  But obviously "the to-be-patched code is not there" is a much
better reason...

thanks for checking,

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--W/IQTGW+1SjCkQmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYqBcyAAoJEB2Cnv7KVigSQR8L/Rafcr/mJeogR30Y523hA+Ph
MZxl/RFVImzoGL8qUQfj+g7QV0bWgs+DBCwcXcADy6OJDw7EeRqRa8a2+uJ+mXAx
5iUv/P6mFFoF9uKEEEOlVjpeh1neC6TfMbcr7loHeKtibBNRkYvvbflHkOTUPu62
rX0jnfXo759XQrWuWrf/elQPH+r3UOyMgoHrS1ePbv48bicmcExGbFrtY2jdUm5F
vQZ6lkByXHdTpQrCXeZXhZ2ENi0JfbH/lZkcbsG9oKx1REU+vIlij68tmvYT3siB
WprXyGbiXpBMDqEeaKlYmuw7qk6PMLkkb9vpTc8Fn9ZVi/eaFmubCMnmOrXa0iJj
ATc4LI1w+YgzW2XuMM/6tUlYeDNvoaQdl2rTBss7p5VKUVWBJqgUOCV+33SqKIbc
25SeI5EP4uZQhIANF0AtdkRFiKKU3TZmIhfxs/fst/3+Sc+OUP9wsMCTlca1nZ5W
O52xpcPggesNIncLJ+3RQncFWyS61oKUf7NSed2KFA==
=Q0a3
-----END PGP SIGNATURE-----

--W/IQTGW+1SjCkQmn--

