From: Aaron Sethman <androsyn@...45...>
Subject: Re: [Openvpn-devel] Opened file descriptors in script calls
In-Reply-To: <200302111711.h1BHBbf18506@...41...>
Message-ID: <Pine.LNX.4.50.0302111218170.17653-100000@...48...>
References: <200302111711.h1BHBbf18506@...41...>
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
Date: Tue Feb 11 09:19:10 2003
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>
Cc: Alberto Gonzalez Iniesta <agi@...5...>, openvpn-devel@lists.sourceforge.net

On Tue, 11 Feb 2003, James Yonan wrote:
> /* Set a file descriptor to not be passed across execs */
> void
> set_cloexec (int fd)
> {
>   if (fcntl (fd, F_SETFD, FD_CLOEXEC) < 0)
>     msg (M_ERR, "Set file descriptor to FD_CLOEXEC failed");
> }
>
> Just set the FD_CLOEXEC flag on the fd and it won't be passed across the exec
> that runs the shell.

That works even better then :)

Regards,

Aaron

