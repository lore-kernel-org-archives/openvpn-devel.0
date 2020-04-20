Date: Mon, 20 Apr 2020 14:40:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200420124023.GS1431@...1296...>
References: <20191127134258.9162-1-l@...2534...>
 <d21e5944-44c9-9fd0-ab77-b47c65c93663@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="s1QkCFPfJT0XII2l"
Content-Disposition: inline
In-Reply-To: <d21e5944-44c9-9fd0-ab77-b47c65c93663@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Fix IPv6 configuration on Windows using
 netsh
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Laurent Fasnacht <l@...2534...>, openvpn-devel@lists.sourceforge.net

--s1QkCFPfJT0XII2l
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Apr 20, 2020 at 02:28:28PM +0200, Arne Schwabe wrote:
> Am 27.11.19 um 14:43 schrieb Laurent Fasnacht:
> > Apparently, `netsh interface ipv6 set address ...` defaults to using
> > a subnet of /64, and therefore adds an onlink route of that size.

Ah, there the patch is.  I was looking for it recently and could not
find it...

> Instead changing the implicit /64 to an explicit /128, wouldn't it be
> better to use the correct tt->netbits_ipv6 like on other platforms?

No, due to the way we hacked ND in tun mode.

For Windows, this is still a multiaccess network, but the TAP driver
will only reply to ND queries for his gateway address (fe80::8).  So
if you use the correct netmask, Windows will send NDs for all hosts
in the /64 or /80 or whatnot, which will fail - no ND on the tun
interface, and nothing in the driver to translate.

(Now, my "tap-to-tun adapter inside OpenVPN" would do this, because
AIX only has tap - but that's still unfinished).


Laurent: I'll see that I can get this fully understood, tested and merged.

Sorry for the delay.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--s1QkCFPfJT0XII2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJenZg2AAoJEB2Cnv7KVigSPyoMAJZ12TklRQKb6IwXDHUxKkfc
/Os54PXjruup7N+y5pkHboUnVv24MC1Ww2IsqmbdsKTTNDZeoQXgOlDgt4/kLPSY
I5n8pdOq2dExt02jJDAMRrdMgQPwxKSiSiDMjbRko9YNKkOb3+zM7L4MkNKWPkHc
xkHFLBNUcXvsl/6OboOrsA2TAJNjpIljzFHAt4sLcYshLmBmSKQpaEWcFXcAV2t0
WOB79w1mCZGZG9CkMj6t4FvjRsZow59aM2wF0TkC+1o2pgijfno72HzIPmiDzo9X
J936ZIxddx7WO+ckEOKHBrhCuBlbqZe8crZcU7vT0Ftq2x+SW8biHGWw3zKP3+D2
bYum1sYlHfAE6zxsyleDzCoBsSTw/GkNl4f9T4VXjyYLFvfMPKwCskx7QXK8qKNV
A4BFK+wiTj11es/ZDUcAbv376sWgpcJhnKXfwmq0TMzdzT2t//4xYnlpRRa0y6rC
DJU5bAw33Zst0V9ygkIp3WKQMIssMsRPNwj2cHx7ZA==
=4hiM
-----END PGP SIGNATURE-----

--s1QkCFPfJT0XII2l--

