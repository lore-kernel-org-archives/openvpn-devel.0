From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Changing server config without disconnecting
 users
In-Reply-To: <Pine.LNX.4.61.0411032329070.26459@...210...>
Message-ID: <Pine.LNX.4.58.0411041407240.3057@...41...>
References: <Pine.LNX.4.61.0411032329070.26459@...210...>
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
Date: Thu Nov  4 13:29:13 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Mathias Sundman <mathias@...209...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 3 Nov 2004, Mathias Sundman wrote:

> As OpenVPN gets deployed at larger and larger corporations as a 
> roadwarrior VPN server, I think it becomes more and more important that 
> it's possible to change as much of the server configuration as possible 
> without having to restart the server and causing all users to be 
> disconnected.

I agree.

> One thing that I've had to do a few times is adding routes that it beeing 
> pushed to the clients. If I put the configuration in a ccd file, I can add 
> routes without restarting the server. But if I want to add a route that 
> should be pushed to all clients, I need to put it in the main config, and 
> then I can't have it updated without restarting the server, right?
> 
> How do the future look like for OpenVPN?

I agree that it makes sense to allow more fine-grained control over the
running process.

> Is using a client-connect script to generate default options the way 
> this should be handled in the future, or should we solve it some other 
> way?
> 
> Perhaps we could have a file in the ccd dir named default that could hold 
> all the client options that we today put in the main config that will be 
> re-read when a new client connects?

That's one option.  Right now, you can handle this by just adding a
"config ccd/default" to each of the ccd files, though having OpenVPN do it
automatically on some file such as "default" would be a trivial 
modification.

> I also see the need for being able to "kill" a client instance without 
> having to restart the server.
> 
> Say that you have a star site-to-site VPN build with openvpn in server 
> mode at the headquarter and an openvpn router at each branch office.
> 
> If one of the branch officies get's compromised, you would like to add the 
> branch office certificate to the CRL, and kick that instance from the 
> openvpn server. You can't wait until the compromised office disconnects on 
> his own, and you don't want to break connectivity with the other branch 
> offices.

Killing a client instance is fairly easy -- the question is how best to 
get the signal to kill client instance x into the running OpenVPN process.

This comes back to the idea of having an administrative interface to the 
running process via a TCP socket.

James


