Date: Tue, 29 Nov 2016 12:05:59 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20161129120559.5be3e4ad@...1799...>
In-Reply-To: <f3062a2e-f7a1-c5b4-8c35-00b807b4a234@...2080...>
References: <20161128161625.11972-1-list@...1798...>
	<20161128161625.11972-2-list@...1798...>
	<f3062a2e-f7a1-c5b4-8c35-00b807b4a234@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/+H4x=9KG5tGScHJfQbotF75";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH 2/2] allow to enable plugin lookup with
 configure argument
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Christian Hesse <mail@...1798...>, openvpn-devel@lists.sourceforge.net

--Sig_/+H4x=9KG5tGScHJfQbotF75
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

David Sommerseth <openvpn@...2080...> on Tue, 2016/11/29 00:47:
> On 28/11/16 17:16, Christian Hesse wrote:
> > From: Christian Hesse <mail@...1798...>
> >=20
> > For plugin lookup (give relative path to plugin directory in
> > configuration) we had to configure with something like this:
> >=20
> > CFLAGS=3D"$CFLAGS
> > -DPLUGIN_LIBDIR=3D\\\"/usr/lib/openvpn/plugins\\\"" ./configure
> >=20
> > This allows to pass --enable-plugin-lookup to configure to achieve the
> > same. As a bonus we can be sure that install path and lookup path in
> > openvpn binary are the same.=20=20
>=20
>=20
> Thank you for your patch.  Unfortunately I'm not convinced this is the
> proper way to do it.
>=20
> First of all, to achieve what I believe is your goal, you need to flip
> things around:
>=20
>   ./configure CFLAGS=3D"$CFLAGS
> -DPLUGIN_LIBDIR=3D\\\"/usr/lib/openvpn/plugins\\\""
>=20
> This will ensure that whenever 'make' decides to re-run ./configure
> automatically it will keep all variables provided to the command line.

Ah, right...
I used this to build a binary package, so configure is run only once and it
works for this case. :D

> Secondly, I believe the proper way to configure PLUGIN_LIBDIR without
> going via CFLAGS is to use a similar approach to what is used by
> IFCONFIG, ROUTE, IPROUTE and NETSTAT.  They are configured via AC_ARG_VAR.
>=20
> I'd recommend just adding these two lines to configure.ac instead:
>=20
> AC_ARG_VAR([PLUGINDIR], [Path of default plug-in search directory])
> AC_DEFINE_UNQUOTED([PLUGIN_LIBDIR], ["$PLUGINDIR"])
>=20
> (these lines are not tested, but that should give some pointer towards a
> better direction.
>=20
> With these lines in place, it is expected that you can do:
>=20
>   ./configure PLUGINDIR=3D/usr/lib/openvpn/plugins
>=20
> Which should result in defining PLUGIN_LIBDIR in config.h.

I decided to go another way... Wanted to make the plugin search work out of
the box. Or do we want to keep that optional?

(AC_DEFINE_UNQUOTED() fails if PLUGINDIR is not defined and you try
${libdir}/openvpn/plugins instead. That evaluates to
"${exec_prefix}/lib/openvpn/plugins" and breaks the path in config.h.)
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/+H4x=9KG5tGScHJfQbotF75
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlg9YRcACgkQiUUh18yA
9HalkAgA6zffETTXfJUrV8cMxa+qxMGi5lfKvTmfBEe1YsVyXWPBWpjhhTPaSyY7
ZreoTudn4n+DA50ezartvEv7PdeRQ1jllIA62U+QxQRo7u+wEi522EvT2+2SgVvg
sTblGr/oxGwR1AGjfhrz05O0fOED1n7wu3gPaOXGqZ8bf9TtPHFtUy7WhGBvDpYC
ztS4GNRSlGid7ydfcOWwMxZFMX2ufutF73kUia0kUjSF9UsDQ1eH1zzgEGrzJ7CB
UESrb9yUJ+27GxEgnqYg2guR/wOM2PBychdDYSYAAZYCQLWlvRc3Nx6OsrvIPPwj
rHihcDz0O6q+VR1aBfVVphITyM4vow==
=6ufY
-----END PGP SIGNATURE-----

--Sig_/+H4x=9KG5tGScHJfQbotF75--

