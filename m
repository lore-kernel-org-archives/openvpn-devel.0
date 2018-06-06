Date: Wed, 6 Jun 2018 09:00:35 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180606070035.GW57262@...1296...>
References: <CAJY0qZKNO_aamQfi56BG_XK2vrOCyPAQf-My1N56qqV7TsUG7A@...278...>
 <eaae68e6-e30d-f63b-59c5-64515c8f8bcd@...1147...>
 <e4a2d28a-ff8d-4797-e0af-3bcf98828cb3@...1856...>
 <CAJY0qZKw+HgQ1vS-W13nw2=gj8d-uxeOqyZia4-gEbaGNTyFLQ@...278...>
 <03a13b39-7b85-0b67-cc94-7b219e6b209f@...1147...>
 <49b53be0-a301-8447-2a0e-0534435e5e87@...1147...>
 <CAJY0qZ+_kEVS_41oOHNX=Wp47LnNhL0HKRZvR75eg7JNW3tLkQ@...278...>
 <20180605184024.GO57262@...1296...>
 <CAJY0qZ+r_fHPW-+BAmj2=2qS=k7vQS+Bto0aHE7EDwcgtdaniA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kVcb4xucqmsYUpQy"
Content-Disposition: inline
In-Reply-To: <CAJY0qZ+r_fHPW-+BAmj2=2qS=k7vQS+Bto0aHE7EDwcgtdaniA@...278...>
Subject: Re: [Openvpn-devel] Does the OpenVPN protocol itself handle
 windowing?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Derek Zimmer <derek@...2095...>
Cc: Gert Doering <gert@...1296...>, Jan Just Keijser <janjust@...1147...>, openvpn-devel@lists.sourceforge.net

--kVcb4xucqmsYUpQy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 05, 2018 at 08:05:40PM -0500, Derek Zimmer wrote:
> The openvpn protocol does error checking and recovery on the data channel,
> right?=20

There's "control packets" and "data packets" in "the openvpn protocol".

For Control, we do all of it - windowing, pacing, re-sending, ... - but=20
this is just TLS, keying, authentication session setup, parameter negotiati=
on
(and our control channel is fairly slow due to a fairly simplistic approach=
=20
to all of this - good enough for the ~10-20kbyte initial handshake, but
not for serious amounts of data).

For Data mode ("tun -> openvpn -> network -> openvpn -> tun"), we do
error checking.  As in "if the packet does not pass authentication,
complain and drop it".  (We *might* do a sequence number check to drop
out of order packets

We do not do "recovery", as in "buffering, windowing, ACKing, re-sending=20
broken or lost packets".

> How is that handled? Or am I mistaken and it is all handled through
> the regular TCP protocol that is operating inside of the VPN tunnel.

This :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--kVcb4xucqmsYUpQy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbF4aTAAoJEB2Cnv7KVigS8q4MAIDy9tTp6uIrYTNd1KAHO06w
spC9HhwIM5TgcJ6c0AdPLIoB8zVbFcU2A5SXR5MJ2uMlgGSF3bgSVCJGX01dq6r8
C+HvenZ0HLvtDCD0Con92F3YgfwYnpn3/OweshIUkYs19ueMAXofxZQ9eoLcAyiK
4EvVFvy7tJy1VQbTy41uAJ3LOoPmQhPnMu+egvMuyS5jqK8aieMXdS83etvDozG4
kA2pM7hLn8YslEj1xqQBSkgc+a2V+WNxxgPLhMJUg5rpUMrGMOYytYbw0S8gu2z7
NBGhCK+RWv73xGFjIlenPCdR+9m7H+lpRW6RCbKaSufUJlVPSjVWiU1pFeLRHAqu
Zr2Mpa/4+c46e2X4OSoulOdD95dUTVOY5/ESf4uk9E07pb4gCv4/3xMdBAdnPql1
ReTlz/cz97rWnBWOWWZe7t+Yns/jN+fJKld/f0N7QMDO4gBiSI9i/Zqunr6nC+Vk
5MlhlUVV2rKRCoBf5LWDti7i5OX8DxE6jVpPOIChlQ==
=rIka
-----END PGP SIGNATURE-----

--kVcb4xucqmsYUpQy--

