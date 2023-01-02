Date: Mon, 2 Jan 2023 23:51:43 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y7Nf/w7bRBGPd9jV@...1296...>
References: <OpenVPN/openvpn-gui/issues/9@...1714...>
 <OpenVPN/openvpn-gui/issues/9/403117394@...1714...>
 <CAKuzo_jDCHm=VLc2wuKYJaf48Duy_4dHnbvHx4StVV6PjDausw@...278...>
 <CAEsd45Q87G=UTjt-PE29a41MFQU90_NJxmmux9=ZS=S7j=9E9A@...278...>
 <CAKuzo_iNcK+B2Tg0a7LS+251JSnfHXd++Gy243+gtWOZx7VC=g@...278...>
 <Y7BmEYJj+935Ow5v@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="NN8KrVRHV3+yp70L"
Content-Disposition: inline
In-Reply-To: <Y7BmEYJj+935Ow5v@...1296...>
Subject: Re: [Openvpn-devel] [OpenVPN/openvpn-gui] UI showing green
 connected status despite not beeing able to create a route (#9)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, "Jonathan K. Bullard" <jkbullard@...277...>, Gert Doering <gert@...1296...>

--NN8KrVRHV3+yp70L
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Dec 31, 2022 at 05:40:49PM +0100, Gert Doering wrote:
> On Sat, Dec 17, 2022 at 07:09:34PM -0500, Selva Nair wrote:
> > tldr: Can we get CONNECTED,ERROR instead of CONNECTED,SUCCESS on route
> > errors?
>=20
> I think this makes sense.  Not sure how complicated it is, and if we
> can make this before 2.6.0 ("some time in January").

So if I am reading this right, "CONNECTED,<something>" is produced
by management_set_state() -> log_entry_print(), with the "something"
being transported via "detail" -> "e->string".

"CONNECTED" is only produced by init.c::initialization_sequence_completed(),
and there already is a case for "CONNECTED,ERROR" though I don't understand
it...

        if (flags & ISC_ERRORS)
        {
            detail =3D "ERROR";
        }

(which will also log "Initialization Sequence Completed *With Errors*",
but the rest of that branch might be a bit misleading, as it will
tell systemd "STATUS=3DFailed")


initialization_sequence_completed() is called from init.c::do_up()
(for client/p2p), forward.c, and mtcp.c/mudp.c (Server).

The "--route-delay" case goes via forward.c::check_add_routes_action(),
which *can* signal ERROR.  init.c::do_up() does not.

Routes are (if no --route-delay) set up by do_init_tun(), which calls
do_route().  So adding an "&flags" parameter to that call chain which sets
ISC_ERROR if a route addition fails might be a viable approach.

... and then I found ROUTE_BEFORE_TUN, ROUTE_AFTER_TUN... which adds
yet another call chain, which is totally irrelevant but would need that
extra argument as well...

And, --route-delay, I need to understand better what the code is doing
there...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--NN8KrVRHV3+yp70L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjs1//AAoJEB2Cnv7KVigSm0MMAJHJ2uiaYvJPfk2hPE48NkMg
HQXUXuJyGgWoS833H85cz7iH9kW0rfhB5g1JNBp8OXWrgReJbJ1iTW+yydQA9dAb
dl7ozjNjexV1jh2pnDe1TINdwHbek04+hhbTSyWgnd66oM0uLREdz8R0EkLGbte1
bE/WUC1PkzZQsUZLjQ/fqRzsNA7BAQw7UgJer3gAvkiP34Gkmla2fIps9bFklN+z
wS/8i34wppqB+pSDovIzEeqY4WOHH3jWQ3r0Mw/MwfWDzMkCDuYiVVV6uRLa0Err
Juzjh+yU8d0OJW2lZnyOFnalm9uVm2jluejPLal3HtoO1UnGK4cAfS3vIRUKOmkE
UOQ0wJZPx4RMo2S6nd51h/nzxCXd+RrkGsJUTVi/ZCd0+bR9EMQxTeYDZfSCyDAX
BdgBQcEC2hNgdBGRpDGpgfUToRmi50X6qbVoQoERavY4rMEGdKWGf0uA8AxVlnGm
K66j6OBAT/BlxJ4ssWk7QH4dpY6H/ksuUz7eVPx6ZQ==
=I0qk
-----END PGP SIGNATURE-----

--NN8KrVRHV3+yp70L--

