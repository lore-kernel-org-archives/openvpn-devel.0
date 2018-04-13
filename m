MIME-Version: 1.0
In-Reply-To: <20180413185809.GS69387@...1296...>
References: <CAJ-EccN7eQsSaFn4MH4qRTKx+zZ-1YcGAe0XU8813p7k=W2i4g@...278...>
 <20180413185809.GS69387@...1296...>
From: Micah Morton <mortonm@...1913...>
Date: Fri, 13 Apr 2018 12:34:15 -0700
Message-ID: <CAJ-EccPw2JAMAvYuhbD5kqfuVzBj5B7SDYXhXAMHMbAA0X=HgA@...278...>
Content-Type: multipart/alternative; boundary="001a113a7eee1e891f0569bff55b"
Subject: Re: [Openvpn-devel] [PATCH] Specify platform and version on command
 line.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, jkbullard@...277...
Cc: openvpn-devel@lists.sourceforge.net

--001a113a7eee1e891f0569bff55b
Content-Type: text/plain; charset="UTF-8"

@gert:

From the help message: "--setenv name value : Set a custom environmental
variable to pass to script."

--setenv appears to set string values for scripts only, not for the main
openvpn process (which is reading them in the push_peer_info() function).
Starting a test openvpn server with `--setenv foo bar` and then running
`strings` on /proc/PID/environ doesn't show "foo=bar". This suggests that
getenv() calls in the main openvpn process that try to read these vars may
return NULL.

@jon:

the mods to options.c in the patch above should take care of the help
message (I tested it by running openvpn --help). Although good point if
this is going in I should update the man page as well.

On Fri, Apr 13, 2018 at 11:58 AM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Fri, Apr 13, 2018 at 10:23:03AM -0700, Micah Morton wrote:
> > From 557d2e73bf21ddb9d07b43f716c7914d610e7392 Mon Sep 17 00:00:00 2001
> > From: Micah Morton <mortonm@...1913...>
> > Date: Fri, 13 Apr 2018 09:55:22 -0700
> > Subject: [PATCH] Specify platform and version on command line.
> >
> > Add --iv-plat and --iv-plat-rel command line args, and use the values
> > passed to these args to set IV_PLAT and IV_PLAT_REL info that is pushed
> > to the server.
> >
> > IV_PLAT (platform type) is normally inferred from the build target, but
> > it would be useful to be able to override this from the command line
> > (e.g. for client to set platform as ChromeOS instead of Linux).
> >
> > IV_PLAT_REL (platform release version) would allow for pushing the
> > platform (e.g. ChromeOS) release version to the server.
>
> I'm actually less than enthusiastic about "yay, two more special-case
> options for OpenVPN" - and even less so to options that enable users
> to override a fairly well-defined meaning of IV_PLAT with an arbitrary
> string.  Even if it's ChromeOS, compiled with #define TARGET_LINUX,
> IV_PLAT should reflect that.
>
> There is already "--setenv UV_anykey=value" to send arbitrary strings
> to the server, and in particular, IV_PLAT_VER can already be set by
> "--setenv IV_PLAT_VER=<version>".
>
> There's one catch to this, though - for some reason that escapes me right
> now we have decided that IV_PLAT_VER= and the UV_ user-defined strings
> are only sent if --push-peer-info is also configured on the client
> (while IV_GUI_VER, also settable with --setenv, is always sent).
>
> So we might want to revisit that decision.
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

--001a113a7eee1e891f0569bff55b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><span style=3D"color:rgb(0,0,0);font-family:Roboto,-a=
pple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-se=
rif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI=
 Symbol&quot;;font-size:13px;font-style:normal;font-variant-ligatures:norma=
l;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align=
:start;text-indent:0px;text-transform:none;white-space:pre-wrap;word-spacin=
g:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-=
decoration-color:initial;float:none;display:inline">@gert:</span></div><div=
><span style=3D"color:rgb(0,0,0);font-family:Roboto,-apple-system,BlinkMacS=
ystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color=
 Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;;font-si=
