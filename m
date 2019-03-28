Date: Thu, 28 Mar 2019 18:21:13 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20190328172113.GH31008@...1296...>
References: <20190328122701.7396-1-cschenk@...2502...>
 <1363f761-21e4-f5e6-8c49-234e1339bc3d@...1227...>
 <CAKuzo_gmJSuz0vYx+YugB4qcz3M8MRWNEVw3FuHXsL2KKRSH2Q@...278...>
 <8810F588-F84A-45A9-96D1-62853F9E7BB2@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
In-Reply-To: <8810F588-F84A-45A9-96D1-62853F9E7BB2@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Setting adapter mtu on windows systems
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marvin Adeff <volleynbike@...277...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Christopher Schenk <Christopher.Schenk@...160...>

--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 28, 2019 at 09:33:43AM -0700, Marvin Adeff wrote:
> From a user perspective, there should probably be a way to disable any pr=
ogrammatic setting of mtu.  In our usage, the same network interface that O=
penVPN traffic goes out on often also must carry large traffic to other des=
tinations that not uncommonly go through some low mtu path. In these cases =
we have to manually set mtu to a setting that most likely is much lower tha=
n OpenVPN might sense it as.=20

OpenVPN will not touch the LAN MTU, just its own tun/tap interface
(and it does not look at "outgoing interface MTU" anyway - it will
do path MTU sensing if supported, or just statically calculated).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcnQKJAAoJEB2Cnv7KVigSM1wMALRQeUIgFso+9OycjB+2bBgo
TwpNYvj59UYbeETfXhocdBLcRamDYBG8dxnF/iwePHyL2EYJKhHjuTF5sdGI9Xk8
FAYiiPuZTXVxgBrTwzar/ev84QnLaEEZ9012YkvEqJUJqSUfAGoTkXBY7vo8KdK7
cIJmRJqb0nlD4hXqNu6n9JWQPyx3fPHIuO5YfklxnXtCOXt+Pv0EwgMghC66zNnL
b+stZdpuXQ4ED1HyLr5kgTCKTZcaluaZs0J+xTgpSyv74mKp0oJSSR4n9rAb0Hl4
974sXmW/lsLJXQSdIcNLgqz0pCMH05fbZ1q2icOJbZ/cVjGq1K5EBlqzni4LmUyc
p9RrTT9Z0Y91AbtwF2/MEWSc39TRXwP4snJheMY8nZJzfbpUD8BzfooYL1Vs+F95
k9soKb4cpYSh4N6PZH6/VPk8/1C+FqQqBPRk2FhYuTnJD7dyGq54TwB1C1Isn+8u
3bGa5v2D0PcCYrxy5fhk4S7oh8sXzDyuRYTPogezHw==
=+a0K
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--

