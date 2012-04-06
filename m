Date: Fri, 6 Apr 2012 19:55:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120406175525.GH1359@...1296...>
References: <1333351687-3732-1-git-send-email-dejong@...1435...>
	<CAOazyz0MDBg75y+CRdYNEOdYBE83B_pYfZ3pz+JLyUdAyF6xgQ@...278...>
	<CAP+U6tK3UHd=KR1th0vxdLnRUsZm47qKgk=BeNgzSmvYUFMdvw@...278...>
	<4F797A66.8050502@...1114...>
	<CAOazyz0uhi_ao2SN3Moi+tXRVhaJPd-O1eam0tqLo_6rehVREg@...278...>
	<4F7981C4.80409@...1114...>
	<CAOazyz1eV7V7aB9WFr0LwJM-dyegeK1wyeLXJQAoDTB+J02E3A@...278...>
	<1CED409804E2164C8104F9E623B08B9012CB842337@...1436...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DCVUsB8wYFFoocrD"
Content-Disposition: inline
In-Reply-To: <1CED409804E2164C8104F9E623B08B9012CB842337@...1436...>
Subject: Re: [Openvpn-devel] [PATCH 1/6] Added support for new PolarSSL
	1.1	RNG
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adriaan de Jong <dejong@...1435...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--DCVUsB8wYFFoocrD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Apr 02, 2012 at 07:31:56PM +0200, Adriaan de Jong wrote:
> I don't see the need to further delay 2.3 for this, as it is not
> a bug fix. Others might disagree here, and the topic is open for
> debate :). In general, it might be a good idea to freeze development
> of 2.3 at some point to prevent endless alpha syndrome.

I'm with Adriaan on this.  I want 2.3 *out*, and *soon* - people are=20
waiting for an OpenVPN release with IPv6 support.

(There *is* lots of more work to be done, but there will always be a release
after 2.3 - and with more reasonable release cycles, 2.4 will be here
before we could otherwise reach a "everything in!" 2.3...)

I'm not commenting on the PolarSSL patches, because I don't feel confident
in ACKing or NACKing crypto stuff - "it looks reasonable to me", but that's
more a half-feature-ACK than anything else.  But besides this, I think it's
time to tag -alpha2, give this a good beating, and then figure out what
we think is missing *and can be achieved in reasonable time* for 2.3-beta1.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--DCVUsB8wYFFoocrD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT38uDakuBuNlUUl1AQK0GgQAky1qXdMmA6POYj3U9Nzla4CC53yPuik6
SeEWIHu71aahEbsgDV+4NXu1Mo7a/Tq9Hx0Yyo1+vG+QMmEd7gneevtPSI799i8W
GkRkXNUCpLHAQAwRLnTMb8XxzxPSWqefPZhBjNsLxRTDiFSCuhhFLe3Xuya6ICzc
kaOCC6u9uxw=
=6ijj
-----END PGP SIGNATURE-----

--DCVUsB8wYFFoocrD--

