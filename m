Message-Id: <200305081808.h48I8E118094@...41...>
Subject: Re: [Openvpn-devel] Fwd: Bug#182020: openvpn needs dynamic choice on HAVE_LINUX_IF_TUN_H
From: "James Yonan" <jim@...41...>
In-Reply-To: <20030508113547.GB16370@...33...>
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
Date: Thu May  8 12:03:27 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Matthias Andree <ma+ovpnd@...31...>, OpenVPN devel <openvpn-devel@lists.sourceforge.net>

Matthias Andree <ma+ovpnd@...31...> said:

> On Thu, 08 May 2003, James Yonan wrote:
> 
> > OpenVPN's config script assumes that if 2.4 headers are present (i.e.
> > if_tun.h), then it should build for the 2.4 tun/tap driver.
> 
> This may not be true for build hosts of a distributor, who needs the
> most conservative code if he's still shipping 2.2 kernels (as Debian).

The problem is that the code that opens the tun/tap device is different for
2.2 and 2.4.  In 2.2 you open /dev/tunX where X is the unit number.  In 2.4
you open /dev/net/tun and then use the TUNSETIFF ioctl.

One thing that has been done already to ease binary compatibility is that the
failure of the TUNSETIFF ioctl is now non-fatal.

But more work may be required, perhaps even an explicit configure flag to
build a binary that will build on 2.4 but work on either 2.2 or 2.4, or
perhaps a run-time check that retries the open with 2.2 code if the TUNSETIFF
ioctl fails (as was suggested in the Debian bug report).

> > I don't completely understand why one would want to put 2.4 kernel headers on
> > a 2.2 machine, since that would tend to confuse things, and break apps that
> > depend on the userspace <-> kernel interface as defined by the kernel header
> > files.
> 
> Think "binary package": built on a 2.4 machine, installed onto a
> different 2.2 machine.

Right, but I think the reliance on the auto* tools creates some problems. 
While these tools are great for learning the capability of the target platform
at build time by analyzing source and header files, and attempting lots of
test compiles, the model breaks down when you try to move from source
portability to binary portability, because that requires that many of the
"learning the capability of the target platform" tests be performed at run
time rather than build time.

James


