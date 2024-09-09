MIME-Version: 1.0
References: <20240708210912.566-1-chipitsine@...277...>
 <20240708210912.566-4-chipitsine@...277...>
 <Zt6j-5lWDxlhAglc@...1296...>
In-Reply-To: <Zt6j-5lWDxlhAglc@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 9 Sep 2024 14:51:44 +0200
Message-ID: <CAFHpkQFBmwTzETHCcgzspkX3XNQ_FKQ5LmJ+N=46-KrWHA6TCQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000d93f3f0621af381a"
Subject: Re: [Openvpn-devel] [PATCH 3/5] src/openvpn/auth_token.c: handle
 strdup errors
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000d93f3f0621af381a
Content-Type: text/plain; charset="UTF-8"

I'll have a look, thanks!

On Mon, Sep 9, 2024, 09:30 Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Mon, Jul 08, 2024 at 11:08:20PM +0200, Ilia Shipitsin wrote:
> >      multi->auth_token = strdup((char *)BPTR(&session_token));
> > +    if (!multi->auth_token)
> > +    {
> > +        msg( M_FATAL, "Failed allocate memory for multi->auth_token");
> > +    }
>
> I do wonder if this is the right approach here.  For "openvpn itself"
> we have the check_malloc_return() macro, which will purposely not call
> msg() - as msg() does internal malloc()s, and if we cannot allocate
> 20 bytes for an auth_token, the chance that msg() will not succeed is
> fairly high...
>
> In plugins or unit tests, the infrastructure is different, but for 3/ and
> 4/, please resend with
>
>       multi->auth_token = strdup((char *)BPTR(&session_token));
>  +    check_malloc_return(multi->auth_token);
>
> (etc)
>
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never
> doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>
> Gert Doering - Munich, Germany
> gert@...1296...
>

--000000000000d93f3f0621af381a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I&#39;ll have a look, thanks!</div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 9, 2024, 09:30 G=
ert Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
On Mon, Jul 08, 2024 at 11:08:20PM +0200, Ilia Shipitsin wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 multi-&gt;auth_token =3D strdup((char *)BPTR(&amp;=
session_token));<br>
&gt; +=C2=A0 =C2=A0 if (!multi-&gt;auth_token)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg( M_FATAL, &quot;Failed allocate memor=
y for multi-&gt;auth_token&quot;);<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
I do wonder if this is the right approach here.=C2=A0 For &quot;openvpn its=
elf&quot;<br>
we have the check_malloc_return() macro, which will purposely not call<br>
msg() - as msg() does internal malloc()s, and if we cannot allocate<br>
20 bytes for an auth_token, the chance that msg() will not succeed is<br>
fairly high...<br>
<br>
In plugins or unit tests, the infrastructure is different, but for 3/ and<b=
r>
4/, please resend with<br>
<br>
=C2=A0 =C2=A0 =C2=A0 multi-&gt;auth_token =3D strdup((char *)BPTR(&amp;sess=
ion_token));<br>
=C2=A0+=C2=A0 =C2=A0 check_malloc_return(multi-&gt;auth_token);<br>
<br>
(etc)<br>
<br>
gert<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank" rel=3D"noreferrer">gert@...1296...</a>=
<br>
</blockquote></div>

--000000000000d93f3f0621af381a--

