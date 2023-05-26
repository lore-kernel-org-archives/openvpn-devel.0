Date: Fri, 26 May 2023 20:48:49 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZHD_EateCOexc9-X@...1296...>
References: <20230509154657.2756-1-gianmarco@...2726...>
 <f4adb251-da78-754a-5738-688fde356f81@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UG3U4NOPUPbdz8um"
Content-Disposition: inline
In-Reply-To: <f4adb251-da78-754a-5738-688fde356f81@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Persist-key: enable persist-key option
 by default.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gianmarco De Gregori <gianmarco@...2726...>, openvpn-devel@lists.sourceforge.net

--UG3U4NOPUPbdz8um
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 25, 2023 at 05:39:10PM +0200, Arne Schwabe wrote:
> Am 09.05.2023 um 17:46 schrieb Gianmarco De Gregori:
> > -    bool persist_key;           /* Don't re-read key files on SIGUSR1 =
or PING_RESTART */
>=20
> The downside of always enabling this option is that you can no longer=20
> replace the certificate and key without restarting the server completley.

We discussed this, and wondered if anyone is actually doing this.

So, are you aware of anyone doing this?  Is there a reason I'm overlooking
why this is substantially better than "just do a full restart when changing
any part of the config (including keys, even if residing in separate files)=
"?

Hard restart should be about as fast as full SIGUSR1 restart - "wait for
EEN to be delivered, close everything, exit()" vs. "close everything,
re-read key files, reopen tun, ..."

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--UG3U4NOPUPbdz8um
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkcP8RAAoJEB2Cnv7KVigSVSYL/1XgGllBoRvXjlfUjZWcdioB
kDqimhfVYa4P4gkJSp86jnJiTcznGEf7AuUjkLkNXZfj9wEl+gHryi8h7jwr2Uoo
dKOBYMYH4YP6M6XGsUDjDxNgBPYIWVwMsKISQOsvF/3DG9Kvq/ahrC7tdDE5tQYZ
oPluYL5XPPYAED++aHR1mKnT+IUWXDBwhORPfU82DKHo537UaWCyTZSS5bm5iyW5
vhJZneexIWAp++an/4XX5HxIM+3iQ8CzFfeqNh0EFv38nI8A5BrY7+94Lgwk9c4y
7rKBDZflUGnVYKyXab3IwrYUVG8r3E111V8JwaDj2nl8K9VvXqs6sYfRbp11CEt6
IDCbRbmkrLW+2jhzu0e95ndw0ew/G+sRbemYrRuoq+ApTyV6mTpvn+A4XtXDLsBk
5mKuN1TXoP2wspGSodOafw8z5GN+E769eAxFR2vogFS4AO9EN4R64Ff+AhTcC20e
aMYizkZzoZ3Fg5JDlgEgJ0r6qg/MC7ZMC2R+6gRE3A==
=L2ho
-----END PGP SIGNATURE-----

--UG3U4NOPUPbdz8um--

