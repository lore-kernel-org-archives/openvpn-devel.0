Date: Fri, 9 Dec 2016 09:13:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161209081319.GS78624@...1296...>
References: <1480545687-19365-1-git-send-email-davids@...515...>
	<1481251848-28460-1-git-send-email-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ht9V8wKec6a3w1Ef"
Content-Disposition: inline
In-Reply-To: <1481251848-28460-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] push: Provide a warning if
 --ifconfig-push have argument mismatch with --topology
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--ht9V8wKec6a3w1Ef
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 09, 2016 at 03:50:48AM +0100, David Sommerseth wrote:
> This adds a warning to the log file if --topology is configured to use
> subnet or net30 and the 'subnet mask' argument of an --ifconfig-push opti=
on
> is not an subnet mask.
>=20
> v2 - Make use of ifconfig_sanity_check() in tun.c instead of doing the ex=
act
>      same check and warning in prepare_push_reply().  Also improve docume=
ntation
>      of ifconfig_sanity_check() while at it.

Not being the one to complain about your code all the time... but...
since trac #755 is about "topology subnet"...

static void
ifconfig_sanity_check (bool tun, in_addr_t addr, int topology)
{
  struct gc_arena gc =3D gc_new ();
  const bool looks_like_netmask =3D ((addr & 0xFF000000) =3D=3D 0xFF000000);
  if (tun)
    {
      if (looks_like_netmask && (topology =3D=3D TOP_NET30 || topology =3D=
=3D TOP_P2P))
        msg (M_WARN, "WARNING: Since you are using --dev tun with a point-t=
o-poi
nt topology, the second argument to --ifconfig must be an IP address.  You =
are u
sing something (%s) that looks more like a netmask. %s",
             print_in_addr_t (addr, 0, &gc),
             ifconfig_warn_how_to_silence);
    }
  else /* tap */

... ifconfig_sanity_check() does *nothing* for TOP_SUBNET (and the code
disagrees with your commit message for "net30").

So the v3 version of that patch would need to add the (missing today,
but actually important diagnostic aid - and the point of #755) clause

    if (!looks_like_netmask && topology =3D=3D TOP_SUBNET)
    {
	msg (M_WARN, "topology subnet needs a netmask as second argument bla bla");
    }


Also we might to re-think the warning message printed - if called from
an ifconfig-push context, the text "the second argument to --ifconfig must
be an IP address" is less than clear ("my --ifconfig settings are just=20
fine, what is openvpn warning about?").


Plus, it needs to be actually tested on a non-intel architecture - the
code has been like that forever, but I would not trust it to be endian-
safe (though our use of "in_addr_t" is not actually consistent with
what *should* be in one - parts of the code treat it as "network byte
order", other parts as "host byte order", and the point of using
"in_addr_t" as well defined *type* and not "a bag of 32bits, unsigned"
should have been "as defined by the socket API", which wants network
byte order).


But since this is an enhancement and not a bug, it should not be rushed -
it does not have to be in 2.4.0.  Let's do it properly, test it, then
see if we want to have it in 2.4.1  (and while at it, we should teach
check_addr_clash() that networks do have a netmask for a reason, and
"local/remote and --ifconfig are in the same /24" could be perfectly fine=20
if the pushed netmask is *not* a /24).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ht9V8wKec6a3w1Ef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYSmeeAAoJEB2Cnv7KVigSzg8L/3KBH6fh6auftM7rar6zqM8N
o2D5d7/okwc0ddi7uzHIVD3hdoOrtKl104Qw6IFsYlGH9uwojUXkaeNksdRjBK/s
Ea44w1Ne70mMgeW/FGdCX6KPN3SdLo8fLvxzXvBeUKjeX7rthJhADx1u5VvHsra5
ytcoufOpXNeRm5ePvOQuk/NqA/VOJD47uyhDnlwutIqod/B2Of39qdHNTj5zC+I8
eTMk1qlKWhlivHEq3bicvPwIfcEKhk0lQ8lqADCgCUjIdHmsueL8MrK4+vHINXXP
CgUVhCL+k+09mJHmw+B0RCtbUiGFiOgq5q+4YW96gUQSs0UryKc3rXn7jACuLGxD
yXACh5Pbm7HB/uU1KbA1+p4XyWdv0V8xhWJAMYvhlXQJGt8qJRPM8lquF3824bKi
D4XVj7e2xzZLg1+hQszWvSc1IsJvKQf5IDV6HIKt9d4CotJDQtu3D08g0Qfr49ts
Fe0hsCyMrLOGZH7a0Hn2IN+OApApBtkV0OK2ySnSLg==
=94GI
-----END PGP SIGNATURE-----

--ht9V8wKec6a3w1Ef--

