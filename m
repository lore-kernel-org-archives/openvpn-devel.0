MIME-Version: 1.0
In-Reply-To: <20180605185352.GR57262@...1296...>
References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...>
 <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
 <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
 <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 5 Jun 2018 15:38:44 -0400
Message-ID: <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
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

On Tue, Jun 5, 2018 at 2:53 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Tue, Jun 05, 2018 at 01:30:35PM -0400, Selva Nair wrote:
>> How to work around that depends on what the tap driver expects in the
>> v4 address. Ideally, we should patch the driver to work without a V4
>> address...
>
> Samuli's build/test rig seems to be close to finished, so now is the
> time to break the tap driver for good ;-)
>
> I'll look into that.  Had my fingers in that code quite a lot recently
> anyway...
>

Sounds good.

FWIW, I did a quick test --- looking into tap-windows sources it seems
the address is used only for ARP so passing some random address to the
ioctl looks ok (?).

Tried this by commenting out the check for did_ifconfig_setup on when
windows tun mode is in use. In this case the local ip and netmask
stays at 0, and gets passed to tap-windows. This allows one to run
the exe on Windows (see the diff below to see what I did). Without
that it just errors out saying --dev tun requires ifconfig, as
expected.

There is a less than ideal log message which could be improved:

"Set TAP-Windows TUN subnet mode network/local/netmask =
0.0.0.0/0.0.0.0/0.0.0.0 [SUCCEEDED]"

However, even with !ipv4, redirect-gateway ipv6 appears to error out
-- it fails with

"TEST ROUTES: 0/2 succeeded len=1 ret=0 a=0 u/d=up
Route: Waiting for TUN/TAP interface to come up..."

A couple of other random things I noticed

If a v4 address is not being set:

- some management messages could be bypassed as Gert had guessed --
eg., ASSIGN_IP which includes the v4 and v6 address.
The GUI takes the address from the final CONNECTED,SUCCESS message but
other clients may parse this message.

- setting of mtu may get skipped in some systems at least

Here is the diff of what I did for the Windows build run:

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 2e33880..75336a9 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5824,9 +5824,9 @@ open_tun(const char *dev, const char *dev_type,
const char *dev_node, struct tun

     if (tt->type == DEV_TYPE_TUN)
     {
-        if (!tt->did_ifconfig_setup)
+        if (!tt->did_ifconfig_setup && !tt->did_ifconfig_ipv6_setup)
         {
-            msg(M_FATAL, "ERROR: --dev tun also requires --ifconfig");
+            msg(M_WARN|M_INFO, "WARNING: neither ifconfig nor
ifconfig-ipv6 specified");
         }

         if (tt->topology == TOP_SUBNET)

Selva

