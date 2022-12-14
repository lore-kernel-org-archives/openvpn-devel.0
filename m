MIME-Version: 1.0
References: <20221214164824.172-1-lstipakov@...277...>
 <CAKuzo_iZPLJvSyK53oziTO99ZW6ua-DFvEWMoPAK3MjrjQ5PdA@...278...>
 <CAGyAFMV=QqUUPj8-Z8_U3JWG3qoBOZOKpMMVAztpdc-8qT+0HQ@...278...>
In-Reply-To: <CAGyAFMV=QqUUPj8-Z8_U3JWG3qoBOZOKpMMVAztpdc-8qT+0HQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 14 Dec 2022 14:30:50 -0500
Message-ID: <CAKuzo_g6Pc6djBCu05-k5oJFWYuTYBFa60Ucay+z1BebJK=9Gg@...278...>
Content-Type: multipart/alternative; boundary="000000000000150a4a05efcec726"
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--000000000000150a4a05efcec726
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Dec 14, 2022 at 2:06 PM Lev Stipakov <lstipakov@...277...> wrote:

>
> > Right now what the GUI receives as bytecount  is not zero, I suppose the
> daemon is reporting the control channel traffic.
>
> Yes. I will fix it in the driver so that it reports only data channel
> bytes, since control channel bytes are already counted in userspace.


This data will also show up as stats on the adapter (device node) and
should include all traffic that passes through it, no? The userspace
reporting can handle either approach as long as all dco platforms count
stats the same way.

Selva

--000000000000150a4a05efcec726
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Wed, Dec 14, 2022 at 2:06 PM Lev Stipakov &lt;<=
a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...277...=
</a>&gt; wrote:</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Right now what the GUI receives as bytecount=C2=A0 is not zero, I supp=
ose the daemon is reporting the control channel traffic.<br>
<br>
Yes. I will fix it in the driver so that it reports only data channel<br>
bytes, since control channel bytes are already counted in userspace.</block=
quote><div><br></div><div>This data will also show up as stats on the adapt=
er (device node) and should include all traffic that passes through it, no?=
 The userspace reporting=C2=A0can handle either approach as long as all dco=
 platforms count stats the same way.</div><div>=C2=A0</div><div>Selva</div>=
</div></div>

--000000000000150a4a05efcec726--

