MIME-Version: 1.0
References: <20210930113308.815777-1-mkh199740@...450...>
 <CAKuzo_iWaTiKSeiTVrqkLfbPLp+ScvGm_m8stEUNOzunobXVUg@...278...>
 <a7edcdc8.AVYAAFhev6wAAAAAAAAAAOUrOPYAAYCshBkAAAAAABXTlQBitF_o@...2677...>
In-Reply-To: <a7edcdc8.AVYAAFhev6wAAAAAAAAAAOUrOPYAAYCshBkAAAAAABXTlQBitF_o@...2677...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 23 Jun 2022 09:34:51 -0400
Message-ID: <CAKuzo_hh0Hq44SUQsVjqqaa=NmZ6TOof_jo_5dY4CZM_KpNwrg@...278...>
Content-Type: multipart/alternative; boundary="000000000000a6024805e21d852c"
Subject: Re: [Openvpn-devel] [PATCH] Add ability to specify initialize flags
 for pkcs11 provider
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Petr Mikhalicin <mkh199740@...450...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000a6024805e21d852c
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Jun 23, 2022 at 8:43 AM David Sommerseth <
openvpn@...2080...> wrote:

> On 19/6/2022 19:28, Selva Nair wrote:
> > Hi,0
> >
> > On Thu, Sep 30, 2021 at 7:34 AM Petr Mikhalicin via Openvpn-devel
> > <openvpn-devel@lists.sourceforge.net
> > <mailto:openvpn-devel@lists.sourceforge.net>> wrote:
> >
> >     New pkcs11-helper interface allows to setup pkcs11 provider via
> >     properties:
> >
> https://github.com/alonbl/pkcs11-helper/commit/b78d21c7e26041746aa4ae3d08b95469e1714a85
> >     <
> https://github.com/alonbl/pkcs11-helper/commit/b78d21c7e26041746aa4ae3d08b95469e1714a85
> >
> >
> >     Also pkcs11-helper added ability to setup init args for pkcs11
> provider:
> >
> https://github.com/alonbl/pkcs11-helper/commit/133f893e30856eba1de715ecd6fe176722eb3097
> >     <
> https://github.com/alonbl/pkcs11-helper/commit/133f893e30856eba1de715ecd6fe176722eb3097
> >
> >
> >     Signed-off-by: Petr Mikhalicin <mkh199740@...450...
> >     <mailto:mkh199740@...450...>>
> >
> >
> > Sorry for the long delay in getting back on this. I somehow also missed
> > the related discussion on Trac
> > (https://community.openvpn.net/openvpn/ticket/1453
> > <https://community.openvpn.net/openvpn/ticket/1453>)
> >
> > I don't quite understand the need for exposing "init-args" to the user.
> > The only two supported flags in the cryptoki docs are related to the use
> > of threads. But we are the application and we should know what flags to
> > pass --- not the user --- isn't it? If CKF_OS_LOCKING_OK is required,
> > can't we just set it unconditionally?
> >
> > That said, OpenVPN2 is single threaded, so why is there a "bug in
> > openvpn" related to the use of pkcs11 library from multiple threads
> > referred to in the trac ticket?
>
> I haven't dug too deep into the matter this time; and it depends also on
> the OS you are on.  But there has been some issues with pkcs11-helper on
> hosts with systemd, due to some intricacies with openvpn doing a fork to
> kick off the password query mechanism with systemd colliding with some
> pkcs11-helper implementation details.  For the systemd case, we added a
> workaround which made most people happy.
>
> For more details:
> <https://community.openvpn.net/openvpn/ticket/538>
>

This is a different issue from  mutex locking required when  pkcs#11  calls
are made from multiple threads. The rationale for this patch was that we
may need to tell the provider library whether native OS locking methods are
okay or not, which I see no need for in a single threaded program.

Selva

--000000000000a6024805e21d852c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Thu, Jun 23, 2022 at 8:43 AM David Sommerseth &=
lt;<a href=3D"mailto:openvpn@...2080...">openvpn@...2080...</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 19/6/2022 19:=
28, Selva Nair wrote:<br>
&gt; Hi,0<br>
&gt; <br>
&gt; On Thu, Sep 30, 2021 at 7:34 AM Petr Mikhalicin via Openvpn-devel <br>
&gt; &lt;<a href=3D"mailto:openvpn-devel@lists.sourceforge.net" target=3D"_=
blank">openvpn-devel@lists.sourceforge.net</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:openvpn-devel@lists.sourceforge.net" targ=
et=3D"_blank">openvpn-devel@lists.sourceforge.net</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0New pkcs11-helper interface allows to setup pkcs11 =
provider via<br>
&gt;=C2=A0 =C2=A0 =C2=A0properties:<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://github.com/alonbl/pkcs11-helper/=
commit/b78d21c7e26041746aa4ae3d08b95469e1714a85" rel=3D"noreferrer" target=
=3D"_blank">https://github.com/alonbl/pkcs11-helper/commit/b78d21c7e2604174=
6aa4ae3d08b95469e1714a85</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://github.com/alonbl/pkcs11-hel=
per/commit/b78d21c7e26041746aa4ae3d08b95469e1714a85" rel=3D"noreferrer" tar=
get=3D"_blank">https://github.com/alonbl/pkcs11-helper/commit/b78d21c7e2604=
1746aa4ae3d08b95469e1714a85</a>&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Also pkcs11-helper added ability to setup init args=
 for pkcs11 provider:<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://github.com/alonbl/pkcs11-helper/=
commit/133f893e30856eba1de715ecd6fe176722eb3097" rel=3D"noreferrer" target=
=3D"_blank">https://github.com/alonbl/pkcs11-helper/commit/133f893e30856eba=
1de715ecd6fe176722eb3097</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://github.com/alonbl/pkcs11-hel=
per/commit/133f893e30856eba1de715ecd6fe176722eb3097" rel=3D"noreferrer" tar=
get=3D"_blank">https://github.com/alonbl/pkcs11-helper/commit/133f893e30856=
eba1de715ecd6fe176722eb3097</a>&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Petr Mikhalicin &lt;<a href=3D"mailt=
o:mkh199740@...450..." target=3D"_blank">mkh199740@...450...</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mkh199740@...450..." t=
arget=3D"_blank">mkh199740@...450...</a>&gt;&gt;<br>
&gt; <br>
&gt; <br>
&gt; Sorry for the long delay in getting back on this. I somehow also misse=
d <br>
&gt; the related discussion on Trac <br>
&gt; (<a href=3D"https://community.openvpn.net/openvpn/ticket/1453" rel=3D"=
noreferrer" target=3D"_blank">https://community.openvpn.net/openvpn/ticket/=
1453</a> <br>
&gt; &lt;<a href=3D"https://community.openvpn.net/openvpn/ticket/1453" rel=
=3D"noreferrer" target=3D"_blank">https://community.openvpn.net/openvpn/tic=
ket/1453</a>&gt;)<br>
&gt; <br>
&gt; I don&#39;t quite understand the need for exposing &quot;init-args&quo=
t; to the user. <br>
&gt; The only two supported flags in the cryptoki docs are related to the u=
se <br>
&gt; of threads. But we are the application and we should know what flags t=
o <br>
&gt; pass --- not the user --- isn&#39;t it? If CKF_OS_LOCKING_OK is requir=
ed, <br>
&gt; can&#39;t we just set it unconditionally?<br>
&gt; <br>
&gt; That said, OpenVPN2 is single threaded, so why is there=C2=A0a &quot;b=
ug in <br>
&gt; openvpn&quot; related to the use of pkcs11 library from multiple threa=
ds <br>
&gt; referred to in the trac ticket?<br>
<br>
I haven&#39;t dug too deep into the matter this time; and it depends also o=
n <br>
the OS you are on.=C2=A0 But there has been some issues with pkcs11-helper =
on <br>
hosts with systemd, due to some intricacies with openvpn doing a fork to <b=
r>
kick off the password query mechanism with systemd colliding with some <br>
pkcs11-helper implementation details.=C2=A0 For the systemd case, we added =
a <br>
workaround which made most people happy.<br>
<br>
For more details:<br>
&lt;<a href=3D"https://community.openvpn.net/openvpn/ticket/538" rel=3D"nor=
eferrer" target=3D"_blank">https://community.openvpn.net/openvpn/ticket/538=
</a>&gt;<br></blockquote><div><br></div><div>This is a different issue from=
=C2=A0 mutex locking required when=C2=A0 pkcs#11=C2=A0 calls are made from =
multiple threads. The rationale for this patch was that we may need to tell=
 the provider library whether native OS locking methods are okay or not, wh=
ich I see no need for in a single threaded program.</div><div><br></div><di=
v>Selva</div></div></div>

--000000000000a6024805e21d852c--

