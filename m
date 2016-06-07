MIME-Version: 1.0
In-Reply-To: <45ec7635-8bb5-f811-9b8b-4713091d79ee@...515...>
References: <CAFHpkQFkm-6FUUs8DN63UKKHCPHZBmLDK1fk60xaycUk3K5GSQ@...278...>
	<CAFHpkQEjE6vmRm3-Mq_9i3A2w5TrcJ4rasxoZwf00W+sPh3DDQ@...278...>
	<CAFHpkQEt1tH5yPY-9=G6YRuardSBM7CtsDLOHd71JHHUQBtOwQ@...278...>
	<45ec7635-8bb5-f811-9b8b-4713091d79ee@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 7 Jun 2016 20:37:21 +0500
Message-ID: <CAFHpkQE8Kx99Htg2LpW6s0Y_vW7ZugbcpwSo9mM1DmQ_hL7hEA@...278...>
Content-Type: multipart/alternative; boundary=001a114e35b01298ae0534b1f7c9
Subject: Re: [Openvpn-devel] Valgring findings
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

--001a114e35b01298ae0534b1f7c9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I thought to run valgrind separately, but it might be interesting to run it
under "make check" as well

2016-06-07 19:33 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

>
> Hello,
>>
>> I played with valgrind a bit
>>
>> https://travis-ci.org/chipitsine/openvpn/jobs/135869065
>>
>> Looks like there are leaks in openssl code, should we suppress it?
>>
>
> I can't comment on the leaks themselves, but I wonder if it would make
> sense to run OpenVPN under Valgrind in "make check". For example, when
> using the Vagrant test VMs the loss of performance would not be a big deal
> - the tests would just run quite a bit longer.
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>

--001a114e35b01298ae0534b1f7c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I thought to run valgrind separately, but it might be inte=
resting to run it under &quot;make check&quot; as well<br></div><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">2016-06-07 19:33 GMT+05:00 =
Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<a href=3D"mailto:samuli@...2092...=
.." target=3D"_blank">samuli@...515...</a>&gt;</span>:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><span class=3D""><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hello,<br>
<br>
I played with valgrind a bit<br>
<br>
<a href=3D"https://travis-ci.org/chipitsine/openvpn/jobs/135869065" rel=3D"=
noreferrer" target=3D"_blank">https://travis-ci.org/chipitsine/openvpn/jobs=
/135869065</a><br>
<br>
Looks like there are leaks in openssl code, should we suppress it?<br>
</blockquote>
<br></span>
I can&#39;t comment on the leaks themselves, but I wonder if it would make =
sense to run OpenVPN under Valgrind in &quot;make check&quot;. For example,=
 when using the Vagrant test VMs the loss of performance would not be a big=
 deal - the tests would just run quite a bit longer.<span class=3D"HOEnZb">=
<font color=3D"#888888"><br>
<br>
-- <br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
</font></span></blockquote></div><br></div>

--001a114e35b01298ae0534b1f7c9--

