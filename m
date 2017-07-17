MIME-Version: 1.0
In-Reply-To: <da7671c8-6768-f718-79a0-996cdb0d8d87@...1147...>
References: <f7687ebf-a75f-095d-67ca-e32a5c4e53e7@...515...>
	<41c0e750-b27e-22ea-d5fb-b17fe391636d@...1147...>
	<689096e2-8bb8-95b8-5daf-22fd600a00ca@...515...>
	<da7671c8-6768-f718-79a0-996cdb0d8d87@...1147...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 17 Jul 2017 17:08:30 +0500
Message-ID: <CAFHpkQH41x4-rphoQzxmubvq86yWxJzFvDqrPwVP5VFMN6v16g@...278...>
Content-Type: multipart/alternative; boundary="001a1145b0c2dcde620554824105"
Subject: Re: [Openvpn-devel] Windows installer with updated pkcs11-helper
 (1.22) available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1145b0c2dcde620554824105
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-07-17 17:01 GMT+05:00 Jan Just Keijser <janjust@...1147...>:

> Hi all,
>
> On 17/07/17 12:34, Samuli Sepp=C3=A4nen wrote:
>
>> On 15/07/2017 00:43, Jan Just Keijser wrote:
>>
>>> Hi Samuli,
>>>
>>> On 14/07/17 16:07, Samuli Sepp=C3=A4nen wrote:
>>>
>>>> Hi all,
>>>>
>>>> Those of you who use pkcs11 on Windows: could you please test this new
>>>> Windows installer:
>>>>
>>>> <http://build.openvpn.net/downloads/releases/openvpn-install
>>>> -2.4.3-I602.exe>
>>>>
>>>>
>>>> The previous installer(s) had pkcs11-helper 1.11. This one has 1.22, so
>>>> some regression testing would be good to have.
>>>>
>>>> I'd like to push the updated installer out early next week, preferably
>>>> on Monday.
>>>>
>>>> nice to see that pkcs11 support is still included in the Windows
>>> version; I can test the installer on monday morning(no Windows laptop in
>>> my house ;))  I will let you know my findings.
>>>
>>> cheers,
>>>
>>> JJK
>>>
>>> Hi JJK,
>>
>> Excellent, thanks! I will push out the new installer if everything looks
>> good at your end.
>>
>>
> good news and bad news:
>
> + the pkcs11 stuff works as expected, no problems there
> - with openvpn 2.4.3 my existing setup using "redirect-gateway def1"
> stopped working!
>
> I'll downgrade OpenVPN to see if this problem was already there in 2.3.XX
> ; what happens is this:
> - openvpn wants to add a direct route to the VPN server
> - there happen to be TWO gateways to that server with the SAME IP address,
> one via wired ethernet, one via wireless
> - openvpn gets confused and says "route gateway is ambiguous" and refuses
> to add it
>

@mattock , can we have community meeting, please ?

there were a discussion (regarding changes in openvpn-gui <--> openvpn-core
interoperation) on how to serve routing issues.

there were two suggestions, either make route errors fatal or translate
them to openvpn-gui level.

currently, it is no good

(yes, current error would not have been resolved by those changes, but
error indication would be more clear)



> - after that, all traffic is jammed, as there is no direct route to the
> VPN server itself, and thus all encrypted traffic is fed back into the
> tunnel, where it is encrypted again, etc etc ("biting your own tail").
>
> Disconnecting either wired or wireless solves the issue AFTER restarting
> OpenVPN. Annoying.
> It looks like a (minor) patch is needed to deal with this special case
>
> cheers,
>
> JJK
>
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a1145b0c2dcde620554824105
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-07-17 17:01 GMT+05:00 Jan Just Keijser <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:janjust@...1147..." target=3D"_blank">janjust@...1147...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">Hi all,<br>
<br>
On 17/07/17 12:34, Samuli Sepp=C3=A4nen wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 15/07/2017 00:43, Jan Just Keijser wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi Samuli,<br>
<br>
On 14/07/17 16:07, Samuli Sepp=C3=A4nen wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi all,<br>
<br>
Those of you who use pkcs11 on Windows: could you please test this new<br>
Windows installer:<br>
<br>
&lt;<a href=3D"http://build.openvpn.net/downloads/releases/openvpn-install-=
2.4.3-I602.exe" rel=3D"noreferrer" target=3D"_blank">http://build.openvpn.n=
et/down<wbr>loads/releases/openvpn-install<wbr>-2.4.3-I602.exe</a>&gt;<br>
<br>
<br>
The previous installer(s) had pkcs11-helper 1.11. This one has 1.22, so<br>
some regression testing would be good to have.<br>
<br>
I&#39;d like to push the updated installer out early next week, preferably<=
br>
on Monday.<br>
<br>
</blockquote>
nice to see that pkcs11 support is still included in the Windows<br>
version; I can test the installer on monday morning(no Windows laptop in<br>
my house ;))=C2=A0 I will let you know my findings.<br>
<br>
cheers,<br>
<br>
JJK<br>
<br>
</blockquote>
Hi JJK,<br>
<br>
Excellent, thanks! I will push out the new installer if everything looks<br>
good at your end.<br>
<br>
</blockquote>
<br>
good news and bad news:<br>
<br>
+ the pkcs11 stuff works as expected, no problems there<br>
- with openvpn 2.4.3 my existing setup using &quot;redirect-gateway def1&qu=
ot;=C2=A0 stopped working!<br>
<br>
I&#39;ll downgrade OpenVPN to see if this problem was already there in 2.3.=
XX ; what happens is this:<br>
- openvpn wants to add a direct route to the VPN server<br>
- there happen to be TWO gateways to that server with the SAME IP address, =
one via wired ethernet, one via wireless<br>
- openvpn gets confused and says &quot;route gateway is ambiguous&quot; and=
 refuses to add it<br></blockquote><div><br></div><div>@mattock , can we ha=
ve community meeting, please ?<br><br></div><div>there were a discussion (r=
egarding changes in openvpn-gui &lt;--&gt; openvpn-core interoperation) on =
how to serve routing issues.<br><br></div><div>there were two suggestions, =
either make route errors fatal or translate them to openvpn-gui level.<br><=
br></div><div>currently, it is no good<br><br></div><div>(yes, current erro=
r would not have been resolved by those changes, but error indication would=
 be more clear)<br></div><div><br>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
- after that, all traffic is jammed, as there is no direct route to the VPN=
 server itself, and thus all encrypted traffic is fed back into the tunnel,=
 where it is encrypted again, etc etc (&quot;biting your own tail&quot;).<b=
r>
<br>
Disconnecting either wired or wireless solves the issue AFTER restarting Op=
enVPN. Annoying.<br>
It looks like a (minor) patch is needed to deal with this special case<br>
<br>
cheers,<br>
<br>
JJK<br>
<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@...1483...<wbr>e.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</blockquote></div><br></div></div>

--001a1145b0c2dcde620554824105--

