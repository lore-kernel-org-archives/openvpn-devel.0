Message-ID: <20100930003840.14209.qmail@...1287...>
Date: Thu, 30 Sep 2010 02:38:40 +0200
From: Peter Stuge <peter@...1287...>
References: <4CA362CD.8030204@...1410...> <4CA0551F.70703@...1410...>
	<4CA08840.3030107@...1147...> <4CA088DD.5040607@...1410...>
	<4CA08C68.1080701@...1147...> <20100927124711.GS3275@...1355...>
	<4CA09A9F.6040009@...1147...> <4CA0B3A3.5030506@...1410...>
	<20100929220528.19467.qmail@...1287...> <4CA3D978.8080700@...1410...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <4CA3D978.8080700@...1410...>
Subject: Re: [Openvpn-devel] HTTP Host header
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Lars Hupel wrote:
> > Current behavior is correct. The first one is what should be sent.
> > [...]
> > Actually it is helpful. It says that *the resource being requested as
> > obtained from the original URI given by the user* is what should be
> > sent. This is the "remote" parameter and nothing else.
>=20
> So what you're implying is that if a request is sent, the part after
> 'CONNECT' must be always the same as the part after 'Host'.

Yep. It's a bit redundant, but consider that CONNECT is already the
odd kid among the HTTP verbs. Most other verbs only take an absolute
path URI, without host component.


> > I'll ack your patch if it only adds a Host header where one is
> > missing, and sends the correct contents, ie. the "remote" hostname.
>=20
> Hopefully the attached patch is acceptable for you.

I'm just another community member, but I think the patch is correct.
Thanks!

Acked-by: Peter Stuge <peter@...1287...>

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFMo9wQhR3Q0dhIfEgRAjxQAJ9blXS/wP5TotY+YGAVlvGlNnfnLQCg2fLq
+MYdxL5IqJ/GVt+1Gl5C54g=
=dHi9
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--

