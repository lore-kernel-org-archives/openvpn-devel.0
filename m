MIME-Version: 1.0
In-Reply-To: <20180413172940.GR69387@...1296...>
References: <CAAF3xa-+k10J4URGr+6zfua-p2KmoGUniejfBWDB7nNJ6p03kA@...278...>
 <20180413171009.GQ69387@...1296...>
 <CAAF3xa8wuk=+Mssvs1PuGvhPgBBPbe1W+dgLJxeO7GwYekQOdg@...278...>
 <20180413172940.GR69387@...1296...>
From: Marvin <volleynbike@...277...>
Date: Fri, 13 Apr 2018 10:50:14 -0700
Message-ID: <CAAF3xa_54X65rVn1sTAH33t-JPkTG0o0Y-d5ie9+a6=Jcc+Hbw@...278...>
Content-Type: multipart/alternative; boundary="f4f5e80e90602625460569be816f"
Subject: Re: [Openvpn-devel] Viscosity patch to TAP driver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "<openvpn-devel@lists.sourceforge.net>" <openvpn-devel@lists.sourceforge.net>

--f4f5e80e90602625460569be816f
Content-Type: text/plain; charset="UTF-8"

>> Note: active-ftp NAT will never be merged - that is way too intrusive.
Yes, we realize that.  That is why we didn't pursue acceptance any
further.  But we still require it because we have to support a large number
(currently around 3000) of legacy devices that cannot be changed away from
active-ftp and client-nat is required.  So for now, we are resigned to
running our own build.

>>  The other NAT patch got lost somewhere but still has chances.
Since we have to run our own build anyway, and no one seemed interested, we
didn't pursue this one.

Thanks for the answer re TAP-Win32, we will try it out as soon as the
binary is released.

Best,
Marvin


On Fri, Apr 13, 2018 at 10:29 AM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Fri, Apr 13, 2018 at 10:24:18AM -0700, Marvin wrote:
> > Only that here we need to run Gava's patches for active-ftp and
> client-nat
> > (submitted to openvpn-dev several years ago but not accepted).  He has
> not
> > had time to port those patches to 2.4.x yet.  So for now we are stuck at
> > 2.3.18.
>
> If you run your own build anyway, just package with the new driver as
> soon as it's released - as today, there will be a signed .exe for the
> tap driver, which gets embedded into whatever installer you build,
> 2.3.x or 2.4.x
>
> (Note: active-ftp NAT will never be merged - that is way too intrusive.
> The other NAT patch got lost somewhere but still has chances)
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

--f4f5e80e90602625460569be816f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt;&gt;
<span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:1=
2.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:nor=
mal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;=
text-transform:none;white-space:normal;word-spacing:0px;background-color:rg=
b(255,255,255);text-decoration-style:initial;text-decoration-color:initial;=
float:none;display:inline">Note: active-ftp NAT will never be merged - that=
 is way too intrusive.</span>

<div><span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-s=
ize:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-cap=
s:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;white-space:normal;word-spacing:0px;background-col=
or:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:ini=
tial;float:none;display:inline">Yes, we realize that.=C2=A0 That is why we =
didn&#39;t pursue acceptance any further.=C2=A0 But we still require it bec=
ause we have to support a large number (currently around 3000) of legacy de=
vices that cannot be changed away from active-ftp and client-nat is require=
d.=C2=A0 So for now, we are resigned to running our own build.</span></div>=
<div><span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-s=
ize:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-cap=
s:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;white-space:normal;word-spacing:0px;background-col=
or:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:ini=
tial;float:none;display:inline"><br></span></div><div><span style=3D"color:=
rgb(34,34,34);font-family:arial,sans-serif;font-size:12.8px;font-style:norm=
al;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
hite-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-d=
ecoration-style:initial;text-decoration-color:initial;float:none;display:in=
line">&gt;&gt;=C2=A0

<span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:1=
2.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:nor=
mal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;=
text-transform:none;white-space:normal;word-spacing:0px;background-color:rg=
b(255,255,255);text-decoration-style:initial;text-decoration-color:initial;=
float:none;display:inline">The other NAT patch got lost somewhere but still=
 has chances.</span></span></div><div><span style=3D"color:rgb(34,34,34);fo=
