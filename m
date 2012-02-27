Message-ID: <4F4B526A.2010603@...515...>
Date: Mon, 27 Feb 2012 11:52:42 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAOazyz2MWSWqf6L4XQYNBpCHL73vgZKB=StzLEL5s0oQjihJPA@...278...>
In-Reply-To: <CAOazyz2MWSWqf6L4XQYNBpCHL73vgZKB=StzLEL5s0oQjihJPA@...278...>
Subject: Re: [Openvpn-devel] [build] tap-windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>


> Hello,
>
> A repository is available[1], stripped down with only tap sources.
>
> To build use you need ddk available:
>> configure
>> build
Checked out the sources using "Git Bash", then ran the commands from a
(non-admin) Visual Studio 2008 command prompt. Got these errors:

<http://pastebin.com/XfZDJPpa>

The OS is Windows server 2008r2. Any ideas? I noticed there was some
ActiveX stuff in the scripts... could this be related to security settings?

> It builds winxp 32bit and win7 64bit I hope this is what the current
> installer is doing,
> as building the tap is kept secret.
Actually, the TAP-driver is built using the Python build scripts in the
"win" subdirectory. Those scripts build both 32-bit and 64-bit drivers.

> In the open source package we will provide vanilla devcon and not the mod=
ified
> tapinstaller which we do not have the sources of. I it is so important
> to hack computer
> and bypass Windows confirmation dialog.
The Python-based buildsystem also builds tapinstall.exe/devcon.exe. It
looks for the sources from ../tapinstall by default (see "grep T1SRC
win/*"). The sources are standard devcon sources; the resulting binary
is simply renamed to "tapinstall.exe".

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



