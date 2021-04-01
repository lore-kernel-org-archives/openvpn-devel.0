MIME-Version: 1.0
References: <CAAUX2SVQRn4zuDC947HE9M38nDNK1oNqyUv0GKeAw2dasHo62Q@...278...>
 <ad7e8624-6f87-2874-9786-d5de521bc6a2@...2181...>
 <f10fc09e-5d7b-c678-02f8-04f80f004b24@...2181...>
 <CAAUX2SU9u8sdsN08ynDTVD15q+qP0yOF-RxMzF5hMRg-pFCWFg@...278...>
In-Reply-To: <CAAUX2SU9u8sdsN08ynDTVD15q+qP0yOF-RxMzF5hMRg-pFCWFg@...278...>
From: Tony He <huangya90@...277...>
Date: Thu, 1 Apr 2021 10:38:15 +0800
Message-ID: <CAAUX2SXiT1=-5HtKzQRay-R1zreT0_7QpEvjc40H3-0U2nqcAA@...278...>
Content-Type: multipart/alternative; boundary="000000000000463a6205bee020a6"
Subject: Re: [Openvpn-devel] [ovpn-dco] sudden network disconnection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Arne Schwabe <arne@...1227...>

--000000000000463a6205bee020a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antonio, Arne,

According to the dump, this issue is caused by fragment. If I set link-mtu
to 1472 in the condition of encryption "none", it's gone.
I also can reproduce the fragment in my Linux x86-64 PC and Linux VM . They
use kernel 5.4. Fragment affects the performance
in the low-end devices. It also consumes more CPU resource in low-end and
high-end devices.  If I'm not mistaken, we don't need
to set link-mtu without dco. Is this a bug? Can you reproduce? Do I still
need to upload my dump? If so, maybe I need to provide a link.

Tony

Tony He <huangya90@...277...> =E4=BA=8E2021=E5=B9=B43=E6=9C=8831=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:42=E5=86=99=E9=81=93=EF=BC=9A

>
>
> Antonio Quartulli <a@...2181...> =E4=BA=8E2021=E5=B9=B43=E6=9C=8831=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=882:32=E5=86=99=E9=81=93=EF=BC=9A
>
>> Hi,
>>
>> On 31/03/2021 08:29, Antonio Quartulli wrote:
>> > A packet dump of the whole session may also help.
>>
>> Before taking the dump, I would switch to encryption "none", as it will
>> help understanding what is going on at all levels. (Assuming the problem
>> will still appear)
>>
> Some issue.  Will provide dump or more log when I am free.
>
> Tony
>

--000000000000463a6205bee020a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Antonio, Arne,<div><br></div><div>According to the dump=
, this issue is caused by fragment. If I set link-mtu to 1472 in the condit=
ion of encryption &quot;none&quot;, it&#39;s gone.</div><div>I also can rep=
roduce the fragment in my Linux x86-64 PC and Linux VM . They use kernel 5.=
4. Fragment affects the performance</div><div>in the low-end devices. It al=
so consumes more CPU resource in low-end and high-end devices.=C2=A0 If I&#=
39;m not mistaken, we don&#39;t need</div><div>to set link-mtu without dco.=
 Is this a bug? Can you reproduce? Do I still need to upload my dump? If so=
, maybe I need to provide a link.</div><div><br></div><div>Tony</div></div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Tony H=
e &lt;<a href=3D"mailto:huangya90@...277...">huangya90@...277...</a>&gt; =
=E4=BA=8E2021=E5=B9=B43=E6=9C=8831=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=
=8D=8811:42=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Antonio Quartu=
lli &lt;a@...2181...&gt; =E4=BA=8E2021=E5=B9=B43=E6=9C=8831=E6=97=A5=E5=91=
=A8=E4=B8=89 =E4=B8=8B=E5=8D=882:32=E5=86=99=E9=81=93=EF=BC=9A<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On 31/03/2021 08:29, Antonio Quartulli wrote:<br>
&gt; A packet dump of the whole session may also help.<br>
<br>
Before taking the dump, I would switch to encryption &quot;none&quot;, as i=
t will<br>
help understanding what is going on at all levels. (Assuming the problem<br>
will still appear)<br></blockquote><div>Some issue.=C2=A0 Will provide dump=
 or more log when I am free.</div><div><br></div><div>Tony=C2=A0 <br></div>=
</div></div>
</blockquote></div>

--000000000000463a6205bee020a6--

