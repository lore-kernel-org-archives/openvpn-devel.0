Message-ID: <4DC93E4C.5070606@...1147...>
Date: Tue, 10 May 2011 15:31:56 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4DC936F3.6000509@...1458...>
In-Reply-To: <4DC936F3.6000509@...1458...>
Subject: Re: [Openvpn-devel] Fwd: OpenVPN netsh.exe patch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Seth Mos <seth.mos@...1458...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Seth,

Seth Mos wrote:
> Here is the tun.c patch for correction of the netsh.exe commands.
>
>
>
> I've confirmed that the patch works on Windows XP SP2 and Windows 7.
>
> Patch!
> http://iserv.nl/files/pfsense/0001-Change-the-netsh.exe-command-from-add-to-set-.-Th.patch
>
>   

please explain the rationale behind this patch: is something wrong when
using 'ipv6 add address' ? why is the patch applied only for IPv6
addresses?

thx,

JJK


