Date: Mon, 18 Nov 2024 08:14:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZzrpT6DjykCOJwUB@...1296...>
References: <CAC8x_z10PT_ToTzVUKQENA5ZJgJ4EMvBJARphDR5_wdytA2JSw@...278...>
 <b7c9a1ac-3322-4eeb-befd-e19c7f72da6b@...1227...>
 <CAC8x_z3Fwf0r-BuvuOo+Vg0708fsaPGWjg-2pnY3xgM+e4QxDg@...278...>
 <Zzm_gUxTAmFZjm_h@...1296...>
 <CAC8x_z1OtkMeuRCHNOHfg-rcJ3Kcj2uHua3pzK5ZqKJDjPvBjQ@...278...>
 <ZzoQ7jXbImL56HL6@...1296...>
 <CAC8x_z2=DL=t2V5oN_hBMLbYcVMH78XqbTLguxFifjDco+zWyQ@...278...>
 <2dae1148-45d8-4f82-8b65-973b81a18645@...1227...>
 <CAC8x_z25-XQEyk0O34nKFMMj-mXNR2r+WbbaseX70mzzZKT+QA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LmYS5OnmtkSnjsub"
Content-Disposition: inline
In-Reply-To: <CAC8x_z25-XQEyk0O34nKFMMj-mXNR2r+WbbaseX70mzzZKT+QA@...278...>
Subject: Re: [Openvpn-devel] Subject: Potential OpenVPN Vulnerability
 Report: Repeated TLS Handshake Failures Leading to Denial-of-Service
 Conditions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ?????? ???????? <nsh531@...277...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>, Antonio Quartulli <antonio@...515...>, SECURITY@...515...

--LmYS5OnmtkSnjsub
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 18, 2024 at 09:09:57AM +0200, ?????? ???????? wrote:
> I don't have access to server logs, I sent you the client logs as well as
> the line pointing to the DoS:
> TLS Error: TLS key negotiation failed to occur within 5 seconds
> SIGUSR1[soft,tls-error] received, process restarting

What makes you think it's a DoS that can be fixed by a code change?

If you break the network, programs will not be able to connect - and there
is nothing "a patch to the software" will be able to fix.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--LmYS5OnmtkSnjsub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJnOulPAAoJEB2Cnv7KVigSXLkL/18ocv9jADmVzbLmcwepFghE
4BTWzJoJQnlzMJ+E7yRiEyViFDm9XyBgAOEMsyFJmvnbEaEyaxuCm3mp1M/Wm121
Vt+sKjl4SWqbrOZo9nInPt+9h1dZpQhH83/RYA1Buq8obmX3stFxpR2dIen/OEKC
uRSYIcunQP+7LK2Oa8XtPE0dU0nblyQb9+WudV8F9WXRlWQidrSTXbzbYvQ2EZmh
CaYzD5827N5cLnRhXYKRx5S/3tIYqGcg7PkMQ8DnQmnEZJLeuQSac23yB+3Pj8Bv
oJTsn6nEm/5qIsGVMOwGQ2EtfHNI8tp5vTK4qOHfwXeDXpieB3hXZfLA0vFYE7SH
6QlOYG4j9tpOe1sXQWT9PmYrwJ+fc19O9VBolm/PGaWKA0TEmwUhQy7DVdSli+zC
R5TvUnu84pyOIKvqYJPNeSckyTQXlES/VI/fWF2+7fUu4/AfyYBFrHG4C9+ioKjm
Y/KJ/oIxEWRXW4NcH0aX3iDWM5E0WyJWiVulWPrwaw==
=/WIi
-----END PGP SIGNATURE-----

--LmYS5OnmtkSnjsub--

