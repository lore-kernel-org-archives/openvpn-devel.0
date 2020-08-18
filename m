Date: Tue, 18 Aug 2020 21:42:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200818194248.GC75094@...1296...>
References: <CAAWBBYPw=TZg1wftWZL5ABKVWkp7=6hpdaumLN2D24Cgr-E4pQ@...278...>
 <20200818062335.GV75094@...1296...>
 <20200818063212.GW75094@...1296...>
 <CAKuzo_jEGvTnkbsgJVm5beW5SapWoy_xLk_LA+-N59oa6SbbkA@...278...>
 <81A6F618-2F74-417F-A476-BF290CCFF143@...277...>
 <20200818181820.GZ75094@...1296...>
 <2F7C4631-7E3C-47FB-BC8E-E4271F38AD9F@...277...>
 <20200818192104.GB75094@...1296...>
 <CAKuzo_h2hLeQodHsJ7uzetq_XeGPJiu3i-o2tXuL29HbJcG6bA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="qL6YN2OI1pnKQLYZ"
Content-Disposition: inline
In-Reply-To: <CAKuzo_h2hLeQodHsJ7uzetq_XeGPJiu3i-o2tXuL29HbJcG6bA@...278...>
Subject: Re: [Openvpn-devel] 2.5-beta-1 Wintun requires SYSTEM privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, Marvin Adeff <volleynbike@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qL6YN2OI1pnKQLYZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 18, 2020 at 03:29:19PM -0400, Selva Nair wrote:
> > If you already have SYSTEM, accessing wintun from openvpn directly will
> > also work and should bring quite a bit of speed improvement.
>=20
> I was wrong to assume that this just works. Looking at it again, the curr=
ent
> implementation of wintun support does not seem to cover this. Meaning the
> only working approach is to use the interactive service.

Indeed, you are right.  Somewhere on the track we lost the ability
to do wintun "from OpenVPN" if we *have* SYSTEM.

This is the code in tun.c

    if (tt->options.msg_channel)
    {
        ret =3D service_register_ring_buffers(tt);
    }
    else
    {
        msg(M_FATAL, "ERROR:  Wintun requires SYSTEM privileges and therefo=
re "
                     "should be used with interactive service. If you want =
to "
                     "use openvpn from command line, you need to do SYSTEM "
                     "elevation yourself (for example with psexec).");
    }


... so while I'm happy that we got rid of impersonating SYSTEM, the current
code does not even try anymore, just assumes "if there is no message channe=
l,
we have not enough privileges".

OTOH the message is severely misleading now, since it suggests "having
the right privileges will make this work".


This needs fixing - either we *try*, and if we fail, print the message
about insufficient privileges, or we change the message to actually
print something like "Wintun support is only possible if the interactive
service is used.  Do not run from the CLI.  Use the GUI in non-admin mode.".

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--qL6YN2OI1pnKQLYZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfPC84AAoJEB2Cnv7KVigSYHgL+wRxNDdCXFryVrP3i/m3Zq9+
JOcLj2g+ETYmh881N0esjiQgCG6T6ZGcLkD1l7oN2fxYxADhc24mqT3QFn7tHmnK
yMBoXCm93oOBbVqNDzUsetsR2hmpNt1RP2lzGmL7IxcBAHUr/V/ONilD9sZusq8k
o5RQ/9DtzTw4S1YpXb12tnoaVpQjrtwxNdbRWuwTbN97l/OuVJdKtuWcKhY68a1M
xJNBuJbRvPZIS75yEmyGqvQqxYUPb70hDbD072g4kJ3dMNNYSMQdiQS6mc2REHgM
Rt0K9b8pERhf4qj8uAgrhZlqiFGZjB/9Bqajpuyaufq8EBoQfpGnoxEX4VeBkJcB
Ov4Wgq8d/tC0yiPQRPmGhUa9VEIXkebNGNKniTNdQBNfayyRfgIHiVa663F+u9ix
xCbe7eeO4ViZlEjWSjgyDr12HdotTnsALNosTk3EknECvMx7W7pGBbaxf3KbWg1Z
ZTfqBLGAr5a5GfnMv/K95brIiDEfU0iGcntxemSnrQ==
=E+82
-----END PGP SIGNATURE-----

--qL6YN2OI1pnKQLYZ--

