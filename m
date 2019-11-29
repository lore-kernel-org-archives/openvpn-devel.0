MIME-Version: 1.0
References: <20191128080631.117-1-lstipakov@...277...>
 <E1iaLck-0000Aj-5c@...2508...>
 <CAKuzo_jR6WYsM9QZhdyp8sW6avFGhDnFzx_dNN63JD4iiSmFag@...278...>
 <20191128194320.GM40538@...1296...>
In-Reply-To: <20191128194320.GM40538@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 29 Nov 2019 12:48:43 +0200
Message-ID: <CAGyAFMUvNqJ1bxnDt7s9A944+FZMjNfrfqKXx0a8Cc-RafEwVg@...278...>
Content-Type: multipart/alternative; boundary="000000000000efcecf059879f909"
Subject: Re: [Openvpn-devel] [PATCH] fix clang warning about missing braces
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000efcecf059879f909
Content-Type: text/plain; charset="UTF-8"

I upgraded clang to 9.0 and warning disappeared.

https://travis-ci.org/lstipakov/openvpn/builds/618527918

Patch is on the list.

to 28. marrask. 2019 klo 21.44 Gert Doering (gert@...1296...) kirjoitti:

> hi,
>
> On Thu, Nov 28, 2019 at 11:56:34AM -0500, Selva Nair wrote:
> > I think the correct fix here is to remove -Werror from travis build.
> > I have tried and failed to lobby for this earlier, but one more try
> > can't hurt, I suppose :)
>
> Can we restrict -Werror to gcc builds, for the time being?
>
> If not, I agree with you, and it needs to go...
>
> Valid (and unambiguous) C statements shouldn't cause warnings, and we
> shouldn't add patches just because an old version of a certain compiler
> is silly.
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
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


-- 
-Lev

--000000000000efcecf059879f909
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I upgraded clang to 9.0 and=C2=A0warning disappeared.<div>=
<br></div><div><a href=3D"https://travis-ci.org/lstipakov/openvpn/builds/61=
8527918">https://travis-ci.org/lstipakov/openvpn/builds/618527918</a>=C2=A0=
</div><div><br></div><div>Patch is on the list.=C2=A0<br></div></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">to 28. marra=
sk. 2019 klo 21.44 Gert Doering (<a href=3D"mailto:gert@...1296...">gert@...1186...=
.1296...</a>) kirjoitti:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">hi,<br>
<br>
On Thu, Nov 28, 2019 at 11:56:34AM -0500, Selva Nair wrote:<br>
&gt; I think the correct fix here is to remove -Werror from travis build.<b=
r>
&gt; I have tried and failed to lobby for this earlier, but one more try<br>
&gt; can&#39;t hurt, I suppose :)<br>
<br>
Can we restrict -Werror to gcc builds, for the time being?<br>
<br>
If not, I agree with you, and it needs to go...<br>
<br>
Valid (and unambiguous) C statements shouldn&#39;t cause warnings, and we<b=
r>
shouldn&#39;t add patches just because an old version of a certain compiler=
<br>
is silly.<br>
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
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div>

--000000000000efcecf059879f909--

