Message-ID: <522F4A3E.40903@...515...>
Date: Tue, 10 Sep 2013 19:35:10 +0300
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <CAFHpkQH8KqhA41snWJEjJ4QV9b1J5u78Kf8r3s23OQHnJKALSw@...278...>
	<522EC99A.3010008@...515...>	<522F4453.1030401@...515...>
	<CAFHpkQG_7waUOHiMeAxM3K1zQ-kMobGrjNYCg3t9RpbBau1r3g@...278...>
In-Reply-To: <CAFHpkQG_7waUOHiMeAxM3K1zQ-kMobGrjNYCg3t9RpbBau1r3g@...278...>
Subject: Re: [Openvpn-devel] build.openvpn.net is unreachable
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
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Build is also running buildbot for continuous integration already, so no
need to reinvent the wheel there. The buildbot instance is not publicly
accessible, but build failure reports are sent to openvpn-builds mailing
lists, which is public.

The openvpn-build-2.tar.gz file is indeed missing. Just replace 2 with 5
and you're good :).

Samuli

> what is build.openvpn.net about ? is it just storage for files?
>
> I'm setting up Jenkins for automated openvpn build (work in progress,
> not done yet), I think it's good idea to have something like
> Jenkins/TeamCity for automated builds. I can take care of it.
>
> 2013/9/10 Samuli Sepp=C3=A4nen <samuli@...515...>:
>> Build.openvpn.net is now back online (migrated it to another server).
>> The files under web server root are not 100% the same as with the old
>> server, so please check that openvpn-build is not trying to fetch files
>> that don't exist.
>>
>> Samuli
>>
>>
>>> Hi,
>>>
>>> Noticed that also. I'll get it back online a.s.a.p.
>>>
>>> Samuli
>>>
>>>
>>>> hello!
>>>>
>>>> build scripts from https://github.com/OpenVPN/openvpn-build stopped
>>>> working, because build.openvpn.net in unreacheble, is it ok ?
>>>>
>>>> Ilya Shipitsin
>>>>
>>>> ----------------------------------------------------------------------=
--------
>>>> How ServiceNow helps IT people transform IT departments:
>>>> 1. Consolidate legacy IT systems to a single system of record for IT
>>>> 2. Standardize and globalize service processes across IT
>>>> 3. Implement zero-touch automation to replace manual, redundant tasks
>>>> http://pubads.g.doubleclick.net/gampad/clk?id=3D51271111&iu=3D/4140/os=
tg.clktrk
>>>> _______________________________________________
>>>> Openvpn-devel mailing list
>>>> Openvpn-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>> -----------------------------------------------------------------------=
-------
>>> How ServiceNow helps IT people transform IT departments:
>>> 1. Consolidate legacy IT systems to a single system of record for IT
>>> 2. Standardize and globalize service processes across IT
>>> 3. Implement zero-touch automation to replace manual, redundant tasks
>>> http://pubads.g.doubleclick.net/gampad/clk?id=3D51271111&iu=3D/4140/ost=
g.clktrk
>>> _______________________________________________
>>> Openvpn-devel mailing list
>>> Openvpn-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


