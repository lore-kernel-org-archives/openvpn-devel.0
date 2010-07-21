Message-ID: <4C464918.9050902@...1147...>
Date: Wed, 21 Jul 2010 03:10:48 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <20100714150851.GL8941@...1152...>
In-Reply-To: <20100714150851.GL8941@...1152...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Problem with installation on
	Windows7 (64bit)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Ralf Hildebrandt <Ralf.Hildebrandt@...1152...>
Cc: Openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Hi Ralf,

Ralf Hildebrandt wrote:
> After installation of openvpn-2.1.1, I was able to start openvpn-gui as
> NORMAL user (not admin). No problems there.
>
> But in order to actually *use* openvpn, I have to start openvpn-gui via
> "run as admin". When I would do that, openvpn gui would report:
>
> CreateProcess failed, exe='C:\Program Files\OpenVPN\bin\openvpn.exe'
> cmdline='openvpn --version' dir='c:\Program Files\OpenVPN\bin'
>
> Alas, this path does indeed not exist, since OpenVPN installed itself
> into:
>
> C:\Program Files (x86)\OpenVPN
> not
> C:\Program Files\OpenVPN
>
> so I deinstalled everything and during reinstallation I overrode the
> default installation path to:
>
> C:\Program Files\OpenVPN
>
> and after that it would work, even when run as admin. 
>
> What's wrong here? Why does it choose C:\Program Files (x86)\OpenVPN
> during installation but expects C:\Program Files\OpenVPN during runtime?
>
>   
see for example
  
http://www.sevenforums.com/general-discussion/30857-installing-program-files-x86.html

openvpn is a 32bit program using a 64bit driver; the windows 7 installer 
decides to place openvpn in the 32bit folder unless you override this.
I guess the proper solution is to build a 64bit version of openvpn for 
windows Vista/7/2003 64bit
(I'm including the -devel list to see if anybody has any comments about 
that :))

cheers,

JJK



