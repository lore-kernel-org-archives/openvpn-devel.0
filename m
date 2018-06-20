MIME-Version: 1.0
In-Reply-To: <20180620155301.GY57262@...1296...>
References: <20180608052017.6696-1-a@...2181...>
 <20180613141213.5962-1-a@...2181...>
 <20180620155301.GY57262@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 20 Jun 2018 15:31:39 -0400
Message-ID: <CAKuzo_hAOzTi0dt=yNd8rMdjoeba87mG3_RZTaeP7FL3KQ0SrA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/8] windows: properly configure TAP
 driver when no IPv4 is configured
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
To: Gert Doering <gert@...1296...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Wed, Jun 20, 2018 at 11:53 AM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Wed, Jun 13, 2018 at 10:12:13PM +0800, Antonio Quartulli wrote:
>> From: Antonio Quartulli <antonio@...515...>
>>
>> This patch ensures that the TAP driver on a windows host is still
>> configured, even though no IPv4 has been provided.
>>
>> In this case the TAP driver ioctl will be invoked with a fake
>> 0.0.0.0/0.0.0.0 IPv4 which will simply start the interface and
>> get it to a working state.
>>
>> Trac: #208
>> Signed-off-by: Antonio Quartulli <antonio@...515...>
>
> Well...
>
>> @@ -2642,7 +2642,11 @@ test_routes(const struct route_list *rl, const struct tuntap *tt)
>>          ret = true;
>>          adapter_up = true;
>>
>> -        if (rl)
>> +        /* we do this test only if we have IPv4 routes to install, and if
>> +         * the tun/tap interface has seen IPv4 ifconfig - because if we
>> +         * have no IPv4, the check will always fail, failing tun init
>> +         */
>> +        if (rl && c->c1.tuntap->did_ifconfig_setup)
>
> This code is a bit optimstic :-) - there is no "c" here...

When did this change?  In a previous version this was done as

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 7d9a338..51e43c2 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -292,7 +292,9 @@ check_add_routes_action(struct context *c, const
bool errors)
 void
 check_add_routes_dowork(struct context *c)
 {
-    if (test_routes(c->c1.route_list, c->c1.tuntap))
+    /* skip route check if no IPv4 was configured */
+    if (!c->c1.tuntap->did_ifconfig_setup
+        || test_routes(c->c1.route_list, c->c1.tuntap))
     {
         check_add_routes_action(c, false);
     }

That said, moving this to route.c but corrected as in Gert's
attachment looks better.

Selva

