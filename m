Date: Fri, 26 Mar 2021 11:42:11 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210326104211.GU976@...1296...>
References: <1538820128-27086-1-git-send-email-lstipakov@...277...>
 <1540904039-2129-1-git-send-email-lstipakov@...277...>
 <20210326071222.GR976@...1296...>
 <325f28a6-127a-f10a-dd94-5c76cc6c4f69@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="X9cx+3x+TQg2AyNe"
Content-Disposition: inline
In-Reply-To: <325f28a6-127a-f10a-dd94-5c76cc6c4f69@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v4] Improve "recursive routing" warning
 message
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

--X9cx+3x+TQg2AyNe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 26, 2021 at 11:30:31AM +0100, Antonio Quartulli wrote:
> We have two options now:
> 1) extend documentation (basically what part of this patch is doing);
> 2) rework this feature entirely.
>=20
> If we go with 2 I guess we don't even need 1.
>=20
> I'd go with 2, because this feature as it is now is not really
> meaningful to me.

Well, "not really meaningful" depends a bit on what "this feature" might
be.

The original feature (disallow recursive routing) was needed because it
prevents a CPU meltdown under certain conditions
=20
 - the VPN server IP address is part of the network that is routed
   inside the tunnel (due to "redirect-gateway" or just because it is
   part of an ISP block)

 - the outgoing interface flaps or changes, and the OS removes the=20
   "bypass route"

 - packets sent by OpenVPN are sent by the OS to the tunnel interface,
   re-encapsulated by OpenVPN, forever


This breaks setups where "OpenVPN traffic" is handled specially (route-poli=
cy
on Linux, VRF routing, protected socket), and users *want* to access the
VPN server IP via the tunnel - like, because there is http traffic on the
same machine that is not accessible "around".=20=20

So, --enable-recursive-routing was added to allow "suspicious looking=20
traffic" through the tunnel, under the "I know what I am doing" rule of
shooting-your-own-foot.


The existing debug info gives too little information to differenciate
"is this openvpn traffic or not?" but I find the extra code needed to
log this to be excessive for the benefit - but, yeah, thinking more through
it, since that code got written already, we *should* use it to only
block OpenVPN traffic ("same proto and dest port") and permit everything
else if the OS sends it our way.

And document more so users do not get confused more than needed :-)

(And no, adding #ifdef is not a useful approach)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--X9cx+3x+TQg2AyNe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgXbqCAAoJEB2Cnv7KVigSBxEL+gJofDvtckQz6Bpk9aAKjSQV
9VBsWBiHISD5OsausjIFrGbgnaUpWLOzewwaAmkP2j63et9NsudyAcPs4nVfs4NQ
f7gLJ2zUuIpQxaRUlQdvszRi837GhiNPvDd+UlMqdqopaAvhU9PeLdk/2KF2rNVG
UVS6bXiXEeG6CqguEy9uROiZdN41CL4QHxv2nf+zTzRaPDFDEfQ0sVLf+W0/fpY+
q8C1d6o3qelVZY4XJZYr81PdP2Mc8mk726/tZ8OWfB7ABD9uSQ2S3ZWLAkpzSVOR
mio+T7qgaOwbeKl7Sx+M7rAm99hIzA9KWTNKDBw3OK9sDyL8ChkQuGddT2fk2eEE
JHBoN641s8GLw40ER3nnh598vwr1Mo8zb6mfCE+R8LEbJ2TOjj187zrzRJHgYDEs
eMbGlZjfM78tP3P9PCExEs8MAUcYnoaNrtUzEw5jbezpQ/CEOwVS9AvV+7NS+BM6
HGePOPLkePwujE4h5ZZ4Gm2H5jMZIJWyE/kMHKOKTA==
=8W/W
-----END PGP SIGNATURE-----

--X9cx+3x+TQg2AyNe--

