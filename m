Date: Tue, 14 Sep 2010 13:37:22 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100914113722.GB10703@...1296...>
References: <54C854C313159D429F344FB1DE1A6526110D96A5@...1403...>
	<4C8E9E7B.9020308@...1299...>
	<20100914074032.GA10703@...1296...>
	<4C8F3C04.8020904@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+yOEb87YRmRdrPqC"
Content-Disposition: inline
In-Reply-To: <4C8F3C04.8020904@...1147...>
Subject: Re: [Openvpn-devel] Enhancements.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

--+yOEb87YRmRdrPqC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Sep 14, 2010 at 11:10:28AM +0200, Jan Just Keijser wrote:
> >          if (buf_string_match_head_str (&buf, "AUTH_FAILED"))
> >            receive_auth_failed (c, &buf);
> >          else if (buf_string_match_head_str (&buf, "PUSH_"))
> >            incoming_push_message (c, &buf);
> >          else if (buf_string_match_head_str (&buf, "RESTART"))
> >            server_pushed_restart (c, &buf);
> >          else
> >            msg (D_PUSH_ERRORS, "WARNING: Received unknown control=20
> >            message: %s",
> > BSTR (&buf));
>
> is the control message stage early enough? that means authentication has=
=20
> been completed, and the client_connect script has been run (or am I=20
> mistaken?=20

I'm not absolutely sure at what time these messages can be sent.  But
most likely you're right, you want this before running client-connect.

Someone around who fully understands the session flow...?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--+yOEb87YRmRdrPqC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTI9ecakuBuNlUUl1AQLWIAQAr24v5Ak7kNI0wNgJL6W5+kns2TvtLcYM
zhslLvNCiNtx2lx4mmfrcX68uHKkC6yklvIDXgRUe+JTQVOQMsgcqMuA1ocpTGt4
j6TcYWNYg93Sw8/3dfpbysgPV7VspkspuINxoLu9OZ1wUABdQRT+2WNm+VQgqXIA
kN7OU2nYOxc=
=+V7X
-----END PGP SIGNATURE-----

--+yOEb87YRmRdrPqC--

