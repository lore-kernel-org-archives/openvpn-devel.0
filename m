Message-ID: <20100115001558.15125.qmail@...1287...>
Date: Fri, 15 Jan 2010 01:15:58 +0100
From: Peter Stuge <peter@...1287...>
References: <lypr5lvsu7.fsf@...1290...>
	<20100109180748.26114.qmail@...1287...>
	<lyr5pxhrp0.fsf@...1290...>
	<20100111133111.2974.qmail@...1287...>
	<lyfx6ciuhm.fsf@...1290...>
	<1263505791.23987.5@...1207...>
MIME-Version: 1.0
In-Reply-To: <1263505791.23987.5@...1207...>
Subject: Re: [Openvpn-devel] RFE: allow 'lport 0' setup for random
	port	binding
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
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Let's try some more.

Karl O. Pinc wrote:
> > no; it is because the OpenVPN client creates the same src + dst pair
> > for every connection.
> 
> Enrico is right.  It's in the IP RFC, the 2MSL (twice the maximum
> segment lifetime) rule.  (STD 5 is the right rfc?)

I agree that the statement about TCP/UDP 4-tuple is correct for the
two participating systems. They identify the connection that way, and
it's even easy to see as a user with something basic such as netstat.
Internally they of course store lots of other information related to
the connection, associated to the 4-tuple.


> I haven't otherwise been following the discussion, but if there's
> no other way to do what he wants to do with OpenVPN then
> OpenVPN is violating the RFC.

My point is that a "stateful" firewall should keep more info about
connections than just a 4-tuple. The firewall that is causing Enrico
trouble seems to not do this, since it does not recognize a new
connection if uses the same 4-tuple. To me, that actually sounds like
the textbook definitition of a _stateless_ firewall. :)

I am convinced that it is simpler to add code to OpenVPN to work
around this problem, than to fix the firewall, but I still don't
think this is really a fault in OpenVPN. I'm just another user though.


//Peter

