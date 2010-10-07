Message-ID: <4CADE70D.8070307@...1147...>
Date: Thu, 07 Oct 2010 17:28:13 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <20101007142817.GU7437@...1152...>
In-Reply-To: <20101007142817.GU7437@...1152...>
Subject: Re: [Openvpn-devel] [Openvpn-users] TAP installation Problem
	(2.1.3) on Windows 2000
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Ralf Hildebrandt <Ralf.Hildebrandt@...1152...>
Cc: Katja.Stange@...1152..., "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net

Ralf Hildebrandt wrote:
> During installation, no TAP32 adapter is being installed and the 
> addtap.bat returns an error:
>
> d:\program files\openvpn\bin\tapinstall.exe is not a valid Win32 application.
>
> WHy is that?
>
>   
it's a (minor) mistake in how openvpn 2.1.3 is packaged:

openvpn 2.1.1 comes with tapinstall.exe v6.0.6001.18000, named 'Windows 
Codename Longhorn DDK driver'
openvpn 2.1.3 comes with tapinstall.exe v6.1.7600.16385, named 'Windows 
Win 7 DDK provider'

Apparently this later version of tapinstall.exe is not recognized as a 
valid win32 application, most likely because Microsoft stopped 
supporting Windows 2000 some time ago. Note that OpenVPN 2.2 will also 
no longer include Windows 2000 support, as was discussed somewhere late 
august.

The nice fix would be to include the older version of tapinstall.exe in 
an update of the windows installer package. A quick&dirty hack is to 
copy over the tapinstall.exe from the 2.1.1 installer and then run 
'tapinstall' again (from the OpenVPN menu option in the 'Start' menu)


HTH,

JJK


