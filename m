Date: Tue, 11 Aug 2020 11:32:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200811093227.GE75094@...1296...>
References: <cc9094b8-caa6-34b6-ed7a-3ccb34560113@...1918...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="PSXRUCbmiibGgnYg"
Content-Disposition: inline
In-Reply-To: <cc9094b8-caa6-34b6-ed7a-3ccb34560113@...1918...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Send auth fail to client on
 reneg failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eric Thorpe <eric@...1918...>
Cc: openvpn-devel@lists.sourceforge.net

--PSXRUCbmiibGgnYg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 11, 2019 at 12:07:27PM +1000, Eric Thorpe wrote:
> This patch relies on Arne's "Add send_control_channel_string_dowork
> variant" patch.

So.  After we left you out in the cold for over a year (apologies=20
for that), we should revisit your patch set.

I checked with Arne, he says "no, that functionality is not in yet,
but still interesting" - and all the *other* auth/plugin/async/SSO
related code we had brewing is in.

So - if you're not too frustrated with us yet: can you re-send?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--PSXRUCbmiibGgnYg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfMmWqAAoJEB2Cnv7KVigSEUQL/3PCs3AJOE4M7KJJcUd2aKbN
Brz3GCmOw2eIwmxNud09aMgyFiNOloEuEFJiri77c5nmVJ7BCvbUC/BhSILcakQG
ClpeEOj1MDvD9ZjpIDpwI8tbWV3y2kIw5MR4au/6YfU18n707hFm6Td1emaaOjlX
7d5gHhuzPDgvmrIUgDxYctr6HFEIYOzDJXu+YgxUD++H8A0Jo7sS5CoN6mwyYjQw
QR0OCwE4tOJ9+KDhP6RKlXYR52n/AtTxcFg4xwr8y2PFobI+NWIPs7Zlc2qRrM+A
StNZkE9NdbZlK+gOMB9wrmC53BBPa1jeROe+5KIQac9ECdiFxxlpkTBgy5U/VD20
vb/0ebgwnz9MN3Shp2/dvVv3O0+3AreZVppt06f7o5gc7duX/kf9U+5kptsB7KP+
ul3PVCXZWEyBa8Q3VdlD2JTrwLFIglNauvyP7ZqBxV5vg0g2VmSve1eQoECK72+P
SB9Qh2/n/Nn+T9D0mJfxCIl6nA+0R+wtPykSB/+lIA==
=B125
-----END PGP SIGNATURE-----

--PSXRUCbmiibGgnYg--

