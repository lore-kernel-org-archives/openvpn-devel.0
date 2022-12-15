MIME-Version: 1.0
References: <20221214164824.172-1-lstipakov@...277...>
 <CAKuzo_iZPLJvSyK53oziTO99ZW6ua-DFvEWMoPAK3MjrjQ5PdA@...278...>
 <CAGyAFMV=QqUUPj8-Z8_U3JWG3qoBOZOKpMMVAztpdc-8qT+0HQ@...278...>
 <CAKuzo_g6Pc6djBCu05-k5oJFWYuTYBFa60Ucay+z1BebJK=9Gg@...278...>
 <CAGyAFMUTjZuN+W8FagK+F=4P+iuUAEYS0qmieb3kNQYKN-z=gg@...278...>
 <Y5pEEhAGyKzbNn8u@...1296...>
 <CAGyAFMUQUx_oL_Qi6SBcAdB94VCW+1tmTQVkoCh5B0BnYThkLg@...278...>
 <CAKuzo_imcQLV60uJN9mXTR8ti7gctgR=iZVpi+2AvDvSTJ_x0g@...278...>
 <CAKuzo_jVnAUeKM9=x1vU_DztqPrwYJfHe=YTy5AS8PKF2_Tv1g@...278...>
 <CAGyAFMVkMAUmiNZCbp3xwognY-5d7-ZGEH9v=S17YBogfx2vnA@...278...>
 <4c416e69-07b6-b7e0-25aa-0b3fb3ce5ac4@...2181...>
In-Reply-To: <4c416e69-07b6-b7e0-25aa-0b3fb3ce5ac4@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 15 Dec 2022 07:49:53 -0500
Message-ID: <CAKuzo_gSYJdi8oJ3AaFK3gHv2k-YVOYzdW5mLnR89C_ZrtPDvg@...278...>
Content-Type: multipart/alternative; boundary="0000000000000aea2805efdd4b06"
Subject: Re: [Openvpn-devel] [PATCH] Introduce dco_get_peer_stats API and
 Windows implementation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Lev Stipakov <lstipakov@...277...>, Lev Stipakov <lev@...515...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--0000000000000aea2805efdd4b06
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Dec 15, 2022 at 5:15 AM Antonio Quartulli <a@...2181...> wrote:

> Hi,
>
> On 15/12/2022 10:31, Lev Stipakov wrote:
> > Hi,
> >
> >> In non-dco use, the stats as persisted by the management interface are
> not reset throughout the lifetime of the process. With dco, what the driver
> provides is "Peer Stats" which is reset in OvpnPeerNew()  (linux appears to
> do the same). A quick option > would be to move the zero-ing to
> OvpnEvtFileCleanup() which, I guess, would work at least when persist-tun
> is in use.
> >
> > Yeah, without persist-tun client closes the handle, which triggers
> > OvpnEvtFileCleanup(), which would reset stats.
>

Currently its worse than that -- stats is reset in OvpnNewPeer() which
would happen (I guess) even if the tun handle is not closed. My suggestion
was to move it to OvpnEvtFileCleanup() which will help those who use
persist-tun.

But all that is moot based on Antonio's explanation below -- this is Peer
Stats, not adapter stats, so it has to reset as it is done now... I was
treating it like the stats in a network interface which would be reset only
on rare events lke adapter reset or driver update or reboot.


> >
> >> Or in a new callback that gets called on tun-open. But then it wont be
> strictly "Peer Stats".
> >
> > Yeah that might be an option, to have RESET_STATS ioctl.
> >
> > Also I wonder if the driver could remember, say, the last pid, and
> > then reset stats on NEW_PEER if pid != last pid. Since pids are
> > recycled, we might "leak" stats in unfortunate cases, but that's okay
> > I guess?
> >
>
> Sorry for jumping in the discussion a bit late.
>
> IMHO the stats belong to the Peer object.
> Let's not forget that, apart from windows, DCO supports multi-peer mode,
> therefore we have to consider that case as well.
>
> Due to the above, I'd "reset" the stats when a new peer object is
> instantiated. Basically when a new peer object is instantiated it should
> come with empty stats, as expected.
>
> If the desired behvaiour in userspace is to keep the stats persistent
> across a number of events, it should simply be userspace to keep those
> stats.
>
> This way we don't mix up the logic of counting the bytes per peer, and
> keeping a general picture of the VPN process.
>

