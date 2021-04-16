From: "Vladislav Grishenko" <themiron@...2010...>
References: <20210415230545.22317-1-themiron@...2010...>
 <20210416120708.1532-1-themiron@...2010...>
 <022e18d6-67ae-8975-9d41-49d19c41a0be@...2181...>
In-Reply-To: <022e18d6-67ae-8975-9d41-49d19c41a0be@...2181...>
Date: Fri, 16 Apr 2021 19:43:54 +0500
Message-ID: <01ed01d732ce$ed39d100$c7ad7300$@yandex-team.ru>
MIME-Version: 1.0
Content-Language: ru
Subject: Re: [Openvpn-devel] [PATCH v3 1/2] Fix IPv4 default gateway with
 multiple route tables
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: 'Antonio Quartulli' <a@...2181...>, openvpn-devel@lists.sourceforge.net

Hi,

> However, to prevent the next casual reader from asking the same question,
> wouldn't it make sense to change this comparison with:
>=20
> if (res->table !=3D RT_TABLE_UNSPEC && res->table !=3D table)

I don=E2=80=99t think it's necessary for following reasons:
1. Readability. "if (res->table)" reads as "if filter table is set ". Chang=
ing it to "if (res->table !=3D RT_TABLE_UNSPEC)" gives the same reading imh=
o.
2. RT_TABLE_UNSPEC was and will be always zero, because zillion of software=
 incl. iproute2 depends on zeroed structs with 0 =3D=3D UNSPEC
3. Comparing with RT_TABLE_UNSPEC here will require additional code to expl=
icitely init res.table with RT_TABLE_UNSPEC, which in fact is will be noop =
after CLEAR(res) and have little sense, since there's no chance to have RT_=
TABLE_UNSPEC !=3D 0.
Anyway, if you still thinks it's required, I can do change.

> Another question: why restricting the research to the MAIN table only for=
 IPv4
> and only when searching a default route?

For real dst, incl ::/128 we do the right thing - perform "ip route get" th=
at will get real gateway for specified dst no matter what table or anything=
 else is.
And we performs "ip route show" dump only to get gateway for "0.0.0.0" dest=
ination by a reason.
Getting default gateway for "0.0.0.0/0" destination is not logically possib=
le at all, for example what is default gateway for this case:
	0.0.0.0/1 via a.a.a.a
	128.0.0.0/1 via b.b.b.b
Therefore for 0.0.0.0/0 case heuristic is used, if there's  a default route=
, if it's in main table and so on, that=E2=80=99s why only dumping needs it.
Any other - don't.
=20
> Otherwise we are fixing this problem only for the ipv4/default search, bu=
t the
> function remains "buggy" for the other cases.

Buggy here is searching default gateway for 0.0.0.0/0 itself. Other cases a=
re right from the scratch :)

--
Best Regards, Vladislav Grishenko

