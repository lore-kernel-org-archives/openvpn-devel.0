MIME-Version: 1.0
In-Reply-To: <20170915153547.GL70062@...1296...>
References: <CABMULtJc_dvbLPwmVTP9Y4+Y6bGPnCT+nmCjk38fDQC4OaK9Uw@...278...>
 <20170915153547.GL70062@...1296...>
From: Alex K <rightkicktech@...277...>
Date: Fri, 15 Sep 2017 19:39:30 +0300
Message-ID: <CABMULtLsv8DrHEfeyOrUvvGzjYuAKW4jA6UnUs4V4QyDa-eDRQ@...278...>
Content-Type: multipart/alternative; boundary="001a114449d08f494b05593d0906"
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN per client cipher
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>, openvpn-devel@lists.sourceforge.net

--001a114449d08f494b05593d0906
Content-Type: text/plain; charset="UTF-8"

Thanx Gert.
Just put --ncp-disable on client side and server seems to respect the
cipher defined on ccd.

I will be following up on devel for such type of issues.

Thanx,
Alex

On Fri, Sep 15, 2017 at 6:35 PM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> (taking this over to openvpn-devel, as this is not so much a "user"
> question if it concerns ongoing development patches :) )
>
> On Fri, Sep 15, 2017 at 06:04:27PM +0300, Alex K wrote:
> > I built openvpn 2.4.3-1 on server using patch also to allow for per
> client
> > cipher through ccd file.
> > I took the patch from https://community.openvpn.net/openvpn/ticket/845.
> [..]
> > When connecting with clients having the same openvpn version as the
> server
> > (2.4.3-1) and using the same configs, it seems that the server ignores
> the
> > "cipher none" at ccd file and logs the following:
>
> Seems NCP ("per-client cipher negotiation") trumps ccd/ here.
>
> If you configure "--disable-ncp" on the client side, it should work.
>
> [..]
> > Is there something that is causing this behavior?
>
> Cipher negotiation :-)
>
> Thanks for testing the per-client ccd cipher patch - this is definitely
> useful.  Interaction with NCP needs a bit more thought, it seems.
>
> gert
>
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025                        gert@...1816...
> muenchen.de
>

--001a114449d08f494b05593d0906
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Thanx Gert. <br></div>Just put --ncp-disable on =
client side and server seems to respect the cipher defined on ccd. <br><br>=
</div>I will be following up on devel for such type of issues. <br><div><br=
></div><div>Thanx, <br>Alex<br></div></div><div class=3D"gmail_extra"><br><=
div class=3D"gmail_quote">On Fri, Sep 15, 2017 at 6:35 PM, Gert Doering <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">ger=
t@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
(taking this over to openvpn-devel, as this is not so much a &quot;user&quo=
t;<br>
question if it concerns ongoing development patches :) )<br>
<span class=3D""><br>
On Fri, Sep 15, 2017 at 06:04:27PM +0300, Alex K wrote:<br>
&gt; I built openvpn 2.4.3-1 on server using patch also to allow for per cl=
ient<br>
&gt; cipher through ccd file.<br>
&gt; I took the patch from <a href=3D"https://community.openvpn.net/openvpn=
/ticket/845" rel=3D"noreferrer" target=3D"_blank">https://community.openvpn=
.net/<wbr>openvpn/ticket/845</a>.<br>
</span>[..]<br>
<span class=3D"">&gt; When connecting with clients having the same openvpn =
version as the server<br>
&gt; (2.4.3-1) and using the same configs, it seems that the server ignores=
 the<br>
&gt; &quot;cipher none&quot; at ccd file and logs the following:<br>
<br>
</span>Seems NCP (&quot;per-client cipher negotiation&quot;) trumps ccd/ he=
re.<br>
<br>
If you configure &quot;--disable-ncp&quot; on the client side, it should wo=
rk.<br>
<br>
[..]<br>
<span class=3D"">&gt; Is there something that is causing this behavior?<br>
<br>
</span>Cipher negotiation :-)<br>
<br>
Thanks for testing the per-client ccd cipher patch - this is definitely<br>
useful.=C2=A0 Interaction with NCP needs a bit more thought, it seems.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
gert<br>
<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<a href=3D"=
http://www.muc.de/~gert/" rel=3D"noreferrer" target=3D"_blank">www.muc.de/~=
gert/</a><br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296...">gert@...1296...</a><br>
fax: <a href=3D"tel:%2B49-89-35655025" value=3D"+498935655025">+49-89-35655=
025</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...1816...<wbr>mu=
enchen.de</a><br>
</font></span></blockquote></div><br></div>

--001a114449d08f494b05593d0906--

