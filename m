Message-ID: <4F4B6CEB.7070504@...515...>
Date: Mon, 27 Feb 2012 13:45:47 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <CAOazyz2MWSWqf6L4XQYNBpCHL73vgZKB=StzLEL5s0oQjihJPA@...278...>
	<4F4B526A.2010603@...515...>
	<CAOazyz2BoMoNXJAZuKWV5-d=V5mrE8Mz4mEcnvA=sq_s2W40cA@...278...>
In-Reply-To: <CAOazyz2BoMoNXJAZuKWV5-d=V5mrE8Mz4mEcnvA=sq_s2W40cA@...278...>
Subject: Re: [Openvpn-devel] [build] tap-windows
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
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>


> 2012/2/27 Samuli Sepp=C3=A4nen <samuli@...515...>:
>>> Hello,
>>>
>>> A repository is available[1], stripped down with only tap sources.
>>>
>>> To build use you need ddk available:
>>>> configure
>>>> build
>> Checked out the sources using "Git Bash", then ran the commands from a
>> (non-admin) Visual Studio 2008 command prompt. Got these errors:
>>
>> <http://pastebin.com/XfZDJPpa>
> Please remove the @echo off for me to see the files.
> You can also look into it... It simply look for files to substitute vars =
in.
I'll look into this in detail later, I just briefly tested it.

>>> It builds winxp 32bit and win7 64bit I hope this is what the current
>>> installer is doing,
>>> as building the tap is kept secret.
>> Actually, the TAP-driver is built using the Python build scripts in the
>> "win" subdirectory. Those scripts build both 32-bit and 64-bit drivers.
> Yes.
> But something is not right there as far the signing goes.
That is correct. James has a Python wrapper module that handles signing
using signtool.exe, but for one reason or another, he can't release it.

>>> In the open source package we will provide vanilla devcon and not the m=
odified
>>> tapinstaller which we do not have the sources of. I it is so important
>>> to hack computer
>>> and bypass Windows confirmation dialog.
>> The Python-based buildsystem also builds tapinstall.exe/devcon.exe. It
>> looks for the sources from ../tapinstall by default (see "grep T1SRC
>> win/*"). The sources are standard devcon sources; the resulting binary
>> is simply renamed to "tapinstall.exe".
> There is no T1SRC in master.
Oops, a typo. TISRC, not T1SRC. It's defined in win/settings.in.

> There is no point in compiling devcon if it is provided in DDK.
> What james done in the past is to modify the sources to override the
> sign warning message.
> I provide devcon as-is and let user override it if needed.
Ah, ok, didn't know that. Sounds good.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


