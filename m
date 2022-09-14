Date: Wed, 14 Sep 2022 09:41:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YyGFrlqn1i1ehmJi@...1296...>
References: <202208301957.27UJv74w093000@...2054...>
 <20220912074149.31160-1-gert@...1296...>
 <432af4cc-081c-f20c-ec3c-72d9589786b6@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="48V5wnzt742KQRLE"
Content-Disposition: inline
In-Reply-To: <432af4cc-081c-f20c-ec3c-72d9589786b6@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Improve documentation for --dev and
 --dev-node.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--48V5wnzt742KQRLE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Sep 14, 2022 at 09:33:46AM +0200, David Sommerseth wrote:
> > +  What happens if the device name is not :code:`tun` or :code:`tap` is
> > +  platform dependent.
> > +
> > +  On most platforms, :code:`tunN` (e.g. tun2, tun30) and :code:`tapN`
> > +  (e.g. tap3) will create a numbered tun/tap interface with the number
> > +  specified - this is useful if multiple OpenVPN instances are active,
> > +  and the instance-to-device mapping needs to be known.  Some platforms
> > +  do not support "numbered tap", so trying ``--dev tap3`` will fail.
> > +
> > +  Arbitrary names (e.g. ``--dev home``) will not work on most platform=
s,
> > +  with the exception of Linux and FreeBSD with the DCO kernel driver.
> > +
> > +  There, arbitrary names are allowed, and will create a tun or DCO
> > +  device named as requested.
> > +
>=20
> This is confusing and not quite right.  I've used "--dev home" for a=20
> long time on Linux with tun devices.  But it requires "--dev-type tun".=20
> There are no dependencies on DCO in this use case.

The sentence above should have read "Linux and (FreeBSD with the DCO driver=
)".

FreeBSD *with* DCO can do arbitrary names, without, it's "tun<N>" and
"tap<N>" only.

Suggestions how to word this better?

I'll add "if the arbitrary device name does not start with 'tun' or 'tap',
Linux needs a --dev-type tun/tap to tell".


> [...snip...]
>=20
> > @@ -93,6 +112,11 @@ routing.
> >     both the network connections control panel name and the GUID for ea=
ch
> >     TAP-Win32 adapter.
> >=20=20=20
> > +  On other platforms, ``--dev-node node`` will influence the naming of=
 the
> > +  created tun/tap device, if supported on that platform.  If OpenVPN c=
annot
> > +  figure out whether ``node`` is a TUN or TAP device based on the name,
> > +  you should also specify ``--dev-type tun`` or ``--dev-type tap``.
>=20
> IIRC correctly on Windows (too many years since last time with a more=20
> advanced setup there), --dev-node does not influence the naming of the=20
> tap-windows6 interface, but is a reference to the pre-created interface.=
=20

Windows is not part of "other platforms" here, but covered in the preceding
paragraph -> so, yes, that's what it says there :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--48V5wnzt742KQRLE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjIYWuAAoJEB2Cnv7KVigSNxEMAJsJzck8onlw0MCHys2tMjXC
DrjUpy1/IDizPR0BkNxSrTzmPYfoQf1KqYjMzhTi+nmuvuOe1S7JRB+R7MUftKnp
PWKURa4ejeXevmM3JdgVyF/yKhaDvKrxz4zR1He6J7069WOmEuvGO2CwzhTYffDS
Q+B9r9/zmkgOttiN8VGlqKsBshkM82IGuaQXt/BV6FKTRWCKZakAl+w/lESocgRv
7ZF5ejrIOxWHwJOnF/Rcd690BX9uCMQbwJHLpWKbUwRAsHEWr/jEfp9A6aSQ1S5L
YJig5WArgrbGFIvhWYKx7vT2xZQ0N2uZZVfP2KYHU2KKUIbttllDf4wKF2M9YDLl
gGlEB5QcmEkBCOzBJPlanwds/U8Mg8gsN+CXzPYHnUYlll/Y9720foBBvFVLpa/S
S1IfI9+k71pwzthgvybRqUnLdrIwoUhX3Hk3PvUY6S+p74HGHZMwEhALDcTQ3+za
MDteOWPX9mxeWV989TWWeaHxsv4Z+Ksd4LNIbOXJnA==
=zMQj
-----END PGP SIGNATURE-----

--48V5wnzt742KQRLE--

