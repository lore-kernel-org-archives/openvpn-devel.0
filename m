References: <49F1B322.6030705@...1032...> <1240630761l.7894l.0l@...1207...>
	<49F34D62.4000302@...1114...> <m3zle2cwmx.fsf@...1176...>
	<1240846947l.13043l.1l@...1207...> <49F6FA03.6070608@...1032...>
	<1240944303l.12737l.0l@...1207...> <49F75BBB.6000601@...1032...>
	<49F78D72.3030104@...1114...> <49F7F1B0.9080600@...1032...>
	<m3eivb361w.fsf@...1176...> <1241021810l.25454l.3l@...1207...>
From: Benny Amorsen <benny+usenet@...1175...>
Date: Wed, 29 Apr 2009 22:37:56 +0200
In-Reply-To: <1241021810l.25454l.3l@...1207...> (Karl O. Pinc's message of "Wed\,
	29 Apr 2009 11\:16\:50 -0500")
Message-ID: <m3zldz9owr.fsf@...1176...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] linux openvpn development job
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

"Karl O. Pinc" <kop@...1206...> writes:

> Doesn't the kernel care whether userspace has direct access to
> hardware?

If userspace has the right privileges, then no. The X server is an
example of this.

> Seems to me that the kernel does more than abstract hardware, it also
> protects hardware by managing concurrency and so forth and protects
> the entire system by keeping users from doing things with hardware
> that interfere with other processes. (E.g. bypassing the VM and doing
> DMA direct into somebody else's address space.) Direct userspace
> access to hardware violates these principals. Why would HW crypto
> accelerators be different and not require kernel mediation?

Kernel mediation doesn't require DMA to go through kernel space. That's
what zero copy is all about.


/Benny


