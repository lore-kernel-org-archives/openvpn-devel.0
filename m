MIME-Version: 1.0
References: <20230201041831.2259419-1-selva.nair@...277...>
 <CAGyAFMVw=QzQDaBo6RE9Juh5+SObuCmAptT+yh1X44DL2g7bBQ@...278...>
In-Reply-To: <CAGyAFMVw=QzQDaBo6RE9Juh5+SObuCmAptT+yh1X44DL2g7bBQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 1 Feb 2023 10:29:31 -0500
Message-ID: <CAKuzo_jAfKrpRpi2YHRwwXSGVz_NSy8gYwybLajFt4ZJyJ=MVg@...278...>
Content-Type: multipart/alternative; boundary="0000000000004d2e5505f3a51eb5"
Subject: Re: [Openvpn-devel] [PATCH] block-dns using iservice: fix a
 potential double free
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--0000000000004d2e5505f3a51eb5
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Feb 1, 2023 at 4:37 AM Lev Stipakov <lstipakov@...277...> wrote:

> Hi,
>
> I made a slightly different fix but then noticed your mail.
>
> Indeed the problem is that get/set_interface_metric fails,
> and we call FwpmEngineClose0 after updating the undo list. When
> openvpn process exits, we execute commands in undo list,
> and second call to FwpmEngineClose0 causes Access Violation
> inside WFP.
>
> Note that since get_interface_metric() fails, it sets
> interface_data->metric_v4
> to -1. In this case we should not restore metrics back (which will
> fail in any case).
> We have a very similar code (including metrics value check) just below
> which
> handles msg_del_block_dns. Can we factor it out into a separate function?
>

Good point.  I have a version that splits "add" and "delete" actions into
separate functions and does something like this.

Please take a look here:
https://github.com/selvanair/openvpn/tree/block-dns-fix
The add and delete functions are in that order (with a forward declaration)
only to make review easier (less changes with ignore-all-spaces), will move
the latter up if it looks okay.

That said, if you have a better fix, I'm ready to review it in lieu of this.

Thanks,

Selva

--0000000000004d2e5505f3a51eb5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 1, 2023 at 4:37 AM Le=
v Stipakov &lt;<a href=3D"mailto:lstipakov@...277...">lstipakov@...277...</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi=
,<br>
<br>
I made a slightly different fix but then noticed your mail.<br>
<br>
Indeed the problem is that get/set_interface_metric fails,<br>
and we call FwpmEngineClose0 after updating the undo list. When<br>
openvpn process exits, we execute commands in undo list,<br>
and second call to FwpmEngineClose0 causes Access Violation<br>
inside WFP.<br>
<br>
Note that since get_interface_metric() fails, it sets interface_data-&gt;me=
tric_v4<br>
to -1. In this case we should not restore metrics back (which will<br>
fail in any case).<br>
We have a very similar code (including metrics value check) just below whic=
h<br>
handles msg_del_block_dns. Can we factor it out into a separate function?<b=
r></blockquote><div><br></div><div>Good point.=C2=A0 I have a version that =
splits &quot;add&quot; and &quot;delete&quot; actions into separate functio=
ns and does something like this.</div><div><br></div><div>Please take a loo=
k here:=C2=A0<a href=3D"https://github.com/selvanair/openvpn/tree/block-dns=
-fix">https://github.com/selvanair/openvpn/tree/block-dns-fix</a>=C2=A0</di=
v><div>The add and delete functions are in that order (with a forward decla=
ration) only to make review easier (less changes with ignore-all-spaces), w=
ill move the latter up if it looks okay.</div><div><br></div><div>That said=
, if you have a better fix, I&#39;m ready to review it in lieu of this.</di=
v><div><br></div><div>Thanks,</div><div><br></div><div>Selva</div></div></d=
iv></div>

--0000000000004d2e5505f3a51eb5--

