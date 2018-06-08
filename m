MIME-Version: 1.0
References: <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
 <20180605195935.GU57262@...1296...>
 <CAKuzo_jP1F13rw2pdRx9zF0n-7+N29u3d4FE53tL9SrwxMwk9w@...278...>
 <9a878b99-12ef-47b4-fc85-a16ecc196363@...2181...>
 <CAKuzo_hU64ML71iL7Xdt5_k08QLXwDytXd1W2TVze=7SUhLLSQ@...278...>
 <CAKuzo_gp9jcVocxgf79TNQpgP-ScioC1pM_3oTq9+SHHAhEonw@...278...>
 <665fcdae-dad7-b6c8-14ee-512ff7992963@...2181...>
 <CAKuzo_jLhL=pLrkRoqWXHPRLzBGBiUCgq20Wzxd+DiidoAmOJA@...278...>
 <20180607165705.GP57262@...1296...>
 <CAKuzo_j23Y5Q367cug-usSheh5h6WXUqswOqNBVS3073rMesVw@...278...>
 <f0a67a1c-8103-5db9-44b2-7f4c82dc70a8@...2181...>
In-Reply-To: <f0a67a1c-8103-5db9-44b2-7f4c82dc70a8@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 7 Jun 2018 21:00:31 -0400
Message-ID: <CAKuzo_hSmy3qOLOVUtDrKgewPW4CKOu6Sd73FJkweBXMWBwgmw@...278...>
Content-Type: multipart/alternative; boundary="000000000000eb0f60056e16ed15"
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
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000eb0f60056e16ed15
Content-Type: text/plain; charset="UTF-8"

Hi,
On Thu, Jun 7, 2018 at 1:29 PM Antonio Quartulli <a@...2181...> wrote:

> On 08/06/18 01:05, Selva Nair wrote:
> > Hi,
> >
> > On Thu, Jun 7, 2018 at 12:57 PM, Gert Doering <gert@...1296...>
> wrote:
> >> Hi,
> >>
> >> On Thu, Jun 07, 2018 at 12:14:51PM -0400, Selva Nair wrote:
> >>> Note: All that said, I can't seem to connect to the server via ipv6
> >>> when there is no v4 address. tracert fails before the first hop.
> >>> v6 does work when ifconfig is not filtered out.
> >>
> >> This "should not happen".
> >>
> >> v6 should work no matter what we break in v4 land.
> >>
> >> But this is windows, and "should work" land...
> >
> > It happens because the patch skips CONFIG_TUN ioctl when v4 address is
> > not set. I think that skips some initialization steps. I had expected
> > the patch to setup the driver using 0/0/0 as the addres/mask/net as we
> > discussed earlier. Fixing that should make the tap driver talk back to
> > us and v6 work.
>
> I have fixed that, but I have not been able to compile/test yet. Feel
> free to give it a shot.
>

It works now though not thoroghly tested.

I just noticed this change:

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 8509d48..d183aea 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5718,7 +5718,10 @@ open_tun(const char *dev, const char *dev_type,
const char *dev_node, struct tun
             msg(M_FATAL, "ERROR: --dev tun also requires --ifconfig");
         }

