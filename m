MIME-Version: 1.0
In-Reply-To: <d496bbf5-3c55-f2d9-2ab2-bc89ded80131@...2181...>
References: <20180608052017.6696-1-a@...2181...>
 <20180613141213.5962-1-a@...2181...>
 <20180620155301.GY57262@...1296...>
 <c416ea67-e4ce-148b-eb19-6d18b35da559@...2181...>
 <20180622094635.GI57262@...1296...>
 <d496bbf5-3c55-f2d9-2ab2-bc89ded80131@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 22 Jun 2018 14:12:24 -0400
Message-ID: <CAKuzo_jDrcGjQeMaVm3X6yzgKBZecbYHfAAxxCFAuycagTe22Q@...278...>
Content-Type: multipart/alternative; boundary="0000000000007bc193056f3efa08"
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000007bc193056f3efa08
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, Jun 22, 2018 at 5:49 AM, Antonio Quartulli <a@...2181...> wrote:

> Hi,
>
> On 22/06/18 17:46, Gert Doering wrote:
> > Hi,
> >
> > On Fri, Jun 22, 2018 at 03:27:02PM +0800, Antonio Quartulli wrote:
> >> Fri Jun 22 13:43:51 2018 us=116232 PUSH: Received control message:
> 'PUSH_REPLY,redirect-gateway !ipv4 ipv6,tun-ipv6,ping 10,ping-restart
> 120,ifconfig-ipv6 2002::1001/112 2002::2,peer-id 0,cipher AES-256-GCM'
> >
> > As an afterthought - the error could be totally unrelated to the changes,
> > and the win32 API refusing 2002:: addresses because it knows that they
> > are not "free for grabs"...  (6to4, normally auto-configured unless
> > disabled, with 2002:<ipv4>:: being the prefix that a host on <ipv4> or
> > a network behind a router on <ipv4> can use - but that's old stuff and
> > should no longer be used in any case).
>
> After changing the prefix to 2001:db8:cafe::/112 the error is gone.
>
> However, the assert at the end of the log in argv.c:299 is still there.
> This might be some argv_new()/reset() that has been misplaced (maybe?).
>

While the assert is definitely due to buggy code (as discussed in the other
thread),
I cant reproduce this. Both the version I had tested earlier and the v2/v3
patches
work without throwing this error.

Earlier I had tested with

pull-filter ignore "ifconfig "
route 192.168.0.0  255.255.255.0                    # test a tunnel route
route 192.168.1.0 255.255.255.0 net_gateway  # test an external route
redirect-gateway ipv6 !ipv4

Now retested by adding

pull-filter ignore route-gateway

as otherwise the v4 tunnel gateway was not null and the v4 route succeeded
with a simple warning (gateway unreacahble). With the route gateway removed,
the v4 route fails with

Fri Jun 22 13:52:08 2018 OpenVPN ROUTE: OpenVPN needs a gateway parameter
for a --route option and no default was specified by either --route-gateway
or --ifconfig options
Fri Jun 22 13:52:08 2018 OpenVPN ROUTE: failed to parse/resolve route for
host/network: 192.168.0.0
Fri Jun 22 13:52:08 2018 GDG6: remote_host_ipv6=n/a
Fri Jun 22 13:52:08 2018 GetBestInterfaceEx() returned if=15
Fri Jun 22 13:52:08 2018 GDG6: II=15 DP=::/0 NH=fe80::2d0:b7ff:febe:d8bc
Fri Jun 22 13:52:08 2018 GDG6: Metric=256, Loopback=0, AA=1, I=0
Fri Jun 22 13:52:08 2018 ROUTE6_GATEWAY fe80::2d0:b7ff:febe:d8bc I=15

Again, no assert.

Possibly you have some v4 route that triggers the assert, but I can't
figure which.
Or are you testing using a v6 only server -- even if so, its not clear how
that would
matter.

My tap adapter has a link local address (169.254.98.86) on it possibly due
to a previous dhcp failure. May be I need to get rid of that (how?) to
activate
this code path?

Selva

