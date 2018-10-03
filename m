MIME-Version: 1.0
References: <1538576212-2363-1-git-send-email-lstipakov@...277...>
 <CAKuzo_ijYi_qnpRJmNOUQpg9VEsPeqSwZS5d8VYuMNcMDNgw-w@...278...>
 <8ddfa02f-4003-4a20-5cce-6bb5d8e70e89@...2080...>
In-Reply-To: <8ddfa02f-4003-4a20-5cce-6bb5d8e70e89@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 3 Oct 2018 12:31:12 -0400
Message-ID: <CAKuzo_iNhAf1yVG2qP0mfZpKWDukhJdcH6nGsJnHQ7=Rz60QuQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000029321405775592bd"
Subject: Re: [Openvpn-devel] [PATCH] openvpnserv: clarify return values type
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000029321405775592bd
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 3, 2018 at 12:05 PM David Sommerseth <
openvpn@...2080...> wrote:

> On 03/10/18 17:08, Selva Nair wrote:
> >
> >
> >     To make code more clear, change return type to bool. Also
> >     use stdbool.h header instead of bool definition macros.
> >
> > We do use BOOL all over the service code (unavoidable with
> > Windows API), and bool is used in only one or two places. So would it
> > be better to just change this to BOOL/TRUE/FALSE and not include
> > stdbool.h?
>
> Several years ago, we started towards a path to get rid of the
> BOOL/TRUE/FALSE
> stuff, in favour of stdbool.h.  And when we moved towards -std=c99, this
> made
> this move even more reasonable.
>

Yes, I know that's the path taken in openvpn core sources which is very
sensible in
a cross-platform code.


>
> But ... are you saying Windows C compilers we use/support does not support
> stdbool.h?  Even with -std=c99?
>

It does, but we cannot avoid using the Windows-specific BOOL (which I
believe is a typedef to int pulled in through windows.h)  as Windows API is
replete with it. In fact stdbool's bool may be internally an int and thus
same
as BOOL but we can't assume that.

In case of the service code, which is Windows only, there are about 30 uses
of
BOOL but only a few cases of bool (typdef to int) all of which are in the
deprecated
automatic service code. This patch changes the latter to use stdbool which
is
quite reasonable. But I just wonder whether its just better to use BOOL in
this occasion as the latter is not going to go away in Windows.

That said, I prefer stdbool too, and I'm fine with moving towards replacing
all BOOL
with bool and casting to BOOL if/when required (say, calling Windows API).

Selva

--00000000000029321405775592bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed=
, Oct 3, 2018 at 12:05 PM David Sommerseth &lt;<a href=3D"mailto:openvpn@...1186...=
.2080...">openvpn@...2080...</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">On 03/10/18 17:08, Selva Nair wrote:<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0To make code more clear, change return type to bool=
. Also<br>
&gt;=C2=A0 =C2=A0 =C2=A0use stdbool.h header instead of bool definition mac=
ros.<br>
&gt; <br>
&gt; We do use BOOL all over the service code (unavoidable with<br>
&gt; Windows API), and bool is used in only one or two places. So would it<=
br>
&gt; be better to just change this to BOOL/TRUE/FALSE and not include<br>
&gt; stdbool.h?<br>
<br>
Several years ago, we started towards a path to get rid of the BOOL/TRUE/FA=
LSE<br>
stuff, in favour of stdbool.h.=C2=A0 And when we moved towards -std=3Dc99, =
this made<br>
this move even more reasonable.<br></blockquote><div><br></div><div>Yes, I =
know that&#39;s the path taken in openvpn core sources which is very sensib=
le in<br></div><div>a cross-platform code.<br></div><div>=C2=A0<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
<br>
But ... are you saying Windows C compilers we use/support does not support<=
br>
stdbool.h?=C2=A0 Even with -std=3Dc99?<br></blockquote><div><br></div><div>=
It does, but we cannot avoid using the Windows-specific BOOL (which I<br>be=
lieve is a typedef to int pulled in through windows.h)=C2=A0 as Windows API=
 is<br>replete with it. In fact stdbool&#39;s bool may be internally an int=
 and thus same<br>as BOOL but we can&#39;t assume that.<br></div><div><br><=
/div><div>In case of the service code, which is Windows only, there are abo=
ut 30 uses of<br>BOOL but only a few cases of bool (typdef to int) all of w=
hich are in the deprecated<br>automatic service code. This patch changes th=
e latter to use stdbool which is<br>quite reasonable. But I just wonder whe=
ther its just better to use BOOL in<br>this occasion as the latter is not g=
oing to go away in Windows.<br></div><div><br></div><div>That said, I prefe=
r stdbool too, and I&#39;m fine with moving towards replacing all BOOL<br>w=
ith bool and casting to BOOL if/when required (say, calling Windows API).<b=
r><br></div></div><div class=3D"gmail_quote">Selva<br></div></div>

--00000000000029321405775592bd--

