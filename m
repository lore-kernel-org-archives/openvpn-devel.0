From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] [PATCH] self-test updates, fix unterminated loop
 in BSD jails
In-Reply-To: <20051104124852.GA19426@...33...>
Message-ID: <Pine.LNX.4.58.0511041241030.13189@...41...>
References: <20051104124852.GA19426@...33...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Nov  4 11:42:47 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Matthias Andree <ma+ovpnd@...31...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, 4 Nov 2005, Matthias Andree wrote:

> Greetings,
> 
> Dirk 'dinoex' Meyer reported issues when the self-test is run inside a
> FreeBSD "jail" (see below), in that t_cltsrv.sh never completes and he
> also provided logs:
> 
> | ...
> | Fri Nov  4 11:12:55 2005 UDPv4 link local (bound): 127.0.0.1:16001
> | Fri Nov  4 11:12:55 2005 UDPv4 link remote: 127.0.0.1:16000
> | Fri Nov  4 11:12:55 2005 TCP/UDP: Incoming packet rejected from A.B.C.D:16001[2], expected peer address: 127.0.0.1:16001 (allow this incoming source address/port by removing --remote or adding --float)
> 
> This is consistent with the jail(2) documentation on FreeBSD 5-STABLE.
> 
> A BSD "jail" is mainly a locked-down chroot where network communication
> is tied to a particular IP address. This IP address is configured at
> jail setup time and even "loopback" communication is remapped to the
> jail's IP. This creates the problem above.
> 
> The sample-config-files/loopback-* scripts however do not terminate
> openvpn if the connection cannot be established.
> 
> To fix this by adding --float if running in a FreeBSD, and to address
> and some minor issues (t_lpback leaves log.$$ behind if successful;
> tests should perhaps print "SKIP" rather than "FAIL" if aborted), I
> suggest the attached updates to the t_* scripts, against SVN trunk
> (version 2.0.5).  Tested on FreeBSD 5.4 i586, SUSE Linux 9.3 i686,
> Solaris 8 sun4u sparc.
> 
> Please apply to 2.0 and 2.1.

I've applied this to the 2.0 trunk in the SVN, will apply to 2.1 as well 
when I do the next 2.0 -> 2.1 merge.

James

