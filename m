Subject: Re: [Openvpn-devel] Question about TCP forking server
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1078393687.20163@...41...>
In-Reply-To: <200403041012.55329.jrh@...176...>
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
Date: Thu Mar  4 01:54:31 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Juan Rodriguez Hervella <jrh@...176...>, openvpn-devel@lists.sourceforge.net

Juan Rodriguez Hervella <jrh@...176...> said:

> Hello,
> 
> I've just realized that openVPN-1.6rc1 only supports 
> "inetd nowait" for the TLS case.
> 
> I understand that it is not possible to have "nowait" behaviour
> for multiple clients with different secrets, but it would be still possible
> to have "nowait" functionality + a single secret. Every client should
> have the same secret key which is not a good way of having security,
> but anyway...this could be a warning instead of the current message:
> "nowait functionality is only allowed for TLS". 

That's a good point, though I would argue that (a) static key sharing across
different tunnels isn't such a good idea and (b) it's easy to patch if you
don't care about the security implications.

> Even if you don't want cryptography at all, the forking server is
> an interesting feature that should be let available, imho.

2.0 will have a better arsenal of multi-client server capabilities, and for
now I'm not too keen on supporting --inetd nowait aside from the special case
that it was designed for which is TLS security over a tap interface.

James