ze:13px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:n=
ormal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0p=
x;text-transform:none;white-space:pre-wrap;word-spacing:0px;background-colo=
r:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:init=
ial;float:none;display:inline"><br></span></div><div><span style=3D"color:r=
gb(0,0,0);font-family:Roboto,-apple-system,BlinkMacSystemFont,&quot;Segoe U=
I&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Sego=
e UI Emoji&quot;,&quot;Segoe UI Symbol&quot;;font-size:13px;font-style:norm=
al;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
hite-space:pre-wrap;word-spacing:0px;background-color:rgb(255,255,255);text=
-decoration-style:initial;text-decoration-color:initial;float:none;display:=
inline">From the help message: &quot;--setenv name value : Set a custom env=
ironmental variable to pass to script.&quot;</span></div><span style=3D"col=
or:rgb(0,0,0);font-family:Roboto,-apple-system,BlinkMacSystemFont,&quot;Seg=
oe UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;=
Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;;font-size:13px;font-style:=
normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:4=
00;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:pre-wrap;word-spacing:0px;background-color:rgb(255,255,255);=
text-decoration-style:initial;text-decoration-color:initial;float:none;disp=
lay:inline"><div><span style=3D"color:rgb(0,0,0);font-family:Roboto,-apple-=
system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&=
quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symb=
ol&quot;;font-size:13px;font-style:normal;font-variant-ligatures:normal;fon=
t-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:star=
t;text-indent:0px;text-transform:none;white-space:pre-wrap;word-spacing:0px=
;background-color:rgb(255,255,255);text-decoration-style:initial;text-decor=
ation-color:initial;float:none;display:inline"><br></span></div>--setenv ap=
pears to set string values for scripts only, not for the main openvpn proce=
ss (which is reading them in the push_peer_info() function).  Starting a te=
st openvpn server with `--setenv foo bar` and then running `strings` on /pr=
oc/PID/environ doesn&#39;t show &quot;foo=3Dbar&quot;.  This suggests that =
getenv() calls in the main openvpn process that try to read these vars may =
return NULL.</span><br><div><span style=3D"color:rgb(0,0,0);font-family:Rob=
oto,-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,s=
ans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Se=
goe UI Symbol&quot;;font-size:13px;font-style:normal;font-variant-ligatures=
:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text=
-align:start;text-indent:0px;text-transform:none;white-space:pre-wrap;word-=
spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial=
;text-decoration-color:initial;float:none;display:inline"><br></span></div>=
<div><span style=3D"color:rgb(0,0,0);font-family:Roboto,-apple-system,Blink=
MacSystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple C=
olor Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;;fon=
t-size:13px;font-style:normal;font-variant-ligatures:normal;font-variant-ca=
ps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inden=
t:0px;text-transform:none;white-space:pre-wrap;word-spacing:0px;background-=
color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:=
initial;float:none;display:inline">@jon:</span></div><div><span style=3D"co=
lor:rgb(0,0,0);font-family:Roboto,-apple-system,BlinkMacSystemFont,&quot;Se=
goe UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot=
;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;;font-size:13px;font-style=
:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:=
400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:n=
one;white-space:pre-wrap;word-spacing:0px;background-color:rgb(255,255,255)=
;text-decoration-style:initial;text-decoration-color:initial;float:none;dis=
play:inline"><br></span></div><div><span style=3D"color:rgb(0,0,0);font-fam=
ily:Roboto,-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,=
Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&=
quot;Segoe UI Symbol&quot;;font-size:13px;font-style:normal;font-variant-li=
gatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norm=
al;text-align:start;text-indent:0px;text-transform:none;white-space:pre-wra=
p;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial;float:none;display:inline">the mods t=
o options.c in the patch above should take care of the help message (I test=
ed it by running openvpn --help). Although good point if this is going in I=
 should update the man page as well.</span></div></div><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote">On Fri, Apr 13, 2018 at 11:58 AM, Ger=
t Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">Hi,<br>
<span class=3D""><br>
On Fri, Apr 13, 2018 at 10:23:03AM -0700, Micah Morton wrote:<br>
&gt; From 557d2e73bf21ddb9d07b43f716c791<wbr>4d610e7392 Mon Sep 17 00:00:00=
 2001<br>
&gt; From: Micah Morton &lt;<a href=3D"mailto:mortonm@...1913...">mortonm@...220...=
..1913...</a>&gt;<br>
&gt; Date: Fri, 13 Apr 2018 09:55:22 -0700<br>
&gt; Subject: [PATCH] Specify platform and version on command line.<br>
&gt; <br>
&gt; Add --iv-plat and --iv-plat-rel command line args, and use the values<=
br>
&gt; passed to these args to set IV_PLAT and IV_PLAT_REL info that is pushe=
d<br>
&gt; to the server.<br>
&gt; <br>
&gt; IV_PLAT (platform type) is normally inferred from the build target, bu=
t<br>
&gt; it would be useful to be able to override this from the command line<b=
r>
&gt; (e.g. for client to set platform as ChromeOS instead of Linux).<br>
&gt; <br>
&gt; IV_PLAT_REL (platform release version) would allow for pushing the<br>
&gt; platform (e.g. ChromeOS) release version to the server.<br>
<br>
</span>I&#39;m actually less than enthusiastic about &quot;yay, two more sp=
ecial-case<br>
options for OpenVPN&quot; - and even less so to options that enable users<b=
r>
to override a fairly well-defined meaning of IV_PLAT with an arbitrary <br>
string.=C2=A0 Even if it&#39;s ChromeOS, compiled with #define TARGET_LINUX=
, <br>
IV_PLAT should reflect that.<br>
<br>
There is already &quot;--setenv UV_anykey=3Dvalue&quot; to send arbitrary s=
trings<br>
to the server, and in particular, IV_PLAT_VER can already be set by<br>
&quot;--setenv IV_PLAT_VER=3D&lt;version&gt;&quot;.<br>
<br>
There&#39;s one catch to this, though - for some reason that escapes me rig=
ht <br>
now we have decided that IV_PLAT_VER=3D and the UV_ user-defined strings <b=
r>
are only sent if --push-peer-info is also configured on the client<br>
(while IV_GUI_VER, also settable with --setenv, is always sent).<br>
<br>
So we might want to revisit that decision.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
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
o:gert@...1296...">gert@...1296...</a><br>
</font></span></blockquote></div><br></div>

--001a113a7eee1e891f0569bff55b--