--0000000000007bc193056f3efa08
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Fri, Jun 22, 2018 at 5:49 AM, Antonio Quartulli <span dir=3D=
"ltr">&lt;<a href=3D"mailto:a@...2181..." target=3D"_blank">a@...2181...</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi=
,<br>
<span class=3D"gmail-"><br>
On 22/06/18 17:46, Gert Doering wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; On Fri, Jun 22, 2018 at 03:27:02PM +0800, Antonio Quartulli wrote:<br>
&gt;&gt; Fri Jun 22 13:43:51 2018 us=3D116232 PUSH: Received control messag=
e: &#39;PUSH_REPLY,redirect-gateway !ipv4 ipv6,tun-ipv6,ping 10,ping-restar=
t 120,ifconfig-ipv6 2002::1001/112 2002::2,peer-id 0,cipher AES-256-GCM&#39=
;<br>
&gt; <br>
&gt; As an afterthought - the error could be totally unrelated to the chang=
es,<br>
&gt; and the win32 API refusing 2002:: addresses because it knows that they=
<br>
&gt; are not &quot;free for grabs&quot;...=C2=A0 (6to4, normally auto-confi=
gured unless<br>
&gt; disabled, with 2002:&lt;ipv4&gt;:: being the prefix that a host on &lt=
;ipv4&gt; or<br>
&gt; a network behind a router on &lt;ipv4&gt; can use - but that&#39;s old=
 stuff and<br>
&gt; should no longer be used in any case).<br>
<br>
</span>After changing the prefix to 2001:db8:cafe::/112 the error is gone.<=
br>
<br>
However, the assert at the end of the log in argv.c:299 is still there.<br>
This might be some argv_new()/reset() that has been misplaced (maybe?).<br>=
</blockquote><div><br></div><div>While the assert is definitely due to bugg=
y code (as discussed in the other thread),<br></div><div>I cant reproduce t=
his. Both the version I had tested earlier and the v2/v3 patches<br></div><=
div>work without throwing this error.<br><br></div><div>Earlier I had teste=
d with <br><br>pull-filter ignore &quot;ifconfig &quot; <br>route 192.168.0=
.0=C2=A0 255.255.255.0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # test a tunnel r=
oute<br>route 192.168.1.0 255.255.255.0 net_gateway=C2=A0 # test an externa=
l route<br>redirect-gateway ipv6 !ipv4<br><br>Now retested by adding<br><br=
>pull-filter ignore route-gateway<br></div><div><br>as otherwise the v4 tun=
nel gateway was not null and the v4 route succeeded<br>with a simple warnin=
g (gateway unreacahble). With the route gateway removed,<br>the v4 route fa=
ils with<br><br>Fri Jun 22 13:52:08 2018 OpenVPN ROUTE: OpenVPN needs a gat=
eway parameter for a --route option and no default was specified by either =
--route-gateway or --ifconfig options<br>Fri Jun 22 13:52:08 2018 OpenVPN R=
OUTE: failed to parse/resolve route for host/network: 192.168.0.0<br>Fri Ju=
n 22 13:52:08 2018 GDG6: remote_host_ipv6=3Dn/a<br>Fri Jun 22 13:52:08 2018=
 GetBestInterfaceEx() returned if=3D15<br>Fri Jun 22 13:52:08 2018 GDG6: II=
=3D15 DP=3D::/0 NH=3Dfe80::2d0:b7ff:febe:d8bc<br>Fri Jun 22 13:52:08 2018 G=
DG6: Metric=3D256, Loopback=3D0, AA=3D1, I=3D0<br>Fri Jun 22 13:52:08 2018 =
ROUTE6_GATEWAY fe80::2d0:b7ff:febe:d8bc I=3D15<br><br></div><div>Again, no =
assert.<br><br></div><div>Possibly you have some v4 route that triggers the=
 assert, but I can&#39;t figure which.<br></div><div>Or are you testing usi=
ng a v6 only server -- even if so, its not clear how that would<br>matter.<=
br></div><div><br></div><div>My tap adapter has a link local address (169.2=
54.98.86) on it possibly due<br>to a previous dhcp failure. May be I need t=
o get rid of that (how?) to activate<br>this code path?<br></div><div><br><=
/div><div>Selva<br></div></div></div></div></div>

--0000000000007bc193056f3efa08--

