From: Aaron Sethman <androsyn@...45...>
Subject: Re: [Openvpn-devel] Opened file descriptors in script calls
In-Reply-To: <517D2C3C-3CDF-11D7-AF54-003065B5B180@...16...>
Message-ID: <Pine.LNX.4.50.0302121341170.1299-100000@...48...>
References: <517D2C3C-3CDF-11D7-AF54-003065B5B180@...16...>
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
Date: Wed Feb 12 10:44:05 2003
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Christoph Pfisterer <cp@...16...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, 10 Feb 2003, Christoph Pfisterer wrote:
>
>    fcntl(fd, F_SETFD, FD_CLOEXEC);
>
> Ideally, one would do this for each file descriptor as it is opened.
>

Yeah I hadn't thought about that, James already added this to the CVS
tree.

Aaron

