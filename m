From: James Yonan <jim@...3...>
Subject: Re: [Openvpn-devel] add a server feature to openvpn to share udp
 ports ?
In-Reply-To: <1025250451.1388.37.camel@...2...>
Message-ID: <Pine.LNX.4.44.0206281440380.28287-100000@...21...>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Fri Jun 28 14:01:04 2002
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Jan Johansson <jan.johansson@...1...>
Cc: openvpn-devel@lists.sourceforge.net

On 28 Jun 2002, Jan Johansson wrote:

> 
> > Is it a different problem than with an unknown ip address allowed to connect
> > to a single port ?
> > 
> > Does somebody know about an udp server forking and using different ports, with
> > code available, of course ;-).
> > 
> > I may be wrong, but I think that it is not common because in the classical 
> > udp servers all the datagramms carry an identifier, or just need a response
> > and no long term association. Thus there is no need of forking. In the
> > openvpn case, there is a need of multi packet exchange during tls auth and
> > afterwards a long term tunnel is established.
> 
> When I first read this, I thought as you did, no udp server forks like
> that. Stuff like dns-servers respond as soon as they can and drop what
> they can't handle. But then nfs-servers struck me. Whatever they do,
> when they have literally hundreds of udp clients transferring files must
> work for OpenVPN too.
> 
> I can't really see a difference between nfs handles and OpenVPN
> tls-stuff, but that might be me. =)
> I know NFS is stateless, but in this case I can't see what that might
> make nfs differ from OpenVPN in regards of handling hundreds of clients
> that all "call in" on the same udp port (2049 IIRC) and start long
> conversations with the fileserver. nfs clients might talk less in
> regards of authentications and have some u_int32 for id, but apart from
> that, they do function somewhat alike. 
> 
> Just my 0.02 euros.

Hello Jan,

The one problem with making a single thread, multi-client OpenVPN is the 
SSL/TLS authentication that can take several seconds of processor time.  
During this time, all tunnel traffic would be locked out.

This problem is currently solved in OpenVPN by threading out the SSL/TLS
authentication code, but it must be true pre-emptive threading which is
not supported on some platforms such as OpenBSD.

To do an NFS-style implementation, we would also need to add a session-ID 
to each packet which would change the protocol and increase the 
protocol overhead.

The other scalability issue would be the maximum number of tun or tap 
devices that can be allocated.

James


