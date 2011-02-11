Message-ID: <4D54F0EA.4050205@...515...>
Date: Fri, 11 Feb 2011 10:18:50 +0200
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4D53FD4B.8050302@...515...>
	<AANLkTinY8n89o63VkgbOtmxMqNcyDggo5fu1sJhYgKxu@...278...>
In-Reply-To: <AANLkTinY8n89o63VkgbOtmxMqNcyDggo5fu1sJhYgKxu@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.2-rc Windows
	installer ready
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Registros Web <registros.web@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

Hi,
> Hi there,
>
> I just tried it on a VM windows xp 32, default installation, just
> clicked on next, next...
>
> Everything seems to be working as usual. I uninstalled the previous
> version before running this new installer and the installation
> finished with no errors. Once installed openvpn connects fine, asking
> for username and password (I use radius for authentication). The icon
> comes up on the status bar and all the right-click options seem to
> work (Disconect, show status, View log... etc.). i guess thats not the
> installer business anyway.
>
> What the installer didnt create for me (even though i remember seeing
> it selected by default during installation although I couldnt be sure,
> so maybe i unselected it while looking at the default options by
> mistake, sorry) was the Start menu folder and icons.
> I removed it and try again and there it was, so maybe it was just me
> the first time.
My guess is that the "Install Start menu entries" was unchecked by
mistake the first time.
> During the second installation i had the openvpn GUI running (I
> uninstalled it previously but left it running disconnected), and the
> installer told me it had a problem copying the file and asked me if I
> wanted to cancel or try again. I mention this cause i don't know if
> this is normal behavior of if it is supposed to shut it down if found
> running. I finally closed it manully and clck on 'retry', then the
> installer had no problem and finished properly.
Yes, I stumbled upon this, too. The problem is that OpenVPN-GUI is using
some of OpenVPN's files, so the uninstaller can't delete them. I'll see
if there's a simple way to kill the OpenVPN-GUI process from within the
uninstaller. If there is, I'll implement that in the final 2.2 release
installer.
> Something that i find missing (and is something that i find very
> annoying) is the fact that it does create a shortcut to openvpn in
> your desktop whether you want it or not. Couldn't it be possible to
> have it as an option during installation (just as you have it for
> 'Create start menu icons' and others)?
Good idea. I'll make that optional in the final 2.2 release.
> And something else i tried was to find any command line options by
> running it on a ms-dos window and found there was none. Wasn't there
> some options in previous versions? I ask that because i repackage the
> openvpn installer some time ago for the company i work for (to include
> config files, keys, etc...), and i recall there were such an options
> which i used to install openvpn quietly calling it with some
> arguments, am i wrong on this?
You mean command-line options for the installer?

<http://nsis.sourceforge.net/Docs/Chapter3.html#3.2>
<http://nsis.sourceforge.net/Docs/Chapter4.html#4.12>

I tried running the installer from the command-line in silent mode and
it installed OpenVPN correctly:

 openvpn-2.2-rc-installer-preview-5.exe /S

However, I did not yet try overriding any of the default options with
command-line switches. For that I need to do more research.
> And i think this is it, hope it helps and thanks for the hard work!
>
Thanks! And many thanks to you for testing!

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



