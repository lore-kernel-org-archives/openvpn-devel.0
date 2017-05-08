MIME-Version: 1.0
In-Reply-To: <2501c02c-8ab7-8826-628c-9385c1aa70b5@...2080...>
References: <20170505214624.11675-1-davids@...515...>
	<CAKuzo_hOntpCXhSUJFZk3QbKiVMLn87_t+2YAYcirLcX0z17SQ@...278...>
	<2501c02c-8ab7-8826-628c-9385c1aa70b5@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 8 May 2017 10:32:03 -0400
Message-ID: <CAKuzo_hrTp=ELrGpXbvd14HkXnoKpDntWO19+J2=zsgeXfqDBA@...278...>
Content-Type: multipart/alternative; boundary=001a1149b46a835dba054f041b7e
Subject: Re: [Openvpn-devel] [PATCH 1/2] plugin: Export base64 encode and
 decode functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1149b46a835dba054f041b7e
Content-Type: text/plain; charset=UTF-8

Hi,

Thanks for the follow up with details. I also put some further thought into
this overnight and totally agree with your observations. With one exception
:)

On Mon, May 8, 2017 at 9:56 AM, David Sommerseth <openvpn@...2142...
topphemmelig.net> wrote:

> I think it is a bit too risky to actually fix the plug-in API to fix
> this.  So we need to use (openvpn_plugin_handle_t *) in the v3 API.
>

We can fix it by removing the * without breaking the API. And I think that
is the right thing to do. In any case all working plugins that use v3 has
to be using handle (an not *handle) to store the context pointer and then
retrieving it as passed back in the func call.

A code that sets *handle = context_ptr is clearly wrong and would segfault
Any that sets handle = &context_ptr would get the wrong pointer back in
the func call so would not function properly.

So both those usages can be assumed not to exist.

So the only concern would be plugins which set handle =
(openvpn_plugin_handle_t *) context_ptr. That is only a cast issue and will
continue to compile and "work" even if the struct is changed to have
"openvpn_plugin_handle_t handle).


> I'll update the patch accordingly.
>

So I suggest to change the API to define handle in the return struct as
openvpn_plugin_handle_t without the *.  It also avoids giving the wrong
impression that one should set handle = &context_ptr in the _open_v3() call.

> [*] By the way, this being an example, it may be best to show the
> > correct type by casting the
> > return value of calloc to (openvpn_plugin_handle_t)
>
> Yes, but shouldn't it be `(openvpn_plugin_handle_t *)` ?
>

I assumed the fix would be to change the struct.

Thanks,

Selva

--001a1149b46a835dba054f041b7e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra">Thanks for the follow up with details. I also put some further=
 thought into this overnight and totally agree with your observations. With=
 one exception :)<br><br></div><div class=3D"gmail_extra"><div class=3D"gma=
il_quote">On Mon, May 8, 2017 at 9:56 AM, David Sommerseth <span dir=3D"ltr=
">&lt;<a href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2267...=
42...<wbr>topphemmelig.net</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div id=3D"m_1437483382290807461gmail-:4ho" clas=
s=3D"m_1437483382290807461gmail-a3s m_1437483382290807461gmail-aXjCH m_1437=
483382290807461gmail-m15be85928327a99a">I think it is a bit too risky to ac=
tually fix the plug-in API to fix<br>
this.=C2=A0 So we need to use (openvpn_plugin_handle_t *) in the v3 API.<br=
></div></blockquote><br>We can fix it by removing the * without breaking th=
e API. And I think that is the right thing to do. In any case all working p=
lugins that use v3 has to be using handle (an not *handle) to store the con=
text pointer and then retrieving it as passed back in the func call.<br><br=
>A code that sets *handle =3D context_ptr is clearly wrong and would segfau=
lt<br>Any that sets handle =3D &amp;context_ptr would get the wrong pointer=
 back in=C2=A0 the func call so would not function properly.<br><div><br></=
div><div>So both those usages can be assumed not to exist.<br><br></div><di=
v>So the only concern would be plugins which set handle =3D (openvpn_plugin=
_handle_t *) context_ptr. That is only a cast issue and will continue to co=
mpile and &quot;work&quot; even if the struct is changed to have &quot;open=
vpn_plugin_handle_t handle). <br></div><div><br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"><div id=3D"m_1437483382290807461gmail-:4ho" cl=
ass=3D"m_1437483382290807461gmail-a3s m_1437483382290807461gmail-aXjCH m_14=
37483382290807461gmail-m15be85928327a99a">
<br>
I&#39;ll update the patch accordingly.<br>
<span class=3D"m_1437483382290807461gmail-"></span></div></blockquote></div=
><br></div><div class=3D"gmail_extra">So I suggest to change the API to def=
ine handle in the return struct as openvpn_plugin_handle_t without the *.=
=C2=A0 It also avoids giving the wrong impression that one should set handl=
e =3D &amp;context_ptr in the _open_v3() call.<br><span class=3D"m_14374833=
82290807461gmail-im"><br></span><blockquote style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_=
quote"><span class=3D"m_1437483382290807461gmail-im">
&gt; [*] By the way, this being an example, it may be best to show the</spa=
n><br><span class=3D"m_1437483382290807461gmail-im">
&gt; correct type by casting the</span><br><span class=3D"m_143748338229080=
7461gmail-im">
&gt; return value of calloc to (openvpn_plugin_handle_t)</span><br><span cl=
ass=3D"m_1437483382290807461gmail-im">
</span><br><span class=3D"m_1437483382290807461gmail-im">
</span>Yes, but shouldn&#39;t it be `(openvpn_plugin_handle_t *)` ?<br></bl=
ockquote><div><br></div><div>I assumed the fix would be to change the struc=
t. <br></div><br></div><div class=3D"gmail_extra">Thanks,<br><br></div><div=
 class=3D"gmail_extra">Selva<br></div></div>

--001a1149b46a835dba054f041b7e--

