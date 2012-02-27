MIME-Version: 1.0
In-Reply-To: <CAOazyz2BoMoNXJAZuKWV5-d=V5mrE8Mz4mEcnvA=sq_s2W40cA@...278...>
References: <CAOazyz2MWSWqf6L4XQYNBpCHL73vgZKB=StzLEL5s0oQjihJPA@...278...>
	<4F4B526A.2010603@...515...>
	<CAOazyz2BoMoNXJAZuKWV5-d=V5mrE8Mz4mEcnvA=sq_s2W40cA@...278...>
Date: Mon, 27 Feb 2012 13:35:50 +0200
Message-ID: <CAOazyz2sedvohsaMXi_MhhizehuKGDS3AHdY3QsiSoMVku8D1g@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [build] tap-windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

2012/2/27 Alon Bar-Lev <alon.barlev@...277...>:
>>> To build use you need ddk available:
>>>> configure
>>>> build
>> Checked out the sources using "Git Bash", then ran the commands from a
>> (non-admin) Visual Studio 2008 command prompt. Got these errors:
>>
>> <http://pastebin.com/XfZDJPpa>
>
> Please remove the @echo off for me to see the files.
> You can also look into it... It simply look for files to substitute vars in.

Oh... it looked for config-local.bat, this should be optional.
You can create empty file for now.

Alon.

