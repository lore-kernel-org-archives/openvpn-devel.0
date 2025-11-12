MIME-Version: 1.0
References: <CAOh3LPP9XVUU7TGHP51RdBEYSRKW1ih3EV_-FxiNxmiZCCS47g.ref@...278...>
 <CAOh3LPP9XVUU7TGHP51RdBEYSRKW1ih3EV_-FxiNxmiZCCS47g@...278...>
 <aQcXgtGRUKqadBPc@...1296...> <aRSa9JwiVksvEB6R@...1296...>
In-Reply-To: <aRSa9JwiVksvEB6R@...1296...>
From: Jon Chiappetta <root@...2904...>
Date: Wed, 12 Nov 2025 10:07:23 -0500
Message-ID: <CAOh3LPODhNo+x543G86UiPxWWhPbewvjc1bE+4xQhdRTT+fEVg@...278...>
Content-Type: multipart/alternative; boundary="000000000000c6479d0643671fce"
Subject: Re: [Openvpn-devel] Question for the devs - Found something
 interesting in the OpenVPN source code that I change in my modified
 version...
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

--000000000000c6479d0643671fce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yeah, looks pretty good, thanks for taking time to look it over! That if
statement should be able to catch the invalid index and goto error which
will then also help to protect and bypass the variable list index access
further down below on line number 3814 which was an additional access also!

Thanks again all,
Jon C


On Wed, Nov 12, 2025 at 9:34=E2=80=AFAM Gert Doering <gert@...1296...> wrot=
e:

> Hi,
>
> On Sun, Nov 02, 2025 at 09:34:10AM +0100, Gert Doering wrote:
> > > In my modified version I wasn't sure of when this hard reset check
> > > condition would be true but to prevent an invalid memory access I
> changed
> > > my code to be this instead:
> > >
> > > if (i =3D=3D TM_SIZE || is_hard_reset_method2(op))
> >
> > From my understanding of this code, this is the correct fix.
> >
> > Good find!
>
> As a followup to this - it's not the right fix, and my understanding was
> not sufficient.
>
> Arne understands the code better and has just moved the possibly-invalid
> pointer initialization a few lines down (to be committed in the next few
> minutes), after the check on "i" and error-exit.
>
> Thanks for your report!
>
> (There is another one which I'll look into "really soon now" :-) )
>
> gert
>
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

--000000000000c6479d0643671fce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div>Yeah, looks pretty good, thanks for taking time t=
o look it over! That if statement should be able to catch the invalid index=
 and goto error which will then also help to protect and bypass the variabl=
e list index access further down below on line=C2=A0number 3814 which was a=
n additional access also!=C2=A0</div><div><br></div><div>Thanks again all,<=
/div><div>Jon C</div><div><br></div></div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 12, 2=
025 at 9:34=E2=80=AFAM Gert Doering &lt;<a href=3D"mailto:gert@...1296...">=
gert@...1296...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:so=
lid;border-left-color:rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Sun, Nov 02, 2025 at 09:34:10AM +0100, Gert Doering wrote:<br>
&gt; &gt; In my modified version I wasn&#39;t sure of when this hard reset =
check<br>
&gt; &gt; condition would be true but to prevent an invalid memory access I=
 changed<br>
&gt; &gt; my code to be this instead:<br>
&gt; &gt; <br>
&gt; &gt; if (i =3D=3D TM_SIZE || is_hard_reset_method2(op))<br>
&gt; <br>
&gt; From my understanding of this code, this is the correct fix.<br>
&gt; <br>
&gt; Good find!<br>
<br>
As a followup to this - it&#39;s not the right fix, and my understanding wa=
s<br>
not sufficient.<br>
<br>
Arne understands the code better and has just moved the possibly-invalid<br>
pointer initialization a few lines down (to be committed in the next few<br>
minutes), after the check on &quot;i&quot; and error-exit.<br>
<br>
Thanks for your report!<br>
<br>
(There is another one which I&#39;ll look into &quot;really soon now&quot; =
:-) )<br>
<br>
gert<br>
<br>
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
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
</blockquote></div>

--000000000000c6479d0643671fce--

