Date: Wed, 9 Mar 2011 09:47:45 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20110309084745.GN9835@...1296...>
References: <20110308185252.301d0a1d@...1451...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QVgWX4+QEldMe/r9"
Content-Disposition: inline
In-Reply-To: <20110308185252.301d0a1d@...1451...>
Subject: Re: [Openvpn-devel] [PATCH] Bind only to specified interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Federico Heinz <fheinz@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--QVgWX4+QEldMe/r9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 08, 2011 at 06:52:52PM -0300, Federico Heinz wrote:
> Accept "local if:<ifname>" option.

I can understand why this feature is desirable - there are a couple of
problems with the implementation, though.=20=20

 - From a code modularity point of view, socket stuff should not go=20
   to options.c, but to socket.c

 - your code is likely to work on Linux and *BSD, but will it work
   "as is" on Solaris and Windows?  I don't expect it to, so additional=20
   #ifdef's are needed --> and that's why it should go to one of the more=20
   system-dependent (and already #ifdef-filled) source files


In general, I wonder why binding to the interface is really needed - what
happens if you don't specify "local" at all?  It should pick the proper
source address automatically.

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--QVgWX4+QEldMe/r9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTXc+sKkuBuNlUUl1AQKCAAQAqQ11xaWf6a5Yd+LkXPpxrSxBGGFF6guS
C0FZArrxjwAK8MtOElLJsrtiIesFVmIeQYwjrpKyOC8kUjMxL5aZ8qRoLfkMJYt9
HI9NWfSzI5wXAqoX54QYSjiW63lCLeRlH8cwlOrZW5O4lYej8hFZqsadkYH1NNkY
SuvGD9brVqE=
=+Tqs
-----END PGP SIGNATURE-----

--QVgWX4+QEldMe/r9--

