Message-ID: <4F8FEE60.9010302@...515...>
Date: Thu, 19 Apr 2012 13:52:16 +0300
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <4F881610.5010304@...515...>
	<CAOazyz3RcTS4b8Gc-_ort0T0Zw-hEbUMz-NYab21Ww4pZ4Bxkw@...278...>
	<4F8D1282.1020803@...515...>
	<CAOazyz3u1qHqVOBh0ZDUobg17be5SAjVctVC7icqnkAvHjGHNw@...278...>
	<CAOazyz3+WvJ1Ln=Vc76+k4mskcBSUOpw5z074kRFdJHrNkoEJg@...278...>
In-Reply-To: <CAOazyz3+WvJ1Ln=Vc76+k4mskcBSUOpw5z074kRFdJHrNkoEJg@...278...>
Subject: Re: [Openvpn-devel] MSVC build tests on Git "master"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> 2012/4/17 Alon Bar-Lev <alon.barlev@...277...>:
>> 2012/4/17 Samuli Sepp=C3=A4nen <samuli@...515...>
>>> Hi Alon,
>>>>> This allowed the build to proceed, but then I got tons of errors. Tho=
se
>>>>> seem to be caused by Visual Studio 2010 peculiarities; see [4] for a
>>>>> partial log. The full error log is 1396k in size - If you need it just
>>>>> let me know.
>>>> I don't quite understand who you tried to build this... manually or
>>>> using the openvpn-build/msvc.
>>>> If you try to build manually, please send me the exact commands you
>>>> used.
>>> I used the "msvc-build.bat" (renamed "build.bat" from Git "master") with
>>> no parameters.
>> Hmmm.... I still don't follow, sorry.
>>
>> What is renamed? I see that in git master we have msvc-build.bat....
>> Or you mean you used this one, which is OK.
>> But then probably the dependencies setup are wrong.
>>
>> Please first try to complete build from the openvpn-build project[1].
>>
>> Use:
>>> cd msvc
>>> build
>> If that's working, then it will be easy to trace problems in your enviro=
nment.
>> If that's not working, it will be easy to trace differences from my envi=
ronment.
>>
>> Thanks!
>>
>> [1] https://github.com/alonbl/openvpn-build
> Just tried that again in my VM, and it builds successfully using the
> openvpn-build/msvc.
> So once you have results for this, I will try to figure out how to help.
>
> Alon.
I'll look into this again later, maybe during the weekend.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


