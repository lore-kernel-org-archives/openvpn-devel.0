From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] New feature: --ifconfig for tap devices
Message-ID: <20030907131934.GB12451@...33...>
References: <twig.1062580090.46409@...41...> <3F5B206F.5070402@...61...>
Mime-Version: 1.0
In-Reply-To: <3F5B206F.5070402@...61...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Sep  7 06:22:05 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Sun, 07 Sep 2003, julien Touche wrote:

> not sure if tap is available on openbsd (have post it previously to james)

Makes me wonder if we can tunnel between Solaris/OpenBSD on one end and
Winbloze on the other end. Windows apparently only supports "tap" ethertap,
and Solaris and OpenBSD apparently only support "tun" IP tunnels.

> some googling drives me to this thread
> http://www.monkey.org/openbsd/archive/tech/0111/msg00098.html
> and
> find /sys -iname '*tap*' returns nothing
> 
> so i'm not sure openbsd stock-kernel has tap ...

I'd think it can be done. Tried loading a "tap" or "if_tap" module or
something? FreeBSD compiles tap as a module that isn't loaded by
default, you need to manually kldload it on FreeBSD.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95

