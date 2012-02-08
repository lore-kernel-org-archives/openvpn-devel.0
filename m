Date: Wed, 8 Feb 2012 19:24:13 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120208182413.GB13929@...1296...>
References: <CA+3tv22Xq447J_EXKM4SYP-45V7LN0NJfH6o9skUNPPij3PDuQ@...278...>
	<1CED409804E2164C8104F9E623B08B90129328AD5E@...1436...>
	<20120208080953.GS13929@...1296...>
	<CA+3tv2064zxi_v1hJPWaF+bd5FUrXYm+h+qYDnorHz8OrpxyGQ@...278...>
	<CA+3tv20-SBYOaDZG_+DgmVvAgkAYVR=CoWJ_dyzMjf2yFdLMGA@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xku3GkZTJumTa1rO"
Content-Disposition: inline
In-Reply-To: <CA+3tv20-SBYOaDZG_+DgmVvAgkAYVR=CoWJ_dyzMjf2yFdLMGA@...278...>
Subject: Re: [Openvpn-devel] OpenVPN and Android 4.0 VPN API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Ring <sjr@...1546...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--xku3GkZTJumTa1rO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Feb 08, 2012 at 04:47:35AM -0800, James Ring wrote:
> Perhaps I wrote this too hastily. I wasn't thinking of how OpenVPN
> actually works. OpenVPN would:
>=20
> * open the connection (tcp or udp) to the remote end
> * negotiate session parameters
> * provide the Android Java wrapper with the session parameters via the
> service pipe
> * receive the file descriptor to use as the tun/tap device from the
> Android Java wrapper via the service pipe

Exactly.  The first three things are sort of "nearly done", the=20
"receive file descriptor to use for tun/tap" would need to be=20
implemented (tun.c, open_tun(), #ifdef ANDROID_MAGIC_VPN :-) )

> Another thing to think about would be whether the tunnel could be
> reestablished after the device wakes up from sleep.

Depending on the OpenVPN --ping parameter settings, it would reconnect
to the server automatically - and then re-initialize the interface.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--xku3GkZTJumTa1rO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTzK9zakuBuNlUUl1AQIA3AP/QgQKbcESdbLYmuboggbBifoJVeyP65Rz
+IkdksZOA1hZzL8HJqraGlBlUxVfjLjLvm1Zq7iC4Rt15fzKwFxZhh11tSgTv4og
GSxAuI1CeVoSNwRMzkcWeyxdzWmo4HOQPSDYReYmsf+X8BI6CeYQwQUgdCcWyb0w
/9vAIkS9ICQ=
=gAO4
-----END PGP SIGNATURE-----

--xku3GkZTJumTa1rO--

