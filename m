From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Fwd: Bug#182020: openvpn needs dynamic choice on HAVE_LINUX_IF_TUN_H
Message-ID: <20030508113547.GB16370@...33...>
References: <20030507190341.GA922@...30...> <200305080830.h488UZ111579@...41...>
Mime-Version: 1.0
In-Reply-To: <200305080830.h488UZ111579@...41...>
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
Date: Thu May  8 04:38:05 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

On Thu, 08 May 2003, James Yonan wrote:

> OpenVPN's config script assumes that if 2.4 headers are present (i.e.
> if_tun.h), then it should build for the 2.4 tun/tap driver.

This may not be true for build hosts of a distributor, who needs the
most conservative code if he's still shipping 2.2 kernels (as Debian).

> I don't completely understand why one would want to put 2.4 kernel headers on
> a 2.2 machine, since that would tend to confuse things, and break apps that
> depend on the userspace <-> kernel interface as defined by the kernel header
> files.

Think "binary package": built on a 2.4 machine, installed onto a
different 2.2 machine.

