Date: Wed, 15 Jan 2014 09:29:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140115082942.GN226@...1296...>
References: <20140113185822.GV226@...1296...>
	<52D51737.1040201@...1114...> <52D5A65F.2060807@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dQ2UWBmeJhPxzxhA"
Content-Disposition: inline
In-Reply-To: <52D5A65F.2060807@...1227...>
Subject: Re: [Openvpn-devel] RFD: <net/route.h> and struct route (trac #340)
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

--dQ2UWBmeJhPxzxhA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jan 14, 2014 at 10:04:31PM +0100, Arne Schwabe wrote:
> I have not really an opinoion about 2.3 and what should go in there. At
> the moment it feels like release/2.3 is a "baby" master since almost all
> changes are cherry picked into it.

My current "rules" for application to release/2.3 are:

 - obvious bugfixes
 - changes important for long-term usability of 2.3
   (I think the main examples are TLS version negotiation & PolarSSL 1.2)

what does not get into there is

 - fundamental rewrites (dual-stack patches, preresolve patch)
 - large new functionality (the android patchset, the windows service pipe,=
 ...)

so there *is* a difference :-) - but as long as we're mostly committing
bugfixes, it indeed looks as if everything goes into both branches.

These days, there's "lots of bugfixes", while I'm working my way through=20
trac...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--dQ2UWBmeJhPxzxhA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUtZG9qkuBuNlUUl1AQLHWAP9Eg2xIB1H3ihHpotgiERTkqRZaB/qKRps
NW+ZBUt13UEp5UcunrXim0Z4sQYdgN3wMcUc9yoQiccoETWORmgXaoGI7QTOrYDh
a/XECZ3t9SdtfXZzn/biPXtfgMphh0xq+64FcYq2VPb9oE6Xls/YAbIuN8S8ArT2
BWaPcSxDiaw=
=XJRJ
-----END PGP SIGNATURE-----

--dQ2UWBmeJhPxzxhA--

