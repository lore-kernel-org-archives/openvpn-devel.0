Date: Sat, 23 Jan 2021 13:26:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210123122637.GD976@...1296...>
References: <20210121133929.20186-1-gert@...1296...>
 <35ab1fab-6943-e734-789a-94d7cdbeb25a@...1227...>
 <4ac189fc-41e9-a220-5578-73ffd736122e@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bJM78SQV1FnJvNGj"
Content-Disposition: inline
In-Reply-To: <4ac189fc-41e9-a220-5578-73ffd736122e@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Make OPENVPN_PLUGIN_ENABLE_PF failures
 FATAL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincanteksup <tincanteksup@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--bJM78SQV1FnJvNGj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

(while technically in the wrong mail thread for the "should PF stay?"=20
discussion, this is still interesting)

On Fri, Jan 22, 2021 at 07:39:31AM +0000, tincanteksup wrote:
> I agree that a VPN should focus on its task and not try to be a firewall.
>=20
> I do use the PF plugin but it is of little, if any, actual use, which is=
=20
> not handled better elsewhere.

Which PF plugin do you use?  defer/simple?  Or something else, which is
not a Big Gaping Security Hole?

> I do not pretend to understand the intricacies of the code but if=20
> removing the packet filter plugin is relatively simple and clean then,=20
> from a user point-of-view, it makes more sense to drop it. Less=20
> complication overall.

If you look into the code for places where you find ENABLE_PF or PLUGIN_PF,
you can see that it really touches a LOT of places - and every single line
of code increases the chance that it breaks on future changes, unless
someone invests the time to write test rigs that test all these code
paths (which gets increasingly complex with some features).=20=20

Even testing all the "how is a packet forwarded or not?" paths might not
have caught *this* problem, as it is basically the "I have enabled PF but
the PF initialization failed" corner case which is often overlooked when
building tests for "I have enabled PF and want to make sure PF works!"
case...


So, yes, ripping this out would make the code much simpler in some=20
critical paths.  OTOH pf can do nice things you can't easily do with
a linux firewall, like "accept packets from this *other* client only,
identified by common_name" (without having to know the actual IP
address and subnets assigned to it).  This is nice.  But if it is not
used, it's more "theoretically nice" and still can get kicked...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--bJM78SQV1FnJvNGj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgDBX8AAoJEB2Cnv7KVigSzXQL/ROM0AKF7dwaibsaoDlP7wW7
KlsU5cIhu1jV8PnXlOsO11/FEKA+VIV/HCKcW57g45lYWd5mpbx5Fh4gxvWvRRoa
RletCRbP5DhAie5YvNbw+f7pcYyNivsWQ77X8f5dxdHloClNEu5vlnZefPSBeMNu
so7MJ/6AezfKbmN8zYLxOTxvN1YjNeGXPTacOY6I0ALTneuiPlRzHNXeddSUp32/
m0Ffhj++E9x8OpOixdFzpSs/6DGF79fcnG0U64emypk9G+m6osMGXpvoVZ3RQYm8
os5azpaAfWgPUg+6rtDnHZmAdNnvibCGmQBmCC6FoVKDDrt5l2AOXMOoJRy/qsJW
ITrV5OwUkavihdVn0e1786OA5BXvPg5Q/wlTP4WZ5XtufN/DmCmHi8kCO6B/I9jL
PkbkBkEXHqUrqn3mCCB0rkWtPRUxjyBHtqS9oNA66IQWVNbyG8h9bBOD54DEbnTw
xj4clqGeYsufve9g2dmm3mBUWoP3MUaP+D3CWNckiA==
=2heY
-----END PGP SIGNATURE-----

--bJM78SQV1FnJvNGj--

