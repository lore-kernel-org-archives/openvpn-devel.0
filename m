From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 14 Sep 2011 19:00:33 +0200
References: <4E69CC6F.5000105@...515...>
In-Reply-To: <4E69CC6F.5000105@...515...>
MIME-Version: 1.0
Message-Id: <201109141900.33862.heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting / sprint (8th Sep
	2011)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On Friday 09 September 2011 10:21:03 Samuli Sepp=E4nen wrote:
> Discussed the "Better --auto-proxy support for Windows" patchset:
>=20
> <http://thread.gmane.org/gmane.network.openvpn.devel/4927>
>=20
> Suggested the following modifications:
>=20
> Patch [1/3]: Add MinGW WinHTTP compatibility layer
>=20
> - Make use of import libraries:
> <http://www.mingw.org/wiki/CreateImportLibraries>

See my patch from yesterday.
=20
> Patch [2/3]: Do automatic proxy detection on Windows right...
> Patch [3/3]: Query auto-proxy information when connecting...
>=20
> - Verify that these patches play well with existing functionality:
>   - PROXY queries from the management interface
>   - http-proxy-fallback option
>   - http-proxy-override option

Have done the tests now:

--http-proxy-override works. The server configured here overrides the one f=
rom=20
--auto-proxy.

--http-proxy-fallback works as long as no proxy is configured via=20
--http-proxy or --auto-proxy. In that case ">PROXY:NEED_NOW" can be answere=
d=20
with "http-proxy-fallback <host> <port>" via management interface and the=20
fallback proxy entered is used.

So, as expected, we're still fine regarding compatibiliy with these options.

Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro a Sophos Company | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germ=
any
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
Amalienbadstra=DFe 41 Bau 52 | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen

