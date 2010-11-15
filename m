Message-ID: <20101115150551.9357.qmail@...1287...>
Date: Mon, 15 Nov 2010 16:05:50 +0100
From: Peter Stuge <peter@...1287...>
References: <1289808348-17463-1-git-send-email-dazo@...384...>
	<1289808348-17463-3-git-send-email-dazo@...384...>
	<20101115090236.GK258@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <20101115090236.GK258@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 1/6] Use stricter snprintf()
	formatting	in socks_username_password_auth()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Gert Doering wrote:
> > -  snprintf (to_send, sizeof (to_send), "\x01%c%s%c%s", strlen(creds.us=
ername),
> > -            creds.username, strlen(creds.password), creds.password);
> > +  snprintf (to_send, sizeof (to_send), "\x01%c%s%c%s", (int) strlen(cr=
eds.username) & 0xff,
> > +            creds.username, (int) strlen(creds.password) & 0xff, creds=
.password);
>=20
> I tend to NAK this.

I agree. My ack is only for the other patches. (Sorry, I should have
written that in the other mail.) A better solution for this should be
simple as Gert outlined.


//Peter

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iD8DBQFM4UxOhR3Q0dhIfEgRAiwOAKDTqZCrimy3R2ZyHaNMhTPwfEUmqACeNuQt
3kAQNQafUfQyazBLxhavUow=
=pzo0
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--