nt-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-=
ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;white-space:norma=
l;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial;float:none;display:inline"><span styl=
e=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12.8px;font=
-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-w=
eight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-trans=
form:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,=
255);text-decoration-style:initial;text-decoration-color:initial;float:none=
;display:inline">Since we have to run our own build anyway, and no one seem=
ed interested, we didn&#39;t pursue this one.</span></span></div><div><span=
 style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12.8px=
;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;f=
ont-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;white-space:normal;word-spacing:0px;background-color:rgb(255=
,255,255);text-decoration-style:initial;text-decoration-color:initial;float=
:none;display:inline"><span style=3D"color:rgb(34,34,34);font-family:arial,=
sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal=
;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:=
start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0=
px;background-color:rgb(255,255,255);text-decoration-style:initial;text-dec=
oration-color:initial;float:none;display:inline"><br></span></span></div><d=
iv><span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-siz=
e:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:=
normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0=
px;text-transform:none;white-space:normal;word-spacing:0px;background-color=
:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initi=
al;float:none;display:inline"><span style=3D"color:rgb(34,34,34);font-famil=
y:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligature=
s:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;=
text-decoration-color:initial;float:none;display:inline">Thanks for the ans=
wer re TAP-Win32, we will try it out as soon as the binary is released.</sp=
an></span></div><div><span style=3D"color:rgb(34,34,34);font-family:arial,s=
ans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;=
font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0p=
x;background-color:rgb(255,255,255);text-decoration-style:initial;text-deco=
ration-color:initial;float:none;display:inline"><span style=3D"color:rgb(34=
,34,34);font-family:arial,sans-serif;font-size:12.8px;font-style:normal;fon=
t-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-s=
pace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorat=
ion-style:initial;text-decoration-color:initial;float:none;display:inline">=
<br></span></span></div><div><span style=3D"color:rgb(34,34,34);font-family=
:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures=
:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text=
-align:start;text-indent:0px;text-transform:none;white-space:normal;word-sp=
acing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;t=
ext-decoration-color:initial;float:none;display:inline"><span style=3D"colo=
r:rgb(34,34,34);font-family:arial,sans-serif;font-size:12.8px;font-style:no=
rmal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400=
;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none=
;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text=
-decoration-style:initial;text-decoration-color:initial;float:none;display:=
inline">Best,</span></span></div><div><span style=3D"color:rgb(34,34,34);fo=
nt-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-=
ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;white-space:norma=
l;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial;float:none;display:inline"><span styl=
e=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12.8px;font=
-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-w=
eight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-trans=
form:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,=
255);text-decoration-style:initial;text-decoration-color:initial;float:none=
;display:inline">Marvin</span></span></div><div><span style=3D"color:rgb(34=
,34,34);font-family:arial,sans-serif;font-size:12.8px;font-style:normal;fon=
t-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-s=
pace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorat=
ion-style:initial;text-decoration-color:initial;float:none;display:inline">=
<span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:1=
2.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:nor=
mal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;=
text-transform:none;white-space:normal;word-spacing:0px;background-color:rg=
b(255,255,255);text-decoration-style:initial;text-decoration-color:initial;=
float:none;display:inline"><br></span></span></div><div class=3D"gmail_extr=
a"><br><div class=3D"gmail_quote">On Fri, Apr 13, 2018 at 10:29 AM, Gert Do=
ering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_b=
lank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">Hi,<br>
<span class=3D""><br>
On Fri, Apr 13, 2018 at 10:24:18AM -0700, Marvin wrote:<br>
&gt; Only that here we need to run Gava&#39;s patches for active-ftp and cl=
ient-nat<br>
&gt; (submitted to openvpn-dev several years ago but not accepted).=C2=A0 H=
e has not<br>
&gt; had time to port those patches to 2.4.x yet.=C2=A0 So for now we are s=
tuck at<br>
&gt; 2.3.18.<br>
<br>
</span>If you run your own build anyway, just package with the new driver a=
s<br>
soon as it&#39;s released - as today, there will be a signed .exe for the<b=
r>
tap driver, which gets embedded into whatever installer you build,<br>
2.3.x or 2.4.x<br>
<br>
(Note: active-ftp NAT will never be merged - that is way too intrusive.<br>
The other NAT patch got lost somewhere but still has chances)<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
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
o:gert@...1296...">gert@...1296...</a><br>
</div></div></blockquote></div><br></div></div>

--f4f5e80e90602625460569be816f--

