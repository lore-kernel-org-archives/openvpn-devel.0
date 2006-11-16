Date: Thu, 16 Nov 2006 20:26:32 +0100 (CET)
From: Mathias Sundman <mathias@...454...>
In-Reply-To: <BAY128-F3906BB243DB9DDB67F9C4B9CE90@...512...>
Message-ID: <Pine.LNX.4.64.0611162018001.8856@...210...>
References: <BAY128-F3906BB243DB9DDB67F9C4B9CE90@...512...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN GUI Icon Question
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: Alexander Littell <alexander_littell@...160...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, 16 Nov 2006, Alexander Littell wrote:

> Okay, so this technically isn't an OpenVPN question.  Sorry.  However, maybe
> someone can help me out nevertheless as the two programs are linked and I'm
> having trouble getting assistance at the openvpn.se site.
>
> Anyway, I'm trying to roll out a customized version of OpenVPN and wanted to
> change up the system tray icons from the OpenVPN GUI client.  I've replaced
> the .ico files (e.g. connected, connecting, disconnected, openvpn-gui) from
> the source files, but the old ones still seem to compile.  I've searched
> everywhere that I could to replace them but haven't had much luck.  Are they
> compiled somewhere else?

Have you recompiled OpenVPN GUI after you replaced the icons? You have 
to... If I recall correctly the icons are compiled into a resource file by 
the resource compiler (windres) and after that linked into the 
openvpn-gui.exe file.

So you will not be able to replace the icons without recompiling openvpn 
gui if you don't find any tool that can "patch" an exe file to replaces 
resources like embedded icons.

A quick google on replacing icons in exe files indicates there are such 
tools available. Here's one link:

http://533soft-icon-changer.533soft-com.qarchive.org/

//Mathias

