Subject: Re: [Openvpn-devel] Opened file descriptors in script calls
Mime-Version: 1.0 (Apple Message framework v551)
From: Christoph Pfisterer <cp@...16...>
In-Reply-To: <Pine.LNX.4.50.0302091959100.10985-100000@...48...>
Message-Id: <517D2C3C-3CDF-11D7-AF54-003065B5B180@...16...>
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
Date: Wed Feb 12 01:07:05 2003
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Aaron Sethman wrote:

> Here is a simple little replacement for system() that does close file
> descriptors.  The main issue with it is though, it ends up picking an
> arbitrary number of fds to close.  I picked closing 0 to 99.

I don't think this is necessary. Every file descriptor has a "close on 
exec" flag that you can set with fcntl(). Then, you can use plain 
system(). It should work like this:

   fcntl(fd, F_SETFD, FD_CLOEXEC);

Ideally, one would do this for each file descriptor as it is opened.

Hope this helps,
chrisp

-- 
chrisp a.k.a. Christoph Pfisterer   "A computer scientist is
cp@...16... - http://chrisp.de      someone who fixes things
PGP key & geek code available        that aren't broken."


