Date: Sat, 8 Dec 2018 09:03:05 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20181208080305.GR962@...1296...>
References: <20181207123303.70827-1-gert@...1296...>
 <4e683bf2-541b-b320-5166-5753716e75ca@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="hfgAxNVv3cGfhs8o"
Content-Disposition: inline
In-Reply-To: <4e683bf2-541b-b320-5166-5753716e75ca@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Add 'printing of port number' to
 mroute_addr_print_ex() for v4-mapped v6.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--hfgAxNVv3cGfhs8o
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Dec 08, 2018 at 09:47:37AM +1000, Antonio Quartulli wrote:
> > +		    /* we only print port numbers for v4mapped v6 as of
> > +		     * today, because "v6addr:port" is too ambiguous
> > +		     */
>=20
> The comments above are indented with tab+spaces, while the code below is
> just all spaces. Please use the all spaces everywhere.

Gah.  That was the intention, but the comment was added later on and
using the wrong editor :-)

> > +                    if (maddr.type & MR_WITH_PORT)
> > +                    {
> > +                        buf_printf(&out, ":%d", ntohs(maddr.v6.port));
> > +                    }
>=20
> I don't understand how is this solving the ambiguity?=20

These are *v4* addresses, just masquerading as v6 in the socket structure.

So 1.2.3.4:567 is never ambiguous.

For "true v6 addresses" (the other branch) we keep on not printing the
port number.

> Or you are just
> saying: "we can't do much, let's just print the port anyway"? My
> suggestion would be to surround the address with [], so basically change
> the printf format above from %s to [%s]. Does it make sense?

This is something I want to discuss.  Changing mroute_print_addr_ex()
for "true v6 addresses" and printing the port number in a new format
will affect status file printing, management interface, etc. - so it
needs to be well considered.

*This* patch just fixes the discrepancy that v4 addresses are printed
"with port" if doing "proto udp4", and "without port" if a v4 connect
comes in on a "proto udp / v6only=3Dno" socket.  (We do not need to discuss
how many problems the v4mapped v6 address format brings with it...)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--hfgAxNVv3cGfhs8o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcC3q4AAoJEB2Cnv7KVigSWQML/0HHVFAwKCXhm/oKWO3BXT9u
76VVDAqezrTXKaoPUhjdtBl5AuBDsLHImjHmjDSf8gQayzTjlUp7Bp/CnCgaNOqL
1Ifoe323IeTa1DQShrehz6h7sWAjSB3aHVofHrOLBPsGDvWyCVAaqjSNxvRemX3P
i6kI1c+jgaVHzYGqAc3hdVy15JDRDPFAmQTDSMMot4repVeML5LLZpI8pASpr9pv
qrS3v5hhcYqydQlIXRHXJK3kSG1EWvp89tsZTIgzRZCvZuoTnrUWQR7e4IWCaIeD
8J5rjKQmqtzBikvxaXY9+5Ml2qlBJjHQtI+LT66CeHayqs425L5+cAu/Wu51tfc+
8BhyX0XEP8ZXzmDLYFoRMUibRItUVdZL5tjIZnOJW57KeQxfa59qIOXcxmWqJxBX
Img310grprJOiwXPf71KRKepjky4C/H6MEwIwvQQ34KKOEPTBdQkekb4DzoLHZ5i
H+5Box1y1CJJV4CFrb232EWYXGksULrrqXiRJskARA==
=Rx1H
-----END PGP SIGNATURE-----

--hfgAxNVv3cGfhs8o--

