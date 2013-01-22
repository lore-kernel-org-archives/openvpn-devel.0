Date: Tue, 22 Jan 2013 09:36:50 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130122083650.GJ22465@...1296...>
References: <1358774007-4881-1-git-send-email-steffan.karger@...1435...>
	<1358774007-4881-2-git-send-email-steffan.karger@...1435...>
	<20130121202321.GH22465@...1296...>
	<1CED409804E2164C8104F9E623B08B90133FB45DE2@...1436...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3fX2G+AJpfl5sqva"
Content-Disposition: inline
In-Reply-To: <1CED409804E2164C8104F9E623B08B90133FB45DE2@...1436...>
Subject: Re: [Openvpn-devel] [PATCH 1/3] Improve PolarSSL
	key_state_read_{cipher, plain}text messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--3fX2G+AJpfl5sqva
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jan 22, 2013 at 08:44:32AM +0100, Adriaan de Jong wrote:
> > > +#ifdef POLARSSL_ERROR_C
> > > +  char error_message[1024];
> > > +#endif
>=20
> PolarSSL can be made really small, by disabling modules. For example,=20
> detailed error reporting can be disabled with that flag in=20
> <polarssl/config.h>.=20

OK, that explains things.

I'm not sure I'm happy with the implied consequences - this is a build-time
decision that depends on a *shared* library, so depending on package buildi=
ng
and installation, we could end up with a reference to a symbol that's not
there in the installed shared library...

> We can always say that we demand error.c to be enabled, but I'm
> not sure how happy embedded developers would be with that decision.
> I'm pretty much ambivalent in this discussion and will follow the
> general opinion :).
--3fX2G+AJpfl5sqva--
