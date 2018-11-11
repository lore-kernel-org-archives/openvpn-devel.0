MIME-Version: 1.0
References: <1530633509-4959-1-git-send-email-selva.nair@...277...>
 <1531491395-29049-1-git-send-email-selva.nair@...277...>
 <4e0e285a-482a-700a-e359-fc8cf8c1613c@...1856...>
 <CAKuzo_iXRkuzeVG0ec2mDA8a-arQe-J9seo1R+ZdRA7ktWbt=w@...278...>
 <da22fd72-2b38-1f46-a4f7-0688fea3babe@...1856...>
In-Reply-To: <da22fd72-2b38-1f46-a4f7-0688fea3babe@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 11 Nov 2018 12:03:10 -0500
Message-ID: <CAKuzo_h0xMzB7ST7xbQOZ_5R5tDJny6OfYEzKD46yVT4kVEMOQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000037035a057a66908e"
Subject: Re: [Openvpn-devel] [PATCH v3] Make up/down script errors not FATAL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000037035a057a66908e
Content-Type: text/plain; charset="UTF-8"

Hi Steffan,

On Sun, Nov 11, 2018 at 8:43 AM Steffan Karger <steffan@...1856...> wrote:

> Hi,
>
> I've postponed replying to this mail a couple of times because I felt I
> missed something and needed to look closer, but today once again I don't
> get it. So here goes for a potentially stupid reply:
>

Not so fast, likely its my stupidity to push for this.


>
> On 05-10-18 17:30, Selva Nair wrote:
> > On Fri, Oct 5, 2018 at 5:44 AM Steffan Karger <steffan@...1856...
> > <mailto:steffan@...1856...>> wrote:
> >
> >     Hi,
> >
> >     On 13-07-18 16:16, selva.nair@...277...
> >     <mailto:selva.nair@...277...> wrote:
> >     > From: Selva Nair <selva.nair@...277... <mailto:
> selva.nair@...277...>>
> >     >
> >     > The error is treated as a warning only if its triggered due
> >     > to script_security < SSEC_SCRIPTS.
> >     >
> >     > This helps user interfaces enforce a safer script-security setting
> >     > without causing a FATAL error.
> >
> >     But does it make sense at all to accept configs that have a --up
> script
> >     without a sufficiently-high script-security set?
> >
> >
> > This came out of a proposed patch for the GUI to protect lay users from
> > malicious
> > scripts embedded in config files.
> >
> > Recall the ado about exploiting scripts using unsuspecting "inline"
> > commands.
> > To defeat such exploits we want to enforce a safer script security
> > setting from
> > the GUI but do not want to cause a FATAL error as that would be counter
> > productive.
> >
> > Please see GUI PR #271 https://github.com/OpenVPN/openvpn-gui/pull/271
> and
> > my comment dated Jul 3 under it.
> >
> > The discussion that led to this is here:
> > https://github.com/OpenVPN/openvpn-gui/issues/270
>
> I fail to understand why you believe a fatal error in this case is
> counterproductive.
>
> A config file that has a script configured, but is not allowed to run
> that script is a faulty setup that might result is connections that are
> not working properly or maybe even not providing the expected security
> level. Consider for example someone changing DNS or proxy settings in a
> --up script to avoid leaking data. Most users will never reads warnings
> if the connection pretends to be set up correctly. This makes me believe
> that the best thing we can do is to error out if someone tries to
> connect using such a configuration, and have them review their
> configuration.
>
> Why is a fatal error not exactly what you would want?
>

When you put it that way I can't disagree. Either I hadn't thought through
it properly, or have forgotten my reasoning (it has been a while since I
tested the GUI patch that prompted this).

I will drop this patch at least for now and go ahead with the
feature to override script security setting from the GUI.

Thanks for your time, and sorry for wasting it.

Selva

