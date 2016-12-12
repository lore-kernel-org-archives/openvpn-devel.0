MIME-Version: 1.0
In-Reply-To: <f9668ae4-0e98-53af-35d1-db3006ce308d@...515...>
References: <CAKuzo_hFT3vXnNn46ubhQiV0zwjg_0uyyMyVtNq2OZeYsq3TuQ@...278...>
	<08d5f483-cc64-b708-a54c-29cfb2c7880e@...277...>
	<CAKuzo_jFHw1k0M0WfU8WsiTaZDYNE9+K=2=41g_oHqLikydo1w@...278...>
	<ad8c62af-5534-79d7-11ff-56cf51888615@...277...>
	<CAKuzo_iBnazFOMGaCDO-ga_ONCN=wb6818syt+S66S_OKZDoCw@...278...>
	<f9668ae4-0e98-53af-35d1-db3006ce308d@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 12 Dec 2016 12:44:36 -0500
Message-ID: <CAKuzo_h+gv1deOB2rAJ+44oHijgEBb1xrhw2n7gr27RBdSL0Qw@...278...>
Content-Type: multipart/alternative; boundary=001a11408cb679dc22054379a95a
Subject: Re: [Openvpn-devel] On saving passwords
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11408cb679dc22054379a95a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 12, 2016 at 3:09 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:

> Il 11/12/2016 19:52, Selva Nair ha scritto:
>
>>
>> On Sun, Dec 11, 2016 at 12:00 PM, debbie10t <debbie10t@...277...
>> <mailto:debbie10t@...277...>> wrote:
>>
>>     What happens if a remote user, who has admin access to their own
>>     computer, connects to a work VPN but they decide to change said
>> config ?
>>
>>
>> A user who has admin access to their own computer can do anything to it:
>> including saving VPN passwords. Why would openvpn stop them doing that?
>> The question was about a sysadmin of an office not allowing their users
>> to save their openvpn passwords in an automated way. There is no way of
>> ensuring that if the user has admin access on their devices. Note that
>> password is saved on the client, not the server.
>>
>
> There are many ways to circumvent password saving restrictions

if the enforcement is supposed to happen on the client side.
>

The server cannot enforce what a user does with his password, can it?
Unless one
uses some kind of OTP so that there is no savable password so to speak.

>
> Some years back I used xdotool[1] to manage keyboard input and mouse

movements to automate otherwise unautomateable things. While it's a

crude approach, it could be easily used to automate password typing and

mouse clicks. I'm sure similar tools are available for Windows.


Yeah, policies like no saving of passwords can be enforced only with user
co-operation.

But our prerogative here is to just provide a way for an admin to reliably
disable the password-save feature in the GUI. The question is how strong is
the case for something like that. I can see that if an establishment has a
policy that asks users not to save passwords, it wont be appropriate to
have UIs with enticing check-boxes to save passwords. Users installing a
hacked GUI or using automated key-strokes would be beyond us.

Selva

--001a11408cb679dc22054379a95a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Dec 12, 2016 at 3:09 AM, <span class=3D"" id=3D":5sp.1" tabindex=3D=
"-1">Samuli</span> <span class=3D"" id=3D":5sp.2" tabindex=3D"-1">Sepp=C3=
=A4nen</span> <span dir=3D"ltr">&lt;<a href=3D"mailto:samuli@...515..." tar=
get=3D"_blank"><span class=3D"" id=3D":5sp.3" tabindex=3D"-1">samuli</span>=
@<span class=3D"" id=3D":5sp.4" tabindex=3D"-1">openvpn</span>.net</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><span>Il 11/12/2016 19:52, =
Selva Nair ha scritto:<br>
</span><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><span>
<br>
On Sun, Dec 11, 2016 at 12:00 PM, debbie10t &lt;<a href=3D"mailto:debbie10t=
@...277..." target=3D"_blank">debbie10t@...277...</a><br></span><span>
&lt;mailto:<a href=3D"mailto:debbie10t@...277..." target=3D"_blank">debbie1=
0t@...277...</a>&gt;&gt; wrote:<br>
<br>
=C2=A0 =C2=A0 What happens if a remote user, who has admin access to their =
own<br>
=C2=A0 =C2=A0 computer, connects to a work VPN but they decide to change sa=
id config ?<br>
<br>
<br>
A user who has admin access to their own computer can do anything to it:<br>
including saving VPN passwords. Why would openvpn stop them doing that?<br>
The question was about a sysadmin of an office not allowing their users<br>
to save their openvpn passwords in an automated way. There is no way of<br>
ensuring that if the user has admin access on their devices. Note that<br>
password is saved on the client, not the server.<br>
</span></blockquote>
<br>
There are many ways to circumvent password saving restrictions=C2=A0</block=
quote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">if the enforcement is supposed to happ=
en on the client side.<br></blockquote><div><br></div><div>The server canno=
t enforce what a user does with his password, can it? Unless one</div><div>=
uses some kind of <span class=3D"" id=3D":5sp.5" tabindex=3D"-1">OTP</span>=
 so that there is no savable password so to speak.</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
Some years back I used xdotool[1] to manage keyboard input and mouse=C2=A0<=
/blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">movements to automate otherwise =
unautomateable things. While it&#39;s a</blockquote><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">crude approach, it could be easily used to automate password typing=
 and=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">mouse clicks. I&#39;m=
 sure similar tools are available for Windows.</blockquote></div><br>Yeah, =
policies like no saving of passwords can be enforced only with user co-oper=
ation.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"=
>But our prerogative here is to just provide a way for an admin to reliably=
 disable the password-save feature in the GUI. The question is how strong i=
s the case for something like that. I can see that if an establishment has =
a policy that asks users not to save passwords, it wont be appropriate to h=
ave <span class=3D"" id=3D":5sp.6" tabindex=3D"-1">UIs</span> with enticing=
 check-boxes to save passwords. Users installing a hacked GUI or using auto=
mated key-strokes would be beyond us.</div><div class=3D"gmail_extra"><br><=
/div><div class=3D"gmail_extra"><span class=3D"" id=3D":5sp.7" tabindex=3D"=
-1">Selva</span></div></div>

--001a11408cb679dc22054379a95a--

