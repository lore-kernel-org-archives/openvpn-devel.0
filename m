Date: Thu, 13 Apr 2023 16:18:31 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZDgPN9rWg81ch8Nd@...2685...>
References: <20230403131750.4730-1-gianmarco@...2726...>
 <20230404083226.18751-1-gianmarco@...2726...>
 <ZDgN0EzH2JSbWknT@...1296...>
MIME-Version: 1.0
In-Reply-To: <ZDgN0EzH2JSbWknT@...1296...>
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
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: Gianmarco De Gregori <gianmarco@...2726...>, openvpn-devel@lists.sourceforge.net

On Thu, Apr 13, 2023 at 04:12:32PM +0200, Gert Doering wrote:
> Hi,
> 
> On Tue, Apr 04, 2023 at 10:32:26AM +0200, Gianmarco De Gregori wrote:
> > diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> > index 3798bc65..00419dce 100644
> > --- a/src/openvpn/route.c
> > +++ b/src/openvpn/route.c
> > @@ -325,7 +325,6 @@ init_route(struct route_ipv4 *r,
> >  
> >      CLEAR(*r);
> >      r->option = ro;
> > -
> >      /* network */
> >  
> >      if (!is_route_parm_defined(ro->network))
> > @@ -437,6 +436,27 @@ init_route(struct route_ipv4 *r,
> >  
> >      r->flags |= RT_DEFINED;
> >  
> > +    /* routing table id */
> > +
> > +    r->table_id = 0;
> > +    if (ro->table_id)
> > +    {
> > +        r->table_id = atoi(ro->table_id);
> > +        if (r->table_id < 0)
> > +        {
> > +            msg(M_WARN, PACKAGE_NAME "ROUTE: routing table id for network %s (%s) must be >= 0",
> 
> Frank's comments alerted me to this, and this certainly is not the way
> to approach it.  Syntax checking of the routing table ID must happen during
> option parsing (options.c), not in init_route() - so, this function
> should be able to rely on ro->table_id being an *int*, and properly
> sanitized - "if set, the content is valid".
> 
> Same for IPv6, of course.

To be fair, he implemented it in the same way all the other parameters are implemented. That is why
I did not complain about that (e.g. compare ro->metric, which is treated exactly the same way).
However, I agree with your general sentiment.

Regards,
-- 
  Frank Lichtenheld

