Date: Wed, 3 Sep 2014 14:57:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140903125713.GF1118@...1296...>
References: <SNT148-W76BE9A56DA884B570B3DCE99C40@...512...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i6wDt3e1Hy+osVvl"
Content-Disposition: inline
In-Reply-To: <SNT148-W76BE9A56DA884B570B3DCE99C40@...512...>
Subject: Re: [Openvpn-devel] [PATCH] kill command with IPv6 client address
	and port
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "?i ?@?N" <roy8119425@...160...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--i6wDt3e1Hy+osVvl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Sep 03, 2014 at 07:18:56PM +0800, ?i ?@?N wrote:
> For ticket #280, this patch allows server to kill client with specified I=
Pv6(port)And show port in status command
> For example, when server started with proto udp6, the result of status 2 =
command shows like:CLIENT_LIST,admin,::ffff:192.168.25.147(1194),10.8.0.6,7=
849, ...CLIENT_LIST,admin,fe80::211:32ff:fe19:699b(1194),10.8.0.10,13010, .=
..
> And can kill client with kill command:kill ::ffff:192.168.25.147(1194)kil=
l fe80::211:32ff:fe19:699b(1194)

Thanks.

While I opened that bug, I (still) wonder whether this functionality is=20
really needed - we can always kill clients by client ID, no matter what=20
protocol the client uses to connect...  so maybe just add that fact to
the documentation for the management interface...

Also, NAK on changing the format of "status 2" output.  This will break
applications that use the management interface - what you can do is add
extra columns with a header, but not modify existing columns.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--i6wDt3e1Hy+osVvl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVAcQKakuBuNlUUl1AQJCEQQAgBqm+SeceYictxC0VpUetVYuAd7NCCE0
TZh/yEqGu5jnxLljEcBN7prpNUOoWNvW9J9/NjydEzFjOSq/HzyLx8G3BwePkO7m
+kV0qRjO2gZd5D/9X7kexwvZLwzsMzLrPAcEZnV1Hg5ArPYB8D5wRZuKHQgzktt/
3TMeRp6800k=
=lfjA
-----END PGP SIGNATURE-----

--i6wDt3e1Hy+osVvl--