-        if (tt->topology == TOP_SUBNET)
+        /* send 0/0/0 to the TAP driver even if we have no IPv4 configured
to
+         * ensure it is somehow initialized.
+         */
+        if (!tt->did_ifconfig_setup || tt->topology == TOP_SUBNET)
         {

This should work, but why change the logic? I would leave the conditionals
as in the original:

if (tt->topology == TOP_SUBNET) etc..

i.e call the CONFIG_TUN ioctl if topology is subnet else call
CONFIG_POINT_TO_POINT (eg., net30) irrsepective of v4 address is available
or not.  This separate handling of net30 and subnet in the orginal is due
to historic reasons[*]. That is already messy and confusing so why add to
it with another cryptic condition?

Just saying... feel free to ignore.

Selva

[*] Topology subnet uses ip, nework and netmask, while net30 passes in the
second IP of the /30 in network as "netmask". The two ioctls interprets
their parameters differently such that in the end only valid ARP packets
get a response from the driver !

--000000000000eb0f60056e16ed15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu,=
 Jun 7, 2018 at 1:29 PM Antonio Quartulli &lt;a@...2181...&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">On 08/06/18 01:05, Se=
lva Nair wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; On Thu, Jun 7, 2018 at 12:57 PM, Gert Doering &lt;<a href=3D"mailto:ge=
rt@...1296..." target=3D"_blank">gert@...1296...</a>&gt; wrote:<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; On Thu, Jun 07, 2018 at 12:14:51PM -0400, Selva Nair wrote:<br>
&gt;&gt;&gt; Note: All that said, I can&#39;t seem to connect to the server=
 via ipv6<br>
&gt;&gt;&gt; when there is no v4 address. tracert fails before the first ho=
p.<br>
&gt;&gt;&gt; v6 does work when ifconfig is not filtered out.<br>
&gt;&gt;<br>
&gt;&gt; This &quot;should not happen&quot;.<br>
&gt;&gt;<br>
&gt;&gt; v6 should work no matter what we break in v4 land.<br>
&gt;&gt;<br>
&gt;&gt; But this is windows, and &quot;should work&quot; land...<br>
&gt; <br>
&gt; It happens because the patch skips CONFIG_TUN ioctl when v4 address is=
<br>
&gt; not set. I think that skips some initialization steps. I had expected<=
br>
&gt; the patch to setup the driver using 0/0/0 as the addres/mask/net as we=
<br>
&gt; discussed earlier. Fixing that should make the tap driver talk back to=
<br>
&gt; us and v6 work.<br>
<br>
I have fixed that, but I have not been able to compile/test yet. Feel<br>
free to give it a shot.<br></blockquote><div><br></div><div>It works now th=
ough not thoroghly tested.</div><div><br></div><div>I just noticed this cha=
nge:</div><div><br></div><div>diff --git a/src/openvpn/tun.c b/src/openvpn/=
tun.c</div><div>index 8509d48..d183aea 100644</div><div>--- a/src/openvpn/t=
un.c</div><div>+++ b/src/openvpn/tun.c</div><div>@@ -5718,7 +5718,10 @@ ope=
n_tun(const char *dev, const char *dev_type, const char *dev_node, struct t=
un</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(M_FATAL, &=
quot;ERROR: --dev tun also requires --ifconfig&quot;);</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0</div><div>- =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (tt-&gt;topology =3D=3D TOP_SUBNET)</div><div>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* send 0/0/0 to the TAP driver even if we have no IPv4 configure=
d to</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 * ensure it is somehow initial=
ized.</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 */</div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (!tt-&gt;did_ifconfig_setup || tt-&gt;topology =3D=3D TOP_S=
UBNET)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div><br></div><d=
iv>This should work, but why change the logic? I would leave the conditiona=
ls as in the original:</div><div>=C2=A0</div><div>if (tt-&gt;topology =3D=
=3D TOP_SUBNET) etc..<br></div><div><br></div><div>i.e call the CONFIG_TUN =
ioctl if topology is subnet else call CONFIG_POINT_TO_POINT (eg., net30) ir=
rsepective of v4 address is available or not.=C2=A0 This separate handling =
of net30 and subnet in the orginal is due to historic reasons[*]. That is a=
lready messy and confusing so why add to it with another cryptic condition?=
</div><div>=C2=A0</div><div>Just saying... feel free to ignore.</div><div><=
br></div><div>Selva</div><div><br></div><div>[*] Topology subnet uses ip, n=
ework and netmask, while net30 passes in the second IP of the /30 in networ=
k as &quot;netmask&quot;. The two ioctls interprets their parameters differ=
ently such that in the end only valid ARP packets get a response from the d=
river !</div></div></div>

--000000000000eb0f60056e16ed15--

