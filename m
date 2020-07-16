Date: Thu, 16 Jul 2020 17:03:06 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200716150306.GC1431@...1296...>
References: <20200716134315.17742-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GVa1wdIo6zwq9rsO"
Content-Disposition: inline
In-Reply-To: <20200716134315.17742-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v7 1/6] client-connect: Add
 CC_RET_DEFERRED and cope with deferred client-connect
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--GVa1wdIo6zwq9rsO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 16, 2020 at 03:43:10PM +0200, Arne Schwabe wrote:
> This patch moves the state, that was previously tracked within the
> multi_connection_established() function, into struct client_connect_state=
.  The
> multi_connection_established() function can now be exited and re-entered =
as
> many times as necessary - without losing the client-connect handling stat=
e.

This looks much nicer now :-) - I haven't done a full review yet, but
I fed it to the test machine, and it seem to have liked it.  Including
"2.2 client" and "2.3 --enable-small client" now... *brag*

22...
Test sets succeeded: 1 2 3 4 6 8.
Test sets failed: none.
23.small...
Test sets succeeded: 1 2 3 4.
Test sets failed: none.
23...
Test sets succeeded: 1 1a 1b 1d 2 2a 2b 2c 2d 3 4 5 6 8 8a 9.
Test sets failed: none.
24...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 4a 5 6 8 8a 9.
Test sets failed: none.
master...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 5 5x 6 7 7x 8 8a=
 9 2f 4b.
Test sets failed: none.


The test setup is using --client-connect and CCD/ files, but no CC plugin
yet (nor management console).  So it's not excercising all these code=20
parts very well.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--GVa1wdIo6zwq9rsO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfEGwpAAoJEB2Cnv7KVigS8+cL/RDo1WGa9HZxiBlusP3bzeJE
abQI1kvPNSrsFYb0GPo8WuYJd9AmQBGQOG5gOZ7jffwXzwM1T0ex+ZqSFmVEcAX7
eDYxbPLWoV6ncEKincKj3gv2nrzcCJwNUELDFPTjjw5CtTQHjXTMrAd0lUet66db
e+tHOJMNjpXuIvQgaU2mogCnxjmMsl3JpI333fMRREPSuSleGdU6Y7lmapPLzFP4
UWlRLR5pTtgfrhN/18W/f0RqUzskFPmpW/aynSoplNGmH2uYHZSmJg1Aq9GIoAIE
0eXKITLqGF0xFEBWlYeTAfpHiHrvkI8tvUM/anFbVR38B9Ung+QJe6LprTjDHwVX
HercnMSeFmYvoJ81/OBH6qKucPKl6EJwLhOY59GLUf77umBbehk4BVtXfSmo/Xxk
41IHOYOD0cVwBOzbQGWO2lttxljpcEQPIEKWiF4SaA9JArAiSzCPS8DbFt/Ss9BO
/waoWmYZpBUcmJ97mtSoYpgl2PysCO6xo1zeocSwMg==
=JJp9
-----END PGP SIGNATURE-----

--GVa1wdIo6zwq9rsO--

