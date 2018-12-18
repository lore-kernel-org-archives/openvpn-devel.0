Date: Tue, 18 Dec 2018 15:27:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20181218142742.GV962@...1296...>
References: <20181205212453.GR962@...1296...>
 <20181205214037.70783-1-gert@...1296...>
 <6eb1df8d-9047-8357-a64b-674284d30403@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="0lCd6PUOEx9GQeCA"
Content-Disposition: inline
In-Reply-To: <6eb1df8d-9047-8357-a64b-674284d30403@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] Stop complaining about IPv6 routes
 without gateway address.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--0lCd6PUOEx9GQeCA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

just as a side note, for the archives:

On Mon, Dec 17, 2018 at 04:53:45PM +1000, Antonio Quartulli wrote:
> One dis-advantage I have seen while testing this patch is that we now
> get one message for each route we try to install.

That's no different from today - we hit the message at a different spot
(when trying to install the route, as opposed to "when processing the
'route-ipv6' option") - but we got one message per route before.

Just sayin' ;-)

Will go and uncrustify...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--0lCd6PUOEx9GQeCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcGQPdAAoJEB2Cnv7KVigSWOgMAIfv8uQ4xXlFYpauymzVYHRx
ZJmb6v3RrtlXoRecVKTe7Ou3i8xqBrCwgucERbQ6RkFVeXhNfimNUMTqmEr94nFV
4kPro0fy/9jYo8MpNgeqKw9XqlRmxpZiKW5bt9Hl50/n+7iQij9DrKiu4F+onS67
ZfPECIU3zxJllsa+NI4dG99hngqVmOSkZQwPFpxXccadKjRNy0GC4epyYqYHBjMj
gLn3p2p2y7jg3cA1fH2swpdw00zn5SMCwTpqH9hB6hprIh4GAAibBfMl9KBDR2CV
li2YkltYFuu4OZ2b7Gx4kP/l2w0QtSpm6Ca7Xs8k1qDaBI0An9iMwRoHGKD+9lxz
PoVSpsuBwYNaN0qqntlqm+77W8WQBRGweSSSol4oXlkYhkGyGQ4nj4VjPcQiS2ou
6vH60M75XVSIHrRhaVx7FQR+kyalfQ9QZKbhxErs5joyfiBbhSInHyAq3wVXwQAx
LSAPvVcYPdxYsyd/Ud9Zny28dyJsrl+nbGraaGfDFw==
=ByCI
-----END PGP SIGNATURE-----

--0lCd6PUOEx9GQeCA--

