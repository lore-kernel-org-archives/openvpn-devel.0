From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Re: New beta available + progress update
Message-ID: <20030418111418.GA14414@...33...>
References: <20030417121516.GA19479@...33...> <200304171305.h3HD5H104291@...41...>
Mime-Version: 1.0
In-Reply-To: <200304171305.h3HD5H104291@...41...>
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
Date: Fri Apr 18 04:15:09 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Thu, 17 Apr 2003, James Yonan wrote:

> The nice part about a radio link is that it is probably under your control,
> meaning that you can ensure that ICMPs get properly passed.  This allows path
> MTU discovery to work and therefore solves a lot of the harder problems.

Well,  at least for the bits that crossed a Linux 2.2 masquerade
router...

> In this case, the FRAGMENT_ENABLE code would take the Path MTU hint from the
> OS rather than trying to figure it out empirically by trial-and-error.  The
> current FRAGMENT_ENABLE code knows how to get the PMTU from Linux, but still
> needs code for other OSes.

For FreeBSD, apparently the routing table has to be queried for the MTU
-- unless someone comes up with better information. NetBSD has an
IP_RETURNMTU ioctl, I'm unsure about other systems. Seems to be
non-standard :-/

