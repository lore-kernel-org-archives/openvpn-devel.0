MIME-Version: 1.0
In-Reply-To: <CAKuzo_g-6RXk910xT-g7jjdBnzYm2O0edLPbUO+4srt_nGM1gw@...278...>
References: <CAFHpkQGseLH-+NFRxgrF7KNdZ8Fc4A4HQGBOTEktwABW9ZALTw@...278...>
	<20170315152840.GR93896@...1296...>
	<CAFHpkQGKV3pAeTjabYbyP4LwwDqUa7Atuuqh0qyQ95DTdL39dA@...278...>
	<CAKuzo_g-6RXk910xT-g7jjdBnzYm2O0edLPbUO+4srt_nGM1gw@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 15 Mar 2017 21:34:24 +0500
Message-ID: <CAFHpkQFC7tjyAwjDc19+PZ-yn+hJJK04d2rDAb9K=fa_vOJtPA@...278...>
Content-Type: multipart/alternative; boundary=001a1147ded8740857054ac7842e
Subject: Re: [Openvpn-devel] why "ifconfig" is required during build ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1147ded8740857054ac7842e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-03-15 20:46 GMT+05:00 Selva Nair <selva.nair@...277...>:

> Hi,
>
> On Wed, Mar 15, 2017 at 11:37 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=
=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>
> wrote:
>
>> >
>>> > well, it makes sense that it might be required for running openvpn.
>>> but why
>>> > to check it during build ?
>>>
>>> To find the path that we're going to call the binary with.  We do not
>>> rely on $PATH resolution at runtime.
>>>
>>
>> well, what if I will not change current (i.e. default behaviour), but
>> instead I will add a possibility to specify ifconfig explicitly
>>
>
> You can set custom path during configure like this:
>
> $ IFCONFIG=3D/opt/hacks/bin/ifconfig ./configure
>

great!

https://github.com/OpenVPN/openvpn-build/blob/master/windows-nsis/build-sna=
pshot#L35

we need Makefile in order to "make dist", so we run "configure", but we are
not going to build openvpn actually.

I will use "IFCONFIG=3D/..../ifconfig  ./configure" approach.
or, maybe a better approach exists ?


>
> Selva
>

--001a1147ded8740857054ac7842e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-03-15 20:46 GMT+05:00 Selva Nair <span dir=3D"ltr">&lt;<a target=
=3D"_blank" href=3D"mailto:selva.nair@...277...">selva.nair@...277...</a>&g=
t;</span>:<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote"><div dir=3D=
"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_extra"><span =
class=3D"gmail-"><br><div class=3D"gmail_quote">On Wed, Mar 15, 2017 at 11:=
37 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD =
<span dir=3D"ltr">&lt;<a target=3D"_blank" href=3D"mailto:chipitsine@...1482...=
...">chipitsine@...277...</a>&gt;</span> wrote:<br><blockquote style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex" class=3D"gmail_quote"><span><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><span class=3D"gmail-m_422134879994940698m_1476211426808780458gmail-=
">&gt;<br>
&gt; well, it makes sense that it might be required for running openvpn. bu=
t why<br>
&gt; to check it during build ?<br>
<br>
</span>To find the path that we&#39;re going to call the binary with.=C2=A0=
 We do not<br>
rely on $PATH resolution at runtime.<br></blockquote><div><br></div></span>=
<div>well, what if I will not change current (i.e. default behaviour), but =
instead I will add a possibility to specify ifconfig explicitly</div></bloc=
kquote></div><br></span>You can set custom path during configure like this:=
</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">$ IFC=
ONFIG=3D/opt/hacks/bin/<wbr>ifconfig ./configure</div></div></blockquote><d=
iv><br></div><div>great!<br><br><a href=3D"https://github.com/OpenVPN/openv=
pn-build/blob/master/windows-nsis/build-snapshot#L35">https://github.com/Op=
enVPN/openvpn-build/blob/master/windows-nsis/build-snapshot#L35</a><br><br>=
</div><div>we need Makefile in order to &quot;make dist&quot;, so we run &q=
uot;configure&quot;, but we are not going to build openvpn actually.<br><br=
></div><div>I will use &quot;IFCONFIG=3D/..../ifconfig=C2=A0 ./configure&qu=
ot; approach.<br></div><div>or, maybe a better approach exists ?<br></div><=
div>=C2=A0</div><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote"><div dir=
=3D"ltr"><span class=3D"gmail-HOEnZb"><font color=3D"#888888"><div class=3D=
"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</div></font></span=
></div>
</blockquote></div><br></div></div>

--001a1147ded8740857054ac7842e--

