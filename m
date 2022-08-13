Date: Sat, 13 Aug 2022 10:10:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yvdcec3CsvyYUKUx@...1296...>
References: <20220808143424.65924-1-kprovost@...2661...>
 <20220808143424.65924-3-kprovost@...2661...>
 <YvPdlCSxQ6wvfIna@...1296...>
 <2DCBB302-1FB4-4EC0-8B4A-8D6EA075B0FD@...2661...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="henCjble42UayWvW"
Content-Disposition: inline
In-Reply-To: <2DCBB302-1FB4-4EC0-8B4A-8D6EA075B0FD@...2661...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] ovpn-dco: introduce FreeBSD
 data-channel offload support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristof Provost <kprovost@...2661...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--henCjble42UayWvW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 11, 2022 at 05:25:05PM +0200, Kristof Provost via Openvpn-devel=
 wrote:
> >  - running openvpn over TCP gives me a kernel panic - this is not so
> >    nice... (see attached .png from the vmware console) - userland seems
> >    to assume "kernel can do TCP", kernel panics on "if !udp, panic()"
> >    (so intentional panic, not corruption panic).
> >
> >    This is on freebsd git FreeBSD 14.0-CURRENT #1 main-n257130-c0665d5c=
824
> >
> I???ve pushed a fix for this panic in fd6b3bede5a5c210f327e5c9bd3e415ee90=
5048b.
> I simply didn???t think that user space might give us a non-UDP
> socket, so checking for that and rejecting the peer in that case
> fixes the panic. Thanks for finding that.

JFTR, I have tested "main-n257320-3a3af6b2a16" with the old DCO userland
patch, and it no longer crashes.  Of course the TCP tests failed, because
userland only sees "mmmh, it fails!" but has no idea it should fall back
to non-DCO  (with the new userland patches, this works).

In case you plan to include kernel TCP support, it would be good to
have this "soonish" - like, before FreeBSD 14 and OpenVPN 2.6.0 release,
because otherwise this will be a bit painful to synchronize.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--henCjble42UayWvW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi91x5AAoJEB2Cnv7KVigS5lwL/iXaJxMRnuWTPtUb9wI2h1J9
emDXRRWmCBsnLnJTy5s0bSdenWlMQsK3noDMsRKUiRj+IaxdJl0St0QLzInYdN30
qW23BxpSe4EZrulcXRSIVAma2IaiQGXE7bB0iNZnzTe9a+4QHEQSKPuUgVmWiY23
bBVCyi5Y4YFB9Rt18Nb78CtdRtZka/uegbOFuS+x0fyNNRtHn6Gi/Wu+34HoXJnl
Lg0KlJ5A6aFK3BUc9CrxPLJ7vtxg+LI84+YH1nAOw6O4H/t21od94yqnEIcmUWJC
in7RN/XfCn8ol3mN7BIRdCsucRceOjWEAVSZTt849nKHlr+W/2xsTF7S5WeGz5OA
YQDqFg+I3TTfYYa85dTynyv8WrRJtqR0UxtEI0wzK1RM9AtgVxSH10FO2DGcgvr9
GpZDPw/QvnJeS1XlTEkaaBmo/+y5r4k61daalM9u7C27nWypyAE9dyYybx+wIy/4
phmSAZVgEbO8/qke/OUmfhKD+D4ULdCWsUHzecWQhA==
=2s5j
-----END PGP SIGNATURE-----

--henCjble42UayWvW--