Good point. I was late to realize that Peer Stats has to remain as it is to
make sense in multi-peer scenarios.

In that case we'll have to find a way to persist the stats across NEW_PEER
controls within the client process. Possibly we can merge the current patch
for openvpn.exe and then improve it later in bug-fix releases of 2.6?

Selva

--0000000000000aea2805efdd4b06
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Thu, Dec 15, 2022 at 5:15 AM Antonio Quartulli =
&lt;<a href=3D"mailto:a@...2181...">a@...2181...</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On 15/12/2022 10:31, Lev Stipakov wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt;&gt; In non-dco use, the stats as persisted by the management interface=
 are not reset throughout the lifetime of the process. With dco, what the d=
river provides is &quot;Peer Stats&quot; which is reset in OvpnPeerNew()=C2=
=A0 (linux appears to do the same). A quick option &gt; would be to move th=
e zero-ing to OvpnEvtFileCleanup() which, I guess, would work at least when=
 persist-tun is in use.<br>
&gt; <br>
&gt; Yeah, without persist-tun client closes the handle, which triggers<br>
&gt; OvpnEvtFileCleanup(), which would reset stats.<br></blockquote><div><b=
r></div><div>Currently its worse than that -- stats is reset in OvpnNewPeer=
() which would happen (I guess) even if the tun handle is not closed. My su=
ggestion was to move it to OvpnEvtFileCleanup() which will help those who u=
se persist-tun.=C2=A0</div><div><br></div><div>But all that is moot based o=
n Antonio&#39;s explanation below -- this is Peer Stats, not adapter=C2=A0s=
tats, so it has to reset as it is done now... I was treating it like the st=
ats in a network interface which would be reset only on rare events lke=C2=
=A0adapter reset or driver update or reboot.</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt;&gt; Or in a new callback that gets called on tun-open. But then it won=
t be strictly &quot;Peer Stats&quot;.<br>
&gt; <br>
&gt; Yeah that might be an option, to have RESET_STATS ioctl.<br>
&gt; <br>
&gt; Also I wonder if the driver could remember, say, the last pid, and<br>
&gt; then reset stats on NEW_PEER if pid !=3D last pid. Since pids are<br>
&gt; recycled, we might &quot;leak&quot; stats in unfortunate cases, but th=
at&#39;s okay<br>
&gt; I guess?<br>
&gt; <br>
<br>
Sorry for jumping in the discussion a bit late.<br>
<br>
IMHO the stats belong to the Peer object.<br>
Let&#39;s not forget that, apart from windows, DCO supports multi-peer mode=
, <br>
therefore we have to consider that case as well.<br>
<br>
Due to the above, I&#39;d &quot;reset&quot; the stats when a new peer objec=
t is <br>
instantiated. Basically when a new peer object is instantiated it should <b=
r>
come with empty stats, as expected.<br>
<br>
If the desired behvaiour in userspace is to keep the stats persistent <br>
across a number of events, it should simply be userspace to keep those <br>
stats.<br>
<br>
This way we don&#39;t mix up the logic of counting the bytes per peer, and =
<br>
keeping a general picture of the VPN process.<br></blockquote><div><br></di=
v><div>Good point. I was late to realize that Peer Stats has to remain as i=
t is to make sense in multi-peer scenarios.</div><div><br></div><div>In tha=
t case we&#39;ll have to find a way to persist the stats across NEW_PEER co=
ntrols within the client process. Possibly we can merge the current patch f=
or openvpn.exe and then improve it later in bug-fix releases of 2.6?</div><=
div><br></div><div>Selva</div></div></div>

--0000000000000aea2805efdd4b06--

