Date: Tue, 12 Jun 2018 13:58:38 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180612115838.GE57262@...1296...>
References: <20180608052017.6696-2-a@...2181...>
 <20180612074240.18865-1-a@...2181...>
 <20180612092937.GA57262@...1296...>
 <830e09cf-7902-4144-bce7-5ff6c5081225@...1227...>
 <20180612111710.GB57262@...1296...>
 <8bcd8c52-6acb-5b3f-269a-f234a38732bb@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="muCgbjpVrpBl/HUE"
Content-Disposition: inline
In-Reply-To: <8bcd8c52-6acb-5b3f-269a-f234a38732bb@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3] **Android** note: tun: ensure
 interface can be configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

--muCgbjpVrpBl/HUE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 12, 2018 at 01:55:17PM +0200, Arne Schwabe wrote:
> > ... but now I do seem to remember that you collect *all* information
> > first (IFCONFIG* and ROUTE*), so it doesn't really matter in which order
> > the "core" sends it...
>=20
> Yeah, I do. At the moment I think I need ifconfig before route but that
> is not a bug issue to change that. Only thing that I really need is that
> opening TUN happens after everything else because after opening tun
> there no more changes possible.

Good.  We won't change the open-after-ifconfig thing today :-)

(I am slightly tempted to tackle that one, eventually, as Android is the
only platform left doing the "reverse order" dance now that windows=20
has been changed to "normal" with the introduction of the iservice...
but not today, or this month ;-) ).

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--muCgbjpVrpBl/HUE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbH7VtAAoJEB2Cnv7KVigSW2wMAJZAfl8ggUEUViY57AUunYAN
sFeN6BfqW8HFCq6rpwaHhfkNHX3bF5eA2y84yAJp1MKghwMDba1msX/XtGkqhSAk
kqfUkkpMylqw9CFVMIju3O4fEDxTXnwFu0abrOgP6sYiUxLkqXeGksub93AKuClz
uVJA6RbBq10hDd8uvK0DuY3+s6rPKVY45kmmahE8kaNJApI0s9AUvWDHhoXBx/h7
MlEA+JRpj/jw8t68IQZRscWaJ1kTEuIBL2Trtjp18iSONzbtzMQvLs7Mnrjar243
MK6/L0UDg/SUG0f5xK+RTwXLJfzo1hruJREId31w7P4/rtfG/MhqOQAaQNdbYZS/
8e4FtiJsPO9MMSIH4wh24c89JGsUTM+5h/kmGeybP4E6Zubl1L+HPyJtjgdkBCBk
ujcOZPTcZeZp7DoMXXAV41SxBe8FEnBBAy7i7l/PYd5WGn0zS38oPqPCnZ3Ff+uj
OwzEb9Gym0dvfoo5thrFX2YIUmwxLSJbzXF/wtkYiw==
=Y8fC
-----END PGP SIGNATURE-----

--muCgbjpVrpBl/HUE--

