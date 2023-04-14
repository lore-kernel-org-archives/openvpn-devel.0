From: <gianmarco@...2726...>
References: <20230403131750.4730-1-gianmarco@...2726...>
 <20230404083226.18751-1-gianmarco@...2726...>
 <ZDgN0EzH2JSbWknT@...1296...>
 <ZDgPN9rWg81ch8Nd@...2685...>
In-Reply-To: <ZDgPN9rWg81ch8Nd@...2685...>
Date: Fri, 14 Apr 2023 10:45:50 +0200
Message-ID: <003901d96ead$849fc100$8ddf4300$@mandelbit.com>
MIME-Version: 1.0
Content-Language: it
Subject: Re: [Openvpn-devel] [PATCH v3] Route: add support for user defined
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
To: 'Frank Lichtenheld' <frank@...2641...>, 'Gert Doering' <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,


-----Original Message-----
From: Frank Lichtenheld <frank@...2641...>=20
Sent: gioved=EC 13 aprile 2023 16:19
To: Gert Doering <gert@...1296...>
Cc: Gianmarco De Gregori <gianmarco@...2726...>;
openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] [PATCH v3] Route: add support for user defined
routing table

On Thu, Apr 13, 2023 at 04:12:32PM +0200, Gert Doering wrote:
> Hi,
>=20
> On Tue, Apr 04, 2023 at 10:32:26AM +0200, Gianmarco De Gregori wrote:
> > diff --git a/src/openvpn/route.c b/src/openvpn/route.c index=20
> > 3798bc65..00419dce 100644
> > --- a/src/openvpn/route.c
> > +++ b/src/openvpn/route.c
> > @@ -325,7 +325,6 @@ init_route(struct route_ipv4 *r,
> >=20=20
> >      CLEAR(*r);
> >      r->option =3D ro;
> > -
> >      /* network */
> >=20=20
> >      if (!is_route_parm_defined(ro->network))
> > @@ -437,6 +436,27 @@ init_route(struct route_ipv4 *r,
> >=20=20
> >      r->flags |=3D RT_DEFINED;
> >=20=20
> > +    /* routing table id */
> > +
> > +    r->table_id =3D 0;
> > +    if (ro->table_id)
> > +    {
> > +        r->table_id =3D atoi(ro->table_id);
> > +        if (r->table_id < 0)
> > +        {
> > +            msg(M_WARN, PACKAGE_NAME "ROUTE: routing table id for=20
> > + network %s (%s) must be >=3D 0",
>=20
> Frank's comments alerted me to this, and this certainly is not the way=20
> to approach it.  Syntax checking of the routing table ID must happen=20
> during option parsing (options.c), not in init_route() - so, this=20
> function should be able to rely on ro->table_id being an *int*, and=20
> properly sanitized - "if set, the content is valid".
>=20
> Same for IPv6, of course.

To be fair, he implemented it in the same way all the other parameters are
implemented. That is why I did not complain about that (e.g. compare
ro->metric, which is treated exactly the same way).
However, I agree with your general sentiment.

I completely agree with switching from uint32_t to *int* as I notice that
those muliple checks doesn't make any sense.
As Frank said, I chose this approach of following how
options->route_default_metric and ro->metric are implemented to be
consistent with the overall data flow, anyway, in a follow-up patch I could
perform a clean-up of all those parameters to be sanitized and managed
through options.c .=20

Regards,

Gianmarco De Gregori


