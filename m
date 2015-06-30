Date: Tue, 30 Jun 2015 09:57:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150630075727.GO382@...1296...>
References: <1435611582-26553-1-git-send-email-steffan@...1856...>
	<55922E18.2060204@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w8NEM23WsiTAHpTR"
Content-Disposition: inline
In-Reply-To: <55922E18.2060204@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Increase control channel packet size
	for faster handshakes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--w8NEM23WsiTAHpTR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 30, 2015 at 07:50:16AM +0200, Arne Schwabe wrote:
> > Note that this patch does *not* yield an optimal solution, but it is a
> > simple and rather safe change that will improve connection setup times
> > significantly.
>
> I have no experience with the code and what happens on a small MTU
> connection. Are there still very strange small MTU connections (like 56k
> dialup modems) around?=20

A 56k dialup doesn't *need* to have a strange small MTU - at least not
unless someone followed the "speed optimization tricks" common at that
time and messed up their windows 3.1 TCP/IP settings... :-)

But anyway.  If somone's line has a MTU below 1300 bytes, the control
packets will end up being fragmented - which is not necessarily a killer,
but in combination with NAT routers might indeed be a problem.

Now, *if* someone has such a line, and non-working fragmentation, their
data packets will also run into this.  So I wonder if we can (ab-)use=20
one of the existing mtu-capping command line arguments, like --link-mtu,
to set a configurable upper bound for control packets as well (and default
to 1250 otherwise).

The option is there, the manpage description of the option "fits", we
just need to make it visible inside ssl.c... :-) - Steffan?

> On the other hand the OpenVPN 3.0 also uses 1200ish packet.

Indeed...  but then, in a household with 56k Internet, you just do not
want to use any modern iOS or Android gear anyway...  ("upgrade Angry
Birds?" - "yes!" - "ok, ready in 36 hours!")

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--w8NEM23WsiTAHpTR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVZJL56kuBuNlUUl1AQLXagP+NejUC5DWPXwPgF9tqqcmbhIPciWLEs1T
L+cREewKf9DFUqm4ex/npdKQcEfvhvetZfbNuhckOGL0cgObwhkzwa3nAxaMxRjp
iTeJT5bssXMTM2WQZf3Ls69vD+wHu5p0KLDgdNmgXQ3En93LRmJwjruujWapAHut
TmogQ0Xxskc=
=Pnep
-----END PGP SIGNATURE-----

--w8NEM23WsiTAHpTR--

