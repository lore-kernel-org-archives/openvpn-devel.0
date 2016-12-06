MIME-Version: 1.0
In-Reply-To: <20161206203324.GM78624@...1296...>
References: <1480707729-19578-1-git-send-email-selva.nair@...277...>
	<20161206203324.GM78624@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 6 Dec 2016 17:37:15 -0500
Message-ID: <CAKuzo_hvXg5HWrgc1Gd++iZwtTf2aekKDuc1KHufZ+HXZ66znw@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0438e000706f0543050da9
Subject: Re: [Openvpn-devel] [PATCH] Correctly state the default dhcp server
 address in man page
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

--94eb2c0438e000706f0543050da9
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue, Dec 6, 2016 at 3:33 PM, Gert Doering <gert@...1296...> wrote:

> I'm going to merge your documentation patch now, for 2.4.0 and 2.3.14,
> but for git master we should revisit this piece of <deleted>, get rid of
> "dhcp_masq_custom_offset" *and* make it default to 0 for both tun
> and tap...  (since there is no difference that the windows side of things
> can see, if .0 works in tap mode, I can't see a reason why it would not
> work in windows' "tun" mode).
>

Yes, it does work in tun mode (easy to test just use offset 0 on command
line)

I had posted a patch ( a year ago?) which sets the offset to 0. I did not
remove the offset variable though it makes sense to get rid of it... Anyway
the patch never got any attention :)

Thanks,

Selva

--94eb2c0438e000706f0543050da9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Tue, Dec 6, 2016 at 3:33 PM, Gert Do=
ering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_b=
lank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x"><div id=3D":2h9" class=3D"a3s aXjCH m158d5d74e5bf2c14">I&#39;m going to =
merge your documentation patch now, for 2.4.0 and 2.3.14,<br>
but for git master we should revisit this piece of &lt;deleted&gt;, get rid=
 of<br>
&quot;dhcp_masq_custom_offset&quot; *and* make it default to 0 for both tun=
<br>
and tap...=C2=A0 (since there is no difference that the windows side of thi=
ngs<br>
can see, if .0 works in tap mode, I can&#39;t see a reason why it would not=
<br>
work in windows&#39; &quot;tun&quot; mode).</div></blockquote></div><div cl=
ass=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Yes, it does work =
in tun mode (easy to test just use offset 0 on command line)</div><div clas=
s=3D"gmail_extra"><br></div>I had posted a patch ( a year ago?) which sets =
the offset to 0. I did not remove the offset variable though it makes sense=
 to get rid of it... Anyway the patch never got any attention :)</div><div =
class=3D"gmail_extra">=C2=A0=C2=A0</div><div class=3D"gmail_extra">Thanks,<=
/div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva<=
/div></div>

--94eb2c0438e000706f0543050da9--

