From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] TAP-Win32 Link problem
In-Reply-To: <loom.20041125T155449-644@...171...>
Message-ID: <Pine.LNX.4.58.0411251005380.27895@...41...>
References: <loom.20041125T155449-644@...171...>
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
Date: Thu Nov 25 09:07:03 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Moshe <makeit_quick@...109...>
Cc: openvpn-devel@lists.sourceforge.net

Try --up-delay.

James

On Thu, 25 Nov 2004, Moshe wrote:

> (posted comment before but didn't see it - so I'm re sending)
> 
> It looks like the TAP Adapter gets its link up signal as soon as the socket is 
> being connected.
> Several problems with that:
> - There is no actual logical connection between the parties.
>   It could be another fake process, an intermediate proxy, or a bad version of 
> OpenSSL, bad keys... etc.
>   The user sees the adapter link brought up and down - and this is misleading 
> as the user thinks that the far end was indeed connected but something 
> happened.
> - As soon as the TAP adapter link is up, Windows starts to send packets.
>   Normally this is fine, but if the other end is not yet connected (using 
> proxy), the socket buffer starts to fill for no good reason
> 
> Looks like there needs to be a logical handshake before link is brought up.
> 
> My 2 cents
> Moshe
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now. 
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

