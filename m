Date: Mon, 19 Sep 2022 08:36:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YygN5ZRAAMA1xdrj@...1296...>
References: <20220917231030.22565-1-a@...2181...>
 <Yyb07u4pG0Ii9vQf@...1296...>
 <dca91e77-175c-9540-7993-112ca7a4661b@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="SdfyEodzUupEcGYm"
Content-Disposition: inline
In-Reply-To: <dca91e77-175c-9540-7993-112ca7a4661b@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] implement --session-timeout
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, Dmitry Zelenkovsky <Dmitry.Zelenkovskiy@...1719...>, openvpn-devel@lists.sourceforge.net

--SdfyEodzUupEcGYm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Sep 19, 2022 at 12:29:20AM +0200, Antonio Quartulli wrote:
> On 18/09/2022 12:37, Gert Doering wrote:
> > On Sun, Sep 18, 2022 at 01:10:30AM +0200, Antonio Quartulli wrote:
> >> From: Dmitry Zelenkovsky <Dmitry.Zelenkovskiy@...1719...>
> >>
> >> Disconnect clients after session-timeout expires.
> >> session-timeout can be defined in ccd files in order to limit
> >> per-user connection time.
> >=20
> > I find this implementation needlessly complicated.
> >=20
> >> +/*
> >> + * Should we exit due to session timeout?
> >> + */
> >> +static void
> >> +check_session_timeout(struct context *c)
> >> +{
> >> +    if (c->options.session_timeout
> >> +        && event_timeout_trigger(&c->c2.session_interval, &c->c2.time=
val,
> >> +                                 ETT_DEFAULT))
> >> +    {
> >> +        msg(M_INFO, "Session timeout, exiting");
> >> +        register_signal(c, SIGTERM, "session-timeout");
> >> +    }
> >> +}
> >=20
> > Why are we working with event triggers here, if all we *want* to do is
> > a single-shot
> >=20
> >   if ( now > $somectx->session_must_end_at_this_time )
> >   {
> >        /* kick out this user now */
> >        ...
> >   }
> >=20
>=20
> we don't get here at all, if we have no event object that is timing out.

process_coarse_timers() is run once per second, and does not need=20
additional timers to be called.

This new check is added to process_coarse_timers().

Why do we need an extra event object, again?


I can see the need for event objects for recurring things, but for=20
a single-shot "terminate client instance at this time, done", I'm not
convinced.


> So, although one shot, we still need to setup a timer object that will=20
> trigger the machinery upon timeout.

> >> +    else if (streq(p[0], "session-timeout") && p[1] && !p[2])
> >> +    {
> >> +        VERIFY_PERMISSION(OPT_P_TIMER);
> >=20
> > OPT_P_INSTANCE?
>=20
> makes sense to add OPT_P_INSTANCE, although I wonder why other=20
> activity/timeout knobs are not marks as such, i.e. --inactivity)

Not "add" OPT_P_INSTANCE, but "just" OPT_P_INSTANCE.

This is not something you want in the client config file.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--SdfyEodzUupEcGYm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjKA3lAAoJEB2Cnv7KVigS2OsL/jQyDkNzs9ugpdP6sCXnIQxt
fn5mEoJjbNKmGvS36SnnH4eG4eeh7zapue088l4JDGw7OGq7y5GfQVOlA8mpTJcb
d03quIgxaF3zJn7kaPLMMWXOFhqVNzIPdt/4JEHfRIn1EdiivoL8FND6K44B8nps
536rIzS8Wg3r2jAckOZrhRa8uwVVeusq1WfHuwQvSHfwUGu7/tIJ/Pjvx4+MttpS
qI72h1c7+tBBBteq2omWLtipVB65GseVXd56evwZT63+PPnt2aV6d95QqjRSOBgC
QZPxK0zhHlLq7vb0HUS+mW90vGz8/7f2q1VqWrUzyFCx029KK4mauMuJ9rbclAaG
lunD5/JUCtytJbyapz8YsbIQsw3KqdfxKkYAtNgvnyh5+RRwty0x+ZlWW6OEvkD1
YIoWWOwSwRrYADTvCP+7gHP/KeUpw6T0B7k0H/Gm6j6JeIhvbLj6tS+INKpu36ZI
Pv0GQlkEGzpK6UCWT2mlx0GxEe+O75D8FWSzLXB5kw==
=GNSm
-----END PGP SIGNATURE-----

--SdfyEodzUupEcGYm--

