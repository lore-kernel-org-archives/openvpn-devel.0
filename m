MIME-Version: 1.0
In-Reply-To: <20160522072623.GU53051@...1296...>
References: <CAKuzo_g1jx2JkxP2BSVYPW4axnMUQgVe=WvBSzC+x8n6LR_A9g@...278...>
	<1463892387-4793-1-git-send-email-selva.nair@...277...>
	<20160522072623.GU53051@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 22 May 2016 10:06:52 -0400
Message-ID: <CAKuzo_i8F7P7GC6oHr-ghsko_xpa9w9xG_ZPxLuL2KKnY2jASw@...278...>
Content-Type: multipart/alternative; boundary=001a11448a9e17c2c105336ed75d
Subject: Re: [Openvpn-devel] [PATCH] Fix handling of out of memory error in
 interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11448a9e17c2c105336ed75d
Content-Type: text/plain; charset=UTF-8

Hi,

Thanks for the comments.

On Sun, May 22, 2016 at 3:26 AM, Gert Doering <gert@...1296...> wrote:

> thanks for digging into this.  Overall, the patch makes sense, I'm just
> wondering about this:
>
> On Sun, May 22, 2016 at 12:46:27AM -0400, Selva Nair wrote:
> > Other changes:
> > - Use minimal initial allocation size so that the realloc code path
> >   gets exercised (2 or more connections will cause realloc).
>
> I can see that this is useful for testing, but do we want this in
> production?
>
> It won't make a difference for most usages ("only one connection active"),
> but then, the extra memory use for 10 is minimal, and realloc() *can* fail,
> so just keeping at 10 won't need the realloc() path generally...
>
>

Of course, the extra memory usage is not a concern.  As a  general practice
I like malloc/realloc for growing arrays to start from the smallest
possible value to expose bugs in the logic during normal use[*].

That said, I'm ok with reverting it back to 10  or even a somewhat larger
value -- I understand the "in case the fix is buggy, be sure it doesn't
break anything" kind of feeling.

Selva

[*] See similar advice in "The Practice of Programming", section on growing
arrays..

--001a11448a9e17c2c105336ed75d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra">Thanks for the comments.<br><br></div><div class=3D"gmail_extr=
a"><div class=3D"gmail_quote">On Sun, May 22, 2016 at 3:26 AM, Gert Doering=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank"=
>gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex"><div>thanks for digging into this.=C2=A0 Overall, the patc=
h makes sense, I&#39;m just<br>
wondering about this:<br>
<span class=3D""><br>
On Sun, May 22, 2016 at 12:46:27AM -0400, Selva Nair wrote:<br>
&gt; Other changes:<br>
&gt; - Use minimal initial allocation size so that the realloc code path<br>
&gt;=C2=A0 =C2=A0gets exercised (2 or more connections will cause realloc).=
<br>
<br>
</span>I can see that this is useful for testing, but do we want this in pr=
oduction?<br>
<br>
It won&#39;t make a difference for most usages (&quot;only one connection a=
ctive&quot;),<br>
but then, the extra memory use for 10 is minimal, and realloc() *can* fail,=
<br>
so just keeping at 10 won&#39;t need the realloc() path generally...<br>=C2=
=A0 <br></div></blockquote><br></div><div class=3D"gmail_extra">Of course, =
the extra memory usage is not a concern.=C2=A0 As a=C2=A0 general practice =
I like malloc/realloc for growing arrays to start from the smallest possibl=
e value to expose bugs in the logic during normal use[*].<br><br></div></di=
v><div class=3D"gmail_extra">That said, I&#39;m ok with reverting it back t=
o 10=C2=A0 or even a somewhat larger value -- I understand the &quot;in cas=
e the fix is buggy, be sure it doesn&#39;t break anything&quot; kind of fee=
ling.<br><br></div><div class=3D"gmail_extra">Selva<br><br>[*] See similar =
advice in &quot;The Practice of Programming&quot;, section on growing array=
s..<br></div></div>

--001a11448a9e17c2c105336ed75d--

