Date: Thu, 12 Jan 2017 23:54:53 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170112155453.GT18524@...2182...>
References: <20161227112436.5045-1-a@...2181...>
	<97c51277-d8b7-b768-5205-706492e92f84@...1856...>
	<20170111063237.GQ18524@...2182...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wmhq21yAGFMoSpeN"
Content-Disposition: inline
In-Reply-To: <20170111063237.GQ18524@...2182...>
Subject: Re: [Openvpn-devel] [PATCH v2] convert *_inline attributes to bool
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

--wmhq21yAGFMoSpeN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, Jan 11, 2017 at 02:32:37PM +0800, Antonio Quartulli wrote:
> On Tue, Jan 10, 2017 at 10:35:10PM +0100, Steffan Karger wrote:
> > > @@ -6496,7 +6531,7 @@ add_option(struct options *options,
> > >      else if (streq(p[0], "push") && p[1] && !p[2])
> > >      {
> > >          VERIFY_PERMISSION(OPT_P_PUSH);
> > > -        push_options(options, &p[1], msglevel, &options->gc);
> > > +        push_options(options, &p[1], is_inline, msglevel, &options->=
gc);
> >=20
> > Same as with 'plugin', I don't think we can inline a 'push' option?
>=20
>=20
> My understanding is that the code allows for push-options to be inline'd,=
 but
> right now there is no push-option that can be used that way. Am I wrong?

This said, I agree that we should just not support pushing inline options.
As of now, none of the 'inlineable' options can be pushed.


I'll send v3 soon!

Thanks!


Cheers,



--=20
Antonio Quartulli

--wmhq21yAGFMoSpeN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYd6bLAAoJEJ6F1zG2JyOsUE8P/1YwKIveZTt8GNMGlT5b8LsB
4fwghOsXNvKJRVmoo6HGIaFhJ5AmmFJuTjTFFBuwSDDl1a4bOy+D0t7nTTkHiY9P
U/sXLh/BZVcNHGrgbENEvjbyf5vQm45vKzGtD/OYdZsZm6oODglibFSpfiFxy9hK
nP51+3RHpDhcwQh2E/DVbzsHfcLhTTbsCTGTaZxQ0n7PGiC07wU63q6ghQy4IhZW
N8IXsWmkLLI7UcY00Lcw1IBGOVV+g/HkVsCbUC3atIZcWSDzjjOwWhBRpRKuKeiY
Fg/b7c4E19m9jPrEjG9afaBgiRjs+lKAusdXyaCiNozpVpgaxIZbXe97uoJIPEJf
EKoCP1oxnO99dJugRJxEiYaSWpSECEMwK9Wuf5DevZrLteNJeao5UUj88z2o/cNM
7PMhZZfg4Bo7IdbxJpC/3njMdOGwZ8vvXvvfFSsnQSrijszTC/lnDLifRiqBHBps
d7cG1f+h4Guf97ojPdDkMPpWh79GQyDoU7jUMrAzkFeGUjr4Zr/ysyKQqUB3BC+u
+T4Vb8BqB3GRTpv7uS9bot6T52eBSLh/tB8moT1WusBI8+QSQwjxARIPyhTjkAMP
l/XE1Q6hJkqF5voPHf1OFo34TuHPEa+7fJUFXT+yWpl0sfOUbJnZwPVunStYoUy5
K9MjJUnNfVNh3j7h3cjj
=DueG
-----END PGP SIGNATURE-----

--wmhq21yAGFMoSpeN--

