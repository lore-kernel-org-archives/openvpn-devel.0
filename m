References: <CAPTYJtutoE8LzyiROqu3Vzar6LVfUjbdNh-q+3tMB6Pa7FQJgw@...278...>
	<CAPTYJttd0dwGui5kcgBmD-ROv+C=X7gpJ1UVFQcs7AoWvm7Czg@...278...>
	<20160122120535.GZ24952@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56A22AE7.10500@...515...>
Date: Fri, 22 Jan 2016 15:13:11 +0200
MIME-Version: 1.0
In-Reply-To: <20160122120535.GZ24952@...1296...>
Subject: Re: [Openvpn-devel] Rewrite of OpenVPNServ.exe
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, Daniel Sim <daniel.ssq89@...277...>
Cc: openvpn-devel@lists.sourceforge.net


> Hi,
>
> On Fri, Jan 22, 2016 at 07:31:37PM +0800, Daniel Sim wrote:
>> I have rewritten openvpnserv.exe in C# to support auto-restart on
>> termination and to support suspend/resume.
>
> Can you cross-build C# binaries?  If yes, what do you need?

The "ovpnsvcsetup" (NSSM wrapper) I started writing is/was developed on=20
Linux using MonoDevelop. I only needed Windows to test the resulting=20
executable. Basically C# executables will work on any platform that has=20
a .NET runtime environment, including Linux if it has Mono installed.=20
This is quite similar to how Java works.

In this particular case the code is tightly coupled with Windows for=20
other reasons, even though in theory the code would run on Linux+Mono.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

