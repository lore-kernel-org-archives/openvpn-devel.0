From: <gianmarco@...2726...>
References: <20230404083226.18751-1-gianmarco@...2726...>
 <20230418152655.128556-1-gianmarco@...2726...>
 <ZD+6xxFlNGZxuvzN@...2685...>
In-Reply-To: <ZD+6xxFlNGZxuvzN@...2685...>
Date: Wed, 19 Apr 2023 12:27:54 +0200
Message-ID: <000201d972a9$9b7c3bb0$d274b310$@mandelbit.com>
MIME-Version: 1.0
Content-Language: it
Subject: Re: [Openvpn-devel] [PATCH v4] Route: add support for user defined
 routing table
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: 'Frank Lichtenheld' <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net


Hi,

> -----Original Message-----
> From: Frank Lichtenheld <frank@...2641...>
> Sent: mercoled=EC 19 aprile 2023 11:56
> To: Gianmarco De Gregori <gianmarco@...2726...>
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] [PATCH v4] Route: add support for user
defined
> routing table
>=20
> On Tue, Apr 18, 2023 at 05:26:55PM +0200, Gianmarco De Gregori wrote:
> > Add the ability for users to specify a custom routing table where
> > routes should be installed in.
> > As of now routes are always installed in the main routing table of the
> > operating system, however, with the new --route-table option it is
> > possibile to specify the ID of the default routing table to be used by
> > --route(-ipv6).
> >
> > The --route(-ipv6) directives have been extended with an additional
> > argument (5th for --route) (4th for --route-ipv6) so that each of them
> > can possibly use an independent routing table.
> >
> > Please note: this feature is currently supported only by Linux/SITNL.
> > Support for other platforms should be added in related backends.
> >
> > Fixes: Trac #1399
> > Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
> > ---
> > Changes from v1:
> > * Fixed parameters (metric and table_id) order in init_route_list() call
in init.c
> : 1535.
> >
> > Changes from v2:
> > * Add route_default_table_id to show_settings() in options.c : 1800.
> >
> > Changes from v3:
> > * Switched table_id data type from uint32_t to int.
> > * Added discard to pulled routing table_id from server in case of pull
mode.
>=20
> One question about that, see below.
>=20
> [...]
> > diff --git a/src/openvpn/options.c b/src/openvpn/options.c index
> > 2680f268..a908566a 100644
> > --- a/src/openvpn/options.c
> > +++ b/src/openvpn/options.c
>=20
> side-note: --route-table missing in usage_message.

Gonna add it soon, thanks for reminding.

>=20
> > @@ -1912,6 +1912,7 @@ show_settings(const struct options *o)
> >      SHOW_STR(route_script);
> >      SHOW_STR(route_default_gateway);
> >      SHOW_INT(route_default_metric);
> > +    SHOW_INT(route_default_table_id);
> >      SHOW_BOOL(route_noexec);
> >      SHOW_INT(route_delay);
> >      SHOW_INT(route_delay_window);
> > @@ -6956,7 +6957,15 @@ add_option(struct options *options,
> >          cnol_check_alloc(options);
> >          add_client_nat_to_option_list(options->client_nat, p[1], p[2],
p[3],
> p[4], msglevel);
> >      }
> > -    else if (streq(p[0], "route") && p[1] && !p[5])
> > +    else if (streq(p[0], "route-table") && p[1] && !p[2])
> > +    {
> > +#ifndef ENABLE_SITNL
> > +        msg(M_WARN, "NOTE: --route-table specified, but not supported
> > +on this platform"); #endif
> > +        VERIFY_PERMISSION(OPT_P_ROUTE);
> > +        options->route_default_table_id =3D positive_atoi(p[1]);
> > +    }
> > +    else if (streq(p[0], "route") && p[1] && !p[6])
> >      {
> >          VERIFY_PERMISSION(OPT_P_ROUTE);
> >          rol_check_alloc(options);
> > @@ -6977,10 +6986,31 @@ add_option(struct options *options,
> >                  msg(msglevel, "route parameter gateway '%s' must be a
valid
> address", p[3]);
> >                  goto err;
> >              }
> > +            /* p[4] is metric, if specified */
> > +
> > +            /* discard pulled routing table_id from server
> > +             * since this must be an entirely local choice */
>=20
>=20
> Don't you need that check for --route-table as well?

There is no need since if the table_id is specified via --route-table that
will be used regardless, otherwise the main table with id 0 will be used.

>=20
> > +            if (p[5])
> > +            {
> > +                p[5] =3D NULL;
> > +            }
> > +        }
> > +        /* at the moment the routing table id is supported only by
> > +Linux/SITNL */ #ifndef ENABLE_SITNL
> > +        if (p[5])
> > +        {
> > +            static bool route_table_warned =3D false;
> > +
> > +            if (!route_table_warned)
> > +            {
> > +                msg(M_WARN, "NOTE: table specified for --route, but not
> supported on this platform");
> > +                route_table_warned =3D true;
> > +            }
> >          }
> > -        add_route_to_option_list(options->routes, p[1], p[2], p[3],
p[4]);
> > +#endif
> > +        add_route_to_option_list(options->routes, p[1], p[2], p[3],
> > +p[4], p[5]);
> >      }
> > -    else if (streq(p[0], "route-ipv6") && p[1] && !p[4])
> > +    else if (streq(p[0], "route-ipv6") && p[1] && !p[5])
> >      {
> >          VERIFY_PERMISSION(OPT_P_ROUTE);
> >          rol6_check_alloc(options);
>=20

Regards,

Gianmarco De Gregori


