From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] 1.4.0 Released
Message-ID: <20030508113323.GA16370@...33...>
References: <200305080506.h48565110773@...41...>
Mime-Version: 1.0
In-Reply-To: <200305080506.h48565110773@...41...>
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
Date: Thu May  8 04:34:05 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Thu, 08 May 2003, James Yonan wrote:

> Release Notes:
> 
> This release adds options for persistence of replay protection information
> across sessions, pass through of IPv4 TOS bits from the TUN/TAP device to the
> UDP link, some advanced MTU control options, moderate revamping of the build
> system to improve portability, and misc bug fixes and web site additions.
> 
> Also new is a major restructuring of MTU and fragmentation handling. Much of
> this code is experimental and must be explicitly enabled by defining
> FRAGMENT_ENABLE and rebuilding.

I have sent in an update for the FreeBSD port, but it does not include
the FRAGMENT_ENABLE code, just the default options.

