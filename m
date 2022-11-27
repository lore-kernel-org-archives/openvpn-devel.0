Date: Sun, 27 Nov 2022 13:31:00 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y4NYhDjmQGgBHEIm@...1296...>
References: <20221127111845.11310-1-kprovost@...2661...>
 <20221127111845.11310-2-kprovost@...2661...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="j+xDx7IOlS+WjWqF"
Content-Disposition: inline
In-Reply-To: <20221127111845.11310-2-kprovost@...2661...>
Subject: Re: [Openvpn-devel] [PATCH] Read DCO traffic stats from the kernel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristof Provost <kprovost@...2661...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--j+xDx7IOlS+WjWqF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 27, 2022 at 12:18:45PM +0100, Kristof Provost via Openvpn-devel=
 wrote:
> From: Kristof Provost <kp@...1376...>
>=20
> When DCO is active userspace doesn't see all of the traffic, so when we
> access these stats we must update them.
>=20
> Retrieve kernel statistics every time we access the
> link_(read|write)_bytes values.
>=20
> Introduce a dco_(read|write)_bytes so that we don't clobber the existing
> statistics, which still count control packets, sent or received directly
> through the socket.

To briefly summarize our discussion just now

 - the general approach "pull data when needed" seems to be good for us
 - nvlists have no general size limits (so we won't run into issues when
   there are "MANY CLIENTS" active")
   - but kernel side DCO today has 128 peers limit on FreeBSD "to be done"
 - this patch can not be merged "as is" as it breaks Linux and Windows
   (because the neeed DCO handling functions are not there yet) - but
   having empty stub functions would be trivial
 - there is a racy caveat on "peer timeout"
     - kernel sends message "peer went away, because timeout"
     - we go to the "run --client-disconnect etc." function handling
     - we ask the kernel for the DCO read/write stats
     - the client that *just ended* is no longer there, so, no stats
     --> we want a notification for all "peer has exited" even for=20
         "userland has told the kernel to" reasons (what Linux does today),
         and that notification should contain the counters *for this peer*

 - we want lots of feedback from Antonio :-)

Arne, anything I forgot?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--j+xDx7IOlS+WjWqF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjg1iEAAoJEB2Cnv7KVigSW1AL/0yDyBCn23d/4Zhnt56oQJn/
uYYPB3OAPEI5fsotyOHlOBPjB0vC+cPYic78nMYe/GoQOsmUJY2UTjIbGbw8SXVn
5rvBoYXC7kENyllI2Oc8SJQKWxWqvOilCLzOh/01wDvC7TDagMRnqzpllCF8n9gj
Xw+/Ommb6uHr5FrkZWW2FCP9SwrkX5EYJ79f7YEy6nFjKiqa4D7UfoIp3i8v0cUd
YtXVzO/dJWF78xtdD/AOwBQN3D1Ufsa5WZ+RHIAPa3Llob6ca2hCUI99v1ojYgy2
6hqFnqHF7ZMOh9IxYOJKYkYtkBd9tTIterUkRlIarY3rOkSSsZ1BwdFNPAZ2xlkw
85lqHqDivCm5yEbSn2ryAlcpch4K9g5mbFSzoAhdoJUhAtYAfKAaqKBw2lwCAShf
a+QvUNot3SmAWOrdGB9wqAe+EU7rj74xqMSbYx80bjpJIFE9tmsTLZO4trUK66D1
7y9TAaegYQ9zPQNGXXaba23tV3ntwHrhjP5rkckqRA==
=JyWJ
-----END PGP SIGNATURE-----

--j+xDx7IOlS+WjWqF--

