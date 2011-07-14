Message-ID: <4E1F672E.1010305@...515...>
Date: Thu, 14 Jul 2011 15:01:18 -0700
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4E1F227F.7060308@...515...>
In-Reply-To: <4E1F227F.7060308@...515...>
Subject: Re: [Openvpn-devel] First Windows installer snapshot now available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi,
>
> The first Windows installer snapshot is now available here:
>
> <http://build.openvpn.net/downloads/snapshots/openvpn-2.x-20110714-winbuildfix-install.exe>
>
> As the name implies, it's based on "tmp/winbuildfix" branch in Git, on
> top which I've applied my latest two patches[1]. Later snapshots will be
> based on "master" branch.
>
> I did basic IPv4 smoketests on Windows 7 64-bit and it seems to work.
> Both the installer and the TAP-driver are unsigned, so users of 64-bit
> versions of Vista (and above) need to start their computers in "Test
> mode" to try this out. The goal is to put signed TAP-drivers to future
> installers.
>
> Samuli
>
> [1] <http://thread.gmane.org/gmane.network.openvpn.devel/4842>

Here's another OpenVPN 2.3 pre-alpha installer which uses Heiko's new
Windows GUI[1]:

<http://build.openvpn.net/downloads/snapshots/openvpn-2.x-20110714-winbuildfix-newgui-install.exe>

It is more modern (e.g. uses the management interface), but looks
essentially the same as the old one. It passed the same smoketests as
the previous installer.

Samuli

[1] <http://sourceforge.net/projects/openvpn-gui>

