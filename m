Date: Wed, 4 Dec 2013 17:07:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131204160731.GJ161@...1296...>
References: <528B8225.3040206@...515...>
	<1384882574-28242-1-git-send-email-heiko.hund@...1489...>
	<529EF77C.5020603@...68...>
	<CAEsd45SF1fcVPJfOmhmm6GzB7=WvnBg95k=+nX25aRwKf2X-kQ@...278...>
	<CAFHpkQFx+3QHie71FTGKk6ieKMwC-7X8M=O58qbtnj8-99MVYA@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9P+aKMVjKAH00hQC"
Content-Disposition: inline
In-Reply-To: <CAFHpkQFx+3QHie71FTGKk6ieKMwC-7X8M=O58qbtnj8-99MVYA@...278...>
Subject: Re: [Openvpn-devel] English language? Re: [PATCH] Support non-ASCII
	characters in Windows tmp path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???? ??????? <chipitsine@...277...>
Cc: Matthias Andree <matthias.andree@...68...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--9P+aKMVjKAH00hQC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 04, 2013 at 06:22:04PM +0600, ???? ??????? wrote:
> I've looked through the code and I do not understand why do we need
> that temporary directory on windows platfrom ?
> anyone can explain idea behind initializing tmp-dir ? especially on
> Windows platform.

tmp-dir is used to create, well, temporary files :-) - usually in the
context of a script being called (--client-connect) or a plugin.

I'm not sure if it is ever used in *client* mode, but since people do
run OpenVPN server instances on Windows, and server definitely needs
--tmp-dir for full functionality, it needs to work.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--9P+aKMVjKAH00hQC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUp9TQ6kuBuNlUUl1AQJYEgP/Zv+/6C3zrHzKT4VB2y9YITmywJKS/GP3
qkSJM2TKSCZSEF0bh1mHNJMHNTsowHl5iNDIk5wsBVhgIgPtIVO9fbs6SL/BmWS0
PnfoCZBeZ7g7OEU9E21o/Xftp4f/IOx2mjtTzioH0pGonCnhnlhRHd7qaJsGhavU
ODhQkwFvHQM=
=vNuQ
-----END PGP SIGNATURE-----

--9P+aKMVjKAH00hQC--

