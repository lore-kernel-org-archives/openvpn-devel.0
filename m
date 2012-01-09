Date: Mon, 9 Jan 2012 18:56:25 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120109175625.GS5060@...1296...>
References: <1326129087-8697-1-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LkL3iLkxWcC48rNm"
Content-Disposition: inline
In-Reply-To: <1326129087-8697-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Fix a couple of issues in
	openvpn_execve()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

--LkL3iLkxWcC48rNm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 09, 2012 at 06:11:27PM +0100, David Sommerseth wrote:
> If openvpn_execve() is not able to fork(), it would make any noise about
> it.  So this patch adds a log notification if this happens.
>=20
> In addition, if openvpn_execve() is called with an empty argv array,
> it should exit instantly.  This is not expected to happen at all and
> might indicate a much more serious issue (or programming error)
> somewhere else in the code.  Thus, abort execution to get these issues
> flushed out as quickly as possible.

ACK.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--LkL3iLkxWcC48rNm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTwsqSakuBuNlUUl1AQLe8QP/cHUe/T9QhabZwnBvJfVbvcNrmmrWGHIl
oLX9Wtwq4UAd9FmXCSbISYnxUlrsH7u7WiPTUdRaHNCDRTxROdfT/F59vQjl2ZNB
tv15NcQhyfZ0Om9s2YYskkjWC3JMJ9UDPqMZxZgiWeS8Eb1tRzU5aBtiCVTjL1v0
QP7uaRsvBHQ=
=zseJ
-----END PGP SIGNATURE-----

--LkL3iLkxWcC48rNm--

