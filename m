MIME-Version: 1.0
In-Reply-To: <CAA1Abx+1GQKipc1O1D2BXjDgrtDAFTa5GB2GUZKrT+-J-QsuNA@...278...>
References: <1474712639-11698-1-git-send-email-lstipakov@...277...>
	<CAA1Abx+1GQKipc1O1D2BXjDgrtDAFTa5GB2GUZKrT+-J-QsuNA@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Sat, 1 Oct 2016 16:30:08 +0300
Message-ID: <CAGyAFMXSQv=K16Ki7g2g4HLfBDb91E_TzpO4A5c71ZLDg6-Dcw@...278...>
Content-Type: multipart/alternative; boundary=089e0102ddaeaf91f6053dcdb537
Subject: Re: [Openvpn-devel] [PATCH] Fix duplicated PUSH_REPLY options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e0102ddaeaf91f6053dcdb537
Content-Type: text/plain; charset=UTF-8

Hi,

ACK from me - tested that peer-id and cipher are not duplicated in
PUSH_REPLY when client reconnects and push-continuation works.

-Lev

2016-09-29 20:49 GMT+03:00 Steffan Karger <steffan@...1856...>:

> Hi,
>
> On 24 September 2016 at 12:23, Lev Stipakov <lstipakov@...277...> wrote:
> > Starting from https://github.com/OpenVPN/openvpn/commit/
> 3a5a46cf2b7f6a8b8520c2513a8054deb48bfcbe,
> > we add peer-id and cipher values to context->options->push_list instead
> of adding those directly
> > to buf (as done for client-specific values, like ifconfig). Since
> push_list is per child context,
> > when options are added and context is reused - we got duplicates.
> >
> > Fixed by adding options to buffer, as it was done previously.
>
> NAK.  This reintroduces another issue, where the added options might
> not fit into buf, because we can't reserve space for variable-sized
> options (peer-id would be possible, by cipher would already be
> trickier).
>
> This is a bug though (sorry!), so attached a different proposal to fix
> this.  I didn't test this yet (need to leave now), but lev just
> announced on IRC that he was willing to test it.
>
> -Steffan
>



-- 
-Lev

--089e0102ddaeaf91f6053dcdb537
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>ACK from me - tested that peer-id a=
nd cipher are not duplicated in PUSH_REPLY when client reconnects and push-=
continuation works.=C2=A0</div><div><br></div><div>-Lev</div></div><div cla=
ss=3D"gmail_extra"><br><div class=3D"gmail_quote">2016-09-29 20:49 GMT+03:0=
0 Steffan Karger <span dir=3D"ltr">&lt;<a href=3D"mailto:steffan@...1856...=
" target=3D"_blank">steffan@...1856...</a>&gt;</span>:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Hi,<br>
<span class=3D""><br>
On 24 September 2016 at 12:23, Lev Stipakov &lt;<a href=3D"mailto:lstipakov=
@...277...">lstipakov@...277...</a>&gt; wrote:<br>
&gt; Starting from <a href=3D"https://github.com/OpenVPN/openvpn/commit/3a5=
a46cf2b7f6a8b8520c2513a8054deb48bfcbe" rel=3D"noreferrer" target=3D"_blank"=
>https://github.com/OpenVPN/<wbr>openvpn/commit/<wbr>3a5a46cf2b7f6a8b8520c2=
513a8054<wbr>deb48bfcbe</a>,<br>
&gt; we add peer-id and cipher values to context-&gt;options-&gt;push_list =
instead of adding those directly<br>
&gt; to buf (as done for client-specific values, like ifconfig). Since push=
_list is per child context,<br>
&gt; when options are added and context is reused - we got duplicates.<br>
&gt;<br>
&gt; Fixed by adding options to buffer, as it was done previously.<br>
<br>
</span>NAK.=C2=A0 This reintroduces another issue, where the added options =
might<br>
not fit into buf, because we can&#39;t reserve space for variable-sized<br>
options (peer-id would be possible, by cipher would already be<br>
trickier).<br>
<br>
This is a bug though (sorry!), so attached a different proposal to fix<br>
this.=C2=A0 I didn&#39;t test this yet (need to leave now), but lev just<br>
announced on IRC that he was willing to test it.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Steffan<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature">-Lev</d=
iv>
</div>

--089e0102ddaeaf91f6053dcdb537--

