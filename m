Message-ID: <a6589cd6041109200272d3b962@...278...>
From: Hans Fugal <fugalh@...277...>
Reply-To: Hans Fugal <fugalh@...277...>
Subject: Re: [Openvpn-devel] IANA has approved a unique port number for OpenVPN
In-Reply-To: <twig.1100040511.60533@...41...>
Mime-Version: 1.0
References: <twig.1100040511.60533@...41...>
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
Date: Tue Nov  9 20:03:03 2004
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

ASAP, I think. As has been mentioned it's trivial to forward the port
with a firewall. I agree being able to listen on multiple ports would
be slick too.


On Tue, 9 Nov 2004 22:48:31 -0000, James Yonan <jim@...41...> wrote:
> 
> I just got a note from IANA confirming that they've assigned TCP/UDP port 1194
> to OpenVPN.
> 
> You can see the allocation here in the global list:
> 
> http://www.iana.org/assignments/port-numbers
> 
> The question, of course, is when should we switch over to using 1194 as the
> default? (We're currently using 5000 which doesn't really belong to us.)
> 
> I'd be inclined to make the change before 2.0 final is released.  Any other
> opinions?
> 
> Of course, this will be moot for those of you who select your own port number
> using the "port" directive.  It's only a question of changing the default from
> 5000 to 1194 when no "port" directive is specified.
> 
> James
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for FREE
> LinuxWorld Reader's Choice Award Winner for best database on Linux.
> http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 


-- 
De gustibus non disputandum est.

