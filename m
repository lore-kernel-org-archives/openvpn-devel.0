Date: Thu, 17 Oct 2013 16:19:29 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20131017141929.GC161@...1296...>
References: <OF80C424FD.27405071-ONC1257C07.004692C7-C1257C07.004BC866@...1846...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w3gPeeaTISh83WAP"
Content-Disposition: inline
In-Reply-To: <OF80C424FD.27405071-ONC1257C07.004692C7-C1257C07.004BC866@...1846...>
Subject: Re: [Openvpn-devel] Openvpn 2.3.2 potential memory-leak after
	24hours (addendum2)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: arno.odermatt@...1845...
Cc: openvpn-devel@lists.sourceforge.net

--w3gPeeaTISh83WAP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 17, 2013 at 03:47:44PM +0200, arno.odermatt@...1845... wrote:
> Pls. can anyone provide me with a response, whether this mailing list is=
=20
> the right place to deal with this kind of problem?

It is the right place to deal with this kind of problems.

The problem is that nobody seems to have time to start debugging this=20
into more detail yet.  What I'd try (if I had time) is to compile=20
OpenVPN with valgrind (a memory leak searching tool), run it through
a few client key renegotiations, and then check the output to see
whether it shows anything "obvious".

In any case, thanks for tracing this so far and making it clear to us
that we have an issue there.  Even if it looks like nobody is caring.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--w3gPeeaTISh83WAP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUl/x8akuBuNlUUl1AQLt1gP9Hq5+HKhNjPGqDeYz4B28vlgrCIFISZ/N
s6k/9E9BQoaPfsKr23RBhbk+O5/WNNr73dVzbJa5pfdbiFiErtCgszqt9BxgGhlG
BZzZ8u/PX0OaIDkNGlJabLcpiq4MScHkJXD+5FlZ/iV6J7qxUSj0VEkXAJD+CU6B
PYmTjHQeV0g=
=yTOn
-----END PGP SIGNATURE-----

--w3gPeeaTISh83WAP--

