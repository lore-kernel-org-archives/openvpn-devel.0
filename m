Message-Id: <200302111711.h1BHBbf18506@...41...>
Subject: Re: [Openvpn-devel] Opened file descriptors in script calls
From: "James Yonan" <jim@...41...>
In-Reply-To: <Pine.LNX.4.50.0302101550090.32300-100000@...48...>
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
Date: Tue Feb 11 09:13:04 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Aaron Sethman <androsyn@...45...>, Alberto Gonzalez Iniesta <agi@...5...>
Cc: openvpn-devel@lists.sourceforge.net

Aaron Sethman <androsyn@...45...> said:

> On Mon, 10 Feb 2003, Alberto Gonzalez Iniesta wrote:
> 
> >
> > Hi,
> >
> > Again, I'm no C hacker, but I think this should be better:
> >
> > for(x = 3; x < 100; x++)
> >
> > Since the first 3 fds (stdin, stdout and stderr) should be kept open.
> >
> Wasn't sure if stdin, stdout and stderr needed to be left open or not in
> this case.  Obviously this is an easy fix :)

Actually, I was just thinking what a pain to have to reimplement system() just
to close a few fds.  There must be a better way, and as it turns out, there is:

/* Set a file descriptor to not be passed across execs */
void
set_cloexec (int fd)
{
  if (fcntl (fd, F_SETFD, FD_CLOEXEC) < 0)
    msg (M_ERR, "Set file descriptor to FD_CLOEXEC failed");
}

Just set the FD_CLOEXEC flag on the fd and it won't be passed across the exec
that runs the shell.

I already wrote the patch and it's in the CVS.

James


