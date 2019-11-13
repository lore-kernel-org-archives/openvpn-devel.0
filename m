MIME-Version: 1.0
References: <61c1b837-3f81-6783-5934-8128bb81881b@...2181...>
 <20191113100702.6863-3-tom.ty89@...277...>
 <CAGnHSEkbzpdUiZ9KPL-SP03WNGjhhAAe2qO0GY-0oOLvwt-Kkw@...278...>
In-Reply-To: <CAGnHSEkbzpdUiZ9KPL-SP03WNGjhhAAe2qO0GY-0oOLvwt-Kkw@...278...>
From: Tom Yan <tom.ty89@...277...>
Date: Wed, 13 Nov 2019 22:33:32 +0800
Message-ID: <CAGnHSEnj6OXEBM-21Uf7O0CpCf9Cz-xiGWH4-4RyrbwXGcS=4w@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/4] Avoid reserving one more address
 at pool end
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

So a recent question on the openvpn-users caused me to have found
that, this "reserve-one-more-address" is seemingly related to Windows
/ --ip-win32. Commit 251cc8f made a "correction" to the
manual/documentation which sort of implied that the address is
reserved as the default address chosen by `--ip-win32 dynamic` as DHCP
server (when `dev` is a tun).

But the thing is, the choice can be made by user with an extra
parameter (`offset`) that does not affect the --ifconfig-pool set by
--server. So as far as I can see here, it *implies* that the server
directive shouldn't be used with `--ip-win32 dynamic offset`. (This is
pretty nasty to me, although it might practically be convenient to the
"default lovers").

I am not sure what to do with this. Personally I prefer ditching the
reservation and simply note that `--ip-win32 dynamic` shouldn't be
used with `--server`, for simplicity and consistency. (In addition to
the consistency of whether --server can be used with `--ip-win32
dynamic`, x.x.x.254 may actually be used in a tap set-up, rendering
commit 251cc8f "wrong".

On Wed, 13 Nov 2019 at 19:41, Tom Yan <tom.ty89@...277...> wrote:
>
> If it isn't a typo, I wonder if it is the equivalence of
> `pool_end_reserve`. As with the subnet topology, each client takes up
> 1 address in contrast to 4 with net30.
>
> So perhaps the question is, what's the purpose of pool_end_reserve?
>
> On Wed, 13 Nov 2019 at 18:07, Tom Yan <tom.ty89@...277...> wrote:
> >
> > It appears to be a copy-and-paste kind of typo (pool start is network address + 2).
> > ---
> >  src/openvpn/helper.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
> > index 5b2ca0cc..6e2f0891 100644
> > --- a/src/openvpn/helper.c
> > +++ b/src/openvpn/helper.c
> > @@ -349,7 +349,7 @@ helper_client_server(struct options *o)
> >              {
> >                  o->ifconfig_pool_defined = true;
> >                  o->ifconfig_pool_start = o->server_network + ptp + 1;
> > -                o->ifconfig_pool_end = (o->server_network | ~o->server_netmask) - ptp * 2;
> > +                o->ifconfig_pool_end = (o->server_network | ~o->server_netmask) - ptp;
> >                  ifconfig_pool_verify_range(M_USAGE, o->ifconfig_pool_start, o->ifconfig_pool_end);
> >              }
> >              o->ifconfig_pool_netmask = o->server_netmask;
> > --
> > 2.24.0
> >