--00000000000037035a057a66908e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>Hi Steffan,<div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr">On Sun, Nov 11, 2018 at 8:43 AM Steffan Karger &lt;<a href=3D"mai=
lto:steffan@...1856...">steffan@...1856...</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">Hi,<br>
<br>
I&#39;ve postponed replying to this mail a couple of times because I felt I=
<br>
missed something and needed to look closer, but today once again I don&#39;=
t<br>
get it. So here goes for a potentially stupid reply:<br></blockquote><div><=
br></div><div>Not so fast, likely its my stupidity to push for this.</div><=
div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
On 05-10-18 17:30, Selva Nair wrote:<br>
&gt; On Fri, Oct 5, 2018 at 5:44 AM Steffan Karger &lt;<a href=3D"mailto:st=
effan@...1856..." target=3D"_blank">steffan@...1856...</a><br>
&gt; &lt;mailto:<a href=3D"mailto:steffan@...1856..." target=3D"_blank">ste=
ffan@...1856...</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 13-07-18 16:16, <a href=3D"mailto:selva.nair@...493...=
277..." target=3D"_blank">selva.nair@...277...</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:selva.nair@...277..." =
target=3D"_blank">selva.nair@...277...</a>&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.n=
air@...277..." target=3D"_blank">selva.nair@...277...</a> &lt;mailto:<a hre=
f=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a=
>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; The error is treated as a warning only if its =
triggered due<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; to script_security &lt; SSEC_SCRIPTS.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; This helps user interfaces enforce a safer scr=
ipt-security setting<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; without causing a FATAL error.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0But does it make sense at all to accept configs tha=
t have a --up script<br>
&gt;=C2=A0 =C2=A0 =C2=A0without a sufficiently-high script-security set?<br>
&gt; <br>
&gt; <br>
&gt; This came out of a proposed patch for the GUI to protect lay users fro=
m<br>
&gt; malicious<br>
&gt; scripts embedded in config files.<br>
&gt; <br>
&gt; Recall the ado about exploiting scripts using unsuspecting &quot;inlin=
e&quot;<br>
&gt; commands.<br>
&gt; To defeat such exploits we want to enforce a safer script security<br>
&gt; setting from<br>
&gt; the GUI but do not want to cause a FATAL error as that would be counte=
r<br>
&gt; productive.<br>
&gt; <br>
&gt; Please see GUI PR #271 <a href=3D"https://github.com/OpenVPN/openvpn-g=
ui/pull/271" rel=3D"noreferrer" target=3D"_blank">https://github.com/OpenVP=
N/openvpn-gui/pull/271</a> and<br>
&gt; my comment dated Jul 3 under it.<br>
&gt; <br>
&gt; The discussion that led to this is here:<br>
&gt; <a href=3D"https://github.com/OpenVPN/openvpn-gui/issues/270" rel=3D"n=
oreferrer" target=3D"_blank">https://github.com/OpenVPN/openvpn-gui/issues/=
270</a><br>
<br>
I fail to understand why you believe a fatal error in this case is<br>
counterproductive.<br>
<br>
A config file that has a script configured, but is not allowed to run<br>
that script is a faulty setup that might result is connections that are<br>
not working properly or maybe even not providing the expected security<br>
level. Consider for example someone changing DNS or proxy settings in a<br>
--up script to avoid leaking data. Most users will never reads warnings<br>
if the connection pretends to be set up correctly. This makes me believe<br>
that the best thing we can do is to error out if someone tries to<br>
connect using such a configuration, and have them review their<br>
configuration.<br>
<br>
Why is a fatal error not exactly what you would want?<br></blockquote><div>=
=C2=A0</div><div>When you put it that way I can&#39;t disagree. Either I ha=
dn&#39;t thought through</div><div>it properly, or have forgotten my reason=
ing (it has been a while since I</div><div>tested the GUI patch that prompt=
ed this).</div><div><br></div><div>I will drop this patch at least for now =
and go ahead with the</div><div>feature to override script security setting=
 from the GUI.</div><div><br></div><div>Thanks for your time, and sorry for=
 wasting it.</div><div><br></div><div>Selva</div></div></div></div>

--00000000000037035a057a66908e--

