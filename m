From: Aaron Sethman <androsyn@...45...>
Subject: Re: [Openvpn-devel] MTU
In-Reply-To: <200302222247.h1MMlsf13982@...41...>
Message-ID: <Pine.LNX.4.50.0302230011580.9019-100000@...48...>
References: <200302222247.h1MMlsf13982@...41...>
MIME-Version: 1.0
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
Date: Sat Feb 22 21:16:19 2003
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net, Matthias Andree <matthias.andree@...68...>

On Sat, 22 Feb 2003, James Yonan wrote:
>  This might be handled in a way similar to --ping-restart or SIGHUP/SIGUSR1,
> where the openvpn daemon would essentially restart if the MTU size changed.
> This would be effective if path MTU changes are infrequent but still creates
> problems when --user/--group nobody is used, since the openvpn daemon will
> lack sufficient privilege to reopen and re-ifconfig the TUN/TAP device.
>

One option to deal with the --user/--group stuff is to keep a parent
process running as root with the real work being done by the child with
dropped privledges.  The parent just waits around waiting for a signal
regarding the child, and then let the parent start a new child.  Of course
if you are going to go down the IPC route, there is other fun things you
can do like passing sockets via AF_UNIX sockets.  It really depends on how
you want to do it.

Regards,

Aaron

