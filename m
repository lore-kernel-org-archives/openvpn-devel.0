MIME-Version: 1.0
In-Reply-To: <CAFHpkQGKV3pAeTjabYbyP4LwwDqUa7Atuuqh0qyQ95DTdL39dA@...278...>
References: <CAFHpkQGseLH-+NFRxgrF7KNdZ8Fc4A4HQGBOTEktwABW9ZALTw@...278...>
	<20170315152840.GR93896@...1296...>
	<CAFHpkQGKV3pAeTjabYbyP4LwwDqUa7Atuuqh0qyQ95DTdL39dA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 15 Mar 2017 11:46:05 -0400
Message-ID: <CAKuzo_g-6RXk910xT-g7jjdBnzYm2O0edLPbUO+4srt_nGM1gw@...278...>
Content-Type: multipart/alternative; boundary=001a1141b2ece212e8054ac6d872
Subject: Re: [Openvpn-devel] why "ifconfig" is required during build ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1141b2ece212e8054ac6d872
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 15, 2017 at 11:37 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

> >
>> > well, it makes sense that it might be required for running openvpn. but
>> why
>> > to check it during build ?
>>
>> To find the path that we're going to call the binary with.  We do not
>> rely on $PATH resolution at runtime.
>>
>
> well, what if I will not change current (i.e. default behaviour), but
> instead I will add a possibility to specify ifconfig explicitly
>

You can set custom path during configure like this:

$ IFCONFIG=3D/opt/hacks/bin/ifconfig ./configure

Selva

--001a1141b2ece212e8054ac6d872
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Wed, Mar 15, 2017 at 11:37 AM, =D0=
=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <span dir=
=3D"ltr">&lt;<a href=3D"mailto:chipitsine@...277..." target=3D"_blank">chip=
itsine@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><s=
pan class=3D""><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote"><span clas=
s=3D"m_1476211426808780458gmail-">&gt;<br>
&gt; well, it makes sense that it might be required for running openvpn. bu=
t why<br>
&gt; to check it during build ?<br>
<br>
</span>To find the path that we&#39;re going to call the binary with.=C2=A0=
 We do not<br>
rely on $PATH resolution at runtime.<br></blockquote><div><br></div></span>=
<div>well, what if I will not change current (i.e. default behaviour), but =
instead I will add a possibility to specify ifconfig explicitly</div></bloc=
kquote></div><br>You can set custom path during configure like this:</div><=
div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">$ IFCONFIG=
=3D/opt/hacks/bin/ifconfig ./configure</div><div class=3D"gmail_extra"><br>=
</div><div class=3D"gmail_extra">Selva</div></div>

--001a1141b2ece212e8054ac6d872--

