MIME-Version: 1.0
References: <20220728034508.15180-2-selva.nair@...277...>
 <202208021202.272C2dmm071125@...2054...>
In-Reply-To: <202208021202.272C2dmm071125@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 11 Aug 2022 16:03:48 -0400
Message-ID: <CAKuzo_hzrRRnakFZ7C00yAfeZJ387GT3xa7KXhGf1pTK1G6Vwg@...278...>
Content-Type: multipart/alternative; boundary="000000000000f2843505e5fcae2d"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Allow a few levels of
 recursion in virtual_output_callback()
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

--000000000000f2843505e5fcae2d
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Aug 2, 2022 at 8:02 AM Gert Doering <gert@...1296...> wrote:

> Acked-by: Gert Doering <gert@...1296...>
>
> I cannot test this (beyond "compile", but that is trivial) but the
> description in
>
>
> https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24738.html
>
> makes sense, so allowing "a limited amount" of recursion plus actually
> logging when this is hit should make management more robust against
> overlapping timing issues aka "race conditions".
>
> Your patch has been applied to the master branch.
>

Can we also apply this to 2.5? I see this trigerred easily with the new
persistent connection / PLAP support. I haven't figured the exact reason
but hitting reconnect or disconnect at certain instances triggers this --
like when the connection is almost complete and the daemon is doing
slow-ish netsh commands. The same code-path is not traversed when
interactive service is in use and it seems hitting the "race condition" is
much harder in that case.

Otherwise we have to limit these new GUI features to 2.6 which  would
require a new branch in the GUI and some changes to the build process.

In some sense this is a "bug fix" though the fix itself is a band-aid as
opposed to implementing a command queue to save these write actions instead
of dropping them.

Selva

--000000000000f2843505e5fcae2d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, Aug 2, 2022 at 8:02 AM Gert Doering &lt;<a=
 href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Acked-by: Gert Doering &lt;=
<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt=
;<br>
<br>
I cannot test this (beyond &quot;compile&quot;, but that is trivial) but th=
e<br>
description in <br>
<br>
=C2=A0<a href=3D"https://www.mail-archive.com/openvpn-devel@...1768...=
ge.net/msg24738.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail=
-archive.com/openvpn-devel@lists.sourceforge.net/msg24738.html</a><br>
<br>
makes sense, so allowing &quot;a limited amount&quot; of recursion plus act=
ually<br>
logging when this is hit should make management more robust against <br>
overlapping timing issues aka &quot;race conditions&quot;.<br>
<br>
Your patch has been applied to the master branch.<br></blockquote><div><br>=
</div><div>Can we also apply this to 2.5? I see this trigerred=C2=A0easily =
with the new persistent connection / PLAP support. I haven&#39;t figured th=
e exact reason but hitting reconnect or disconnect at certain instances tri=
ggers this -- like when the connection is almost complete and the daemon is=
 doing slow-ish netsh commands. The same code-path is not traversed when in=
teractive service is in use and it seems hitting the &quot;race condition&q=
uot; is much harder in that case.</div><div><br></div><div>Otherwise we hav=
e to limit these new GUI features to 2.6 which=C2=A0 would require a new br=
anch in the GUI and some changes to the build process.</div><div><br></div>=
<div>In some sense this is a &quot;bug fix&quot; though the fix itself is a=
 band-aid as opposed to implementing a command queue to save these write ac=
tions instead of dropping them.</div><div><br></div><div>Selva</div></div><=
/div>

--000000000000f2843505e5fcae2d--