> -----Original Message-----
> From: Antonio Quartulli <a@...2181...>
> Sent: Friday, April 16, 2021 7:01 PM
> To: Vladislav Grishenko <themiron@...2010...>; openvpn-
> devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] [PATCH v3 1/2] Fix IPv4 default gateway with
> multiple route tables
>=20
> Hi,
>=20
> On 16/04/2021 14:07, Vladislav Grishenko wrote:
> > Current default gateway selection for zero destination address just
> > dumps and parses all the routing tables. If any of non-main table with
> > default route comes first, wrong default gateway can be picked.
> > Since adding/removing routes currently handles only main table, let's
> > stick to RT_TABLE_MAIN while selecting default route too.
> >
> > v2: keep gateway address unchanged on lookup error
> > v3: reduce ammout of gateway address copying
> >
> > Reported-by: Donald Sharp <donaldsharp72@...277...>
> > Signed-off-by: Vladislav Grishenko <themiron@...2010...>
> > ---
> >  src/openvpn/networking_sitnl.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> >
> > diff --git a/src/openvpn/networking_sitnl.c
> > b/src/openvpn/networking_sitnl.c index 2bc70a50..ea1621ed 100644
> > --- a/src/openvpn/networking_sitnl.c
> > +++ b/src/openvpn/networking_sitnl.c
> > @@ -426,6 +426,7 @@ typedef struct {
> >      inet_address_t gw;
> >      char iface[IFNAMSIZ];
> >      bool default_only;
> > +    unsigned int table;
> >  } route_res_t;
> >
> >  static int
> > @@ -435,7 +436,8 @@ sitnl_route_save(struct nlmsghdr *n, void *arg)
> >      struct rtmsg *r =3D NLMSG_DATA(n);
> >      struct rtattr *rta =3D RTM_RTA(r);
> >      int len =3D n->nlmsg_len - NLMSG_LENGTH(sizeof(*r));
> > -    unsigned int ifindex =3D 0;
> > +    unsigned int table, ifindex =3D 0;
> > +    void *gw =3D NULL;
> >
> >      /* filter-out non-zero dst prefixes */
> >      if (res->default_only && r->rtm_dst_len !=3D 0) @@ -443,6 +445,9 @@
> > sitnl_route_save(struct nlmsghdr *n, void *arg)
> >          return 1;
> >      }
> >
> > +    /* route table, ignored with RTA_TABLE */
> > +    table =3D r->rtm_table;
> > +
> >      while (RTA_OK(rta, len))
> >      {
> >          switch (rta->rta_type)
> > @@ -458,13 +463,24 @@ sitnl_route_save(struct nlmsghdr *n, void *arg)
> >
> >              /* GW for the route */
> >              case RTA_GATEWAY:
> > -                memcpy(&res->gw, RTA_DATA(rta), res->addr_size);
> > +                gw =3D RTA_DATA(rta);
> > +                break;
> > +
> > +            /* route table */
> > +            case RTA_TABLE:
> > +                table =3D *(unsigned int *)RTA_DATA(rta);
> >                  break;
> >          }
> >
> >          rta =3D RTA_NEXT(rta, len);
> >      }
> >
> > +    /* filter out any route not coming from the selected table */
> > +    if (res->table && res->table !=3D table)
>=20
> Today I was wondering if 0 could be a meaningful table ID, since this cod=
e uses 0
> as "no table was selected for filtering" (thus creating a false negative).
>=20
> After checking rtnetlink.h, I could see that 0 is indeed the UNSPEC value
> (RT_TABLE_UNSPEC=3D0), therefore your patch is correct.
>=20
> However, to prevent the next casual reader from asking the same question,
> wouldn't it make sense to change this comparison with:
>=20
> if (res->table !=3D RT_TABLE_UNSPEC && res->table !=3D table)
>=20
>=20
> > +    {
> > +        return 1;
> > +    }
> > +
> >      if (!if_indextoname(ifindex, res->iface))
> >      {
> >          msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifname for index
> > %d", @@ -472,6 +488,11 @@ sitnl_route_save(struct nlmsghdr *n, void *ar=
g)
> >          return -1;
> >      }
> >
> > +    if (gw)
> > +    {
> > +        memcpy(&res->gw, gw, res->addr_size);
> > +    }
> > +
> >      return 0;
> >  }
> >
> > @@ -507,6 +528,7 @@ sitnl_route_best_gw(sa_family_t af_family, const
> inet_address_t *dst,
> >              {
> >                  req.n.nlmsg_flags |=3D NLM_F_DUMP;
> >                  res.default_only =3D true;
> > +                res.table =3D RT_TABLE_MAIN;
>=20
> Another question: why restricting the research to the MAIN table only for=
 IPv4
> and only when searching a default route?
>=20
> Like you said in the commit message: OpenVPN only operates on the MAIN
> routing table for the time being, therefore, shouldn't we just set "res.t=
able =3D
> RT_TABLE_MAIN" by default *all the time* for now?
>=20
> Otherwise we are fixing this problem only for the ipv4/default search, bu=
t the
> function remains "buggy" for the other cases.
>=20
>=20
> >              }
> >              else
> >              {
> >
>=20
>=20
> Regards,
>=20
> --
> Antonio Quartulli


