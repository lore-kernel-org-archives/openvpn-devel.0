MIME-Version: 1.0
In-Reply-To: <CAKuzo_gwi_T0MFygSN=tCMCMtuaeS2TGwxm7Kin=bhv0H+u4pw@...278...>
References: <c97c0fd6-3d34-fb94-40e4-3ec8dc7af0c9@...277...>
	<f73269d2-ba02-5360-9498-378f1e221a56@...277...>
	<CAKuzo_jkyATwPyQkg4mZRAYbUFqc198+yKE-4kyK_--KbRtU=g@...278...>
	<d9c2e940-e72b-cb12-193d-a164bc4ac270@...277...>
	<CAFHpkQF2fF_69jsquGJ=eamkSMVWPRbO7bFOLixP=27QgEEs5g@...278...>
	<CAKuzo_gL-D8mSbOvEzN6N1MZ816=f1xNP_ZUzyiucb4-K0t0hg@...278...>
	<CAFHpkQH3kE62G-EtavknAAZWOdS=0wkERy9FfYyDpbCKZuuHNw@...278...>
	<79b0624d-53fe-8e17-c58a-221434caad32@...1227...>
	<CAKuzo_gwi_T0MFygSN=tCMCMtuaeS2TGwxm7Kin=bhv0H+u4pw@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 14 Jun 2017 01:30:21 +0500
Message-ID: <CAFHpkQG30rhrg5+coYSN-aevYNxSZ8Ucbd=1ncmkMru1rtSz-Q@...278...>
Content-Type: multipart/alternative; boundary="94eb2c074b4e046f100551dd4e23"
Subject: Re: [Openvpn-devel] W10 Client assigns old AND new IPv6 address to
 TAP with GUI+Service but not with cmd prompt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c074b4e046f100551dd4e23
Content-Type: text/plain; charset="UTF-8"

2017-06-14 1:05 GMT+05:00 Selva Nair <selva.nair@...277...>:

>
> On Tue, Jun 13, 2017 at 3:54 PM, Arne Schwabe <arne@...1227...> wrote:
>
>> >
>> >
>> > if user is administrator, interactive service is not used.
>> > well, I did miss that about interactive service.
>> >
>>
>> I wonder we should always use the interactive service if available and
>> add (dont-use-interactive) option, so behaviour is always the same.
>
>
> This was done for security -- some Windows versions have broken handling
> of passing credentials through named pipe which could be used for privilege
> escalation. I have seen this exploit work only on Windows XP[*], but to be
> cautious we opted not to allow openvpn running as admin connect to the
> service pipe.
>
> But anyway, in this case its the service that's doing the wrong thing.
>

well, I'm lost here.

sounds like "we do not use interactive service if user is already an
administrator ... due to possible privilege escalation", right ? escalation
to "system" ?


>
> Selva
>
> [*] On XP, a rogue program running as user can gain admin rights if a
> program running as admin connects to it through a named pipe.
>

--94eb2c074b4e046f100551dd4e23
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-06-14 1:05 GMT+05:00 Selva Nair <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;<=
/span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gm=
ail_extra"><span class=3D""><br><div class=3D"gmail_quote">On Tue, Jun 13, =
2017 at 3:54 PM, Arne Schwabe <span dir=3D"ltr">&lt;<a href=3D"mailto:arne@=
...1227..." target=3D"_blank">arne@...1227...</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex"><span>&gt;<br>
&gt;<br>
&gt; if user is administrator, interactive service is not used.<br>
&gt; well, I did miss that about interactive service.<br>
&gt;<br>
<br>
</span>I wonder we should always use the interactive service if available a=
nd<br>
add (dont-use-interactive) option, so behaviour is always the same.</blockq=
uote></div><br></span>This was done for security -- some Windows versions h=
ave broken handling of passing credentials through named pipe which could b=
e used for privilege escalation. I have seen this exploit work only on Wind=
ows XP[*], but to be cautious we opted not to allow openvpn running as admi=
n connect to the service pipe.</div><div class=3D"gmail_extra"><br></div><d=
iv class=3D"gmail_extra">But anyway, in this case its the service that&#39;=
s doing the wrong thing.</div></div></blockquote><div><br></div><div>well, =
I&#39;m lost here.<br><br></div><div>sounds like &quot;we do not use intera=
ctive service if user is already an administrator ... due to possible privi=
lege escalation&quot;, right ? escalation to &quot;system&quot; ?<br></div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">[*] On XP, a rogue pr=
ogram running as user can gain admin rights if a program running as admin c=
onnects to it through a named pipe.</div></div>
</blockquote></div><br></div></div>

--94eb2c074b4e046f100551dd4e23--

