MIME-Version: 1.0
References: <20210907223126.8440-1-selva.nair@...277...>
 <202212270831.2BR8VUQ3085016@...2054...>
In-Reply-To: <202212270831.2BR8VUQ3085016@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 27 Dec 2022 13:18:02 -0500
Message-ID: <CAKuzo_jAq3Roq_HfR_WOmVW1OWcPKa-h0JGSYF8=4xC1VW1ukA@...278...>
Content-Type: multipart/alternative; boundary="000000000000ad760705f0d34631"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add remote-count and
 remote-entry query via management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000ad760705f0d34631
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Dec 26, 2022 at 05:30:23PM -0500, Selva Nair wrote:
> > > > +
> > > > +#define min(a,b) ((a) < (b) ? (a) : (b))
> > >
> > > We already have min_int and min_uint in integer.h. For consistency I
> > > would prefer using those instead of adding a macro.


Unfortunately, this is more than "just an extra macro" - it breaks our
> MSVC builds due to the windows equivalent of -Werr and macro
> redefinition...



https://github.com/OpenVPN/openvpn/actions/runs/3786194652/jobs/6436868937


Sorry about that -- I did not check MSVC build.

Looks like a fix is already in. Thanks Arne.

One thing that confuses me slightly - either I am holding this wrong, or
> I don't understand how this is supposed to work...
>
>  - I run the client with --management-hold
>  - connect to the management interface
>  - try remote-entry-count ...
>
>     >INFO:OpenVPN Management Interface Version 4 -- type 'help' for more
> info
>     >HOLD:Waiting for hold release:0
>     remote-entry-count
>     ERROR: The remote-entry-count command is not supported by the current
> daemon mode
>
>  - do a hold release (openvpn connects to the first remote now), then try
>    again...
>
>     hold release
>     SUCCESS: hold release succeeded
>     remote-entry-count
>     5
>     END
>

My test implementation in the GUI constructs the list when first >REMOTE
query is received. If there is no >REMOTE from the daemon, the feature is
not used. That works.

That said, making these commands work from management-hold would have been
nice, but looked harder to implement -- we need a callback to get the
context in management.c, but callbacks are initialized late.

Selva

--000000000000ad760705f0d34631
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><span style=3D"color:rgb(80,0,80)">On Mon, Dec 26, 202=
2 at 05:30:23PM -0500, Selva Nair wrote:<br></span><span style=3D"color:rgb=
(80,0,80)">&gt; &gt; &gt; +<br></span><span style=3D"color:rgb(80,0,80)">&g=
t; &gt; &gt; +#define min(a,b) ((a) &lt; (b) ? (a) : (b))<br></span><span s=
tyle=3D"color:rgb(80,0,80)">&gt; &gt;<br></span><span style=3D"color:rgb(80=
,0,80)">&gt; &gt; We already have min_int and min_uint in integer.h. For co=
nsistency I<br></span><span style=3D"color:rgb(80,0,80)">&gt; &gt; would pr=
efer using those instead of adding a macro.</span></blockquote><div><span s=
tyle=3D"color:rgb(80,0,80)"><br></span><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Unfortunately, this is more than &quot;just an extra macro&qu=
ot; - it breaks our<br>MSVC builds due to the windows equivalent of -Werr a=
nd macro<br>redefinition...=C2=A0</blockquote><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">=C2=A0</blockquote><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><a href=3D"https://github.com/OpenVPN/openvpn/actions/runs/3=
786194652/jobs/6436868937" rel=3D"noreferrer" target=3D"_blank">https://git=
hub.com/OpenVPN/openvpn/actions/runs/3786194652/jobs/6436868937</a></blockq=
uote></div><div><br></div><div>Sorry about that -- I did not check MSVC bui=
ld.</div><div><br></div><div>Looks like a fix is already in. Thanks Arne.</=
div><div><br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
One thing that confuses me slightly - either I am holding this wrong, or<br>
I don&#39;t understand how this is supposed to work...<br>
<br>
=C2=A0- I run the client with --management-hold<br>
=C2=A0- connect to the management interface<br>
=C2=A0- try remote-entry-count ...<br>
<br>
=C2=A0 =C2=A0 &gt;INFO:OpenVPN Management Interface Version 4 -- type &#39;=
help&#39; for more info<br>
=C2=A0 =C2=A0 &gt;HOLD:Waiting for hold release:0<br>
=C2=A0 =C2=A0 remote-entry-count<br>
=C2=A0 =C2=A0 ERROR: The remote-entry-count command is not supported by the=
 current daemon mode<br>
<br>
=C2=A0- do a hold release (openvpn connects to the first remote now), then =
try<br>
=C2=A0 =C2=A0again...<br>
<br>
=C2=A0 =C2=A0 hold release<br>
=C2=A0 =C2=A0 SUCCESS: hold release succeeded<br>
=C2=A0 =C2=A0 remote-entry-count<br>
=C2=A0 =C2=A0 5<br>
=C2=A0 =C2=A0 END<br></blockquote><div><br></div><div>My test implementatio=
n in the GUI constructs the list when first &gt;REMOTE query is received. I=
f there is no=C2=A0&gt;REMOTE from the daemon, the feature is not used. Tha=
t works.</div><div><br></div><div>That said, making these commands work fro=
m management-hold would have been nice, but looked harder=C2=A0to implement=
 -- we need a callback to get the context in management.c, but callbacks ar=
e initialized late.</div><div>=C2=A0</div><div>Selva</div></div></div>

--000000000000ad760705f0d34631--

