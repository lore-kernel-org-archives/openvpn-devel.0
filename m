From: dumas@...26... (Patrice DUMAS - DOCT)
Subject: Re: [Openvpn-devel] add a server feature to openvpn to share udp ports ?
Message-ID: <20020627171625.F6806@...27...>
References: <1024902829.1463.9.camel@...2...> <Pine.LNX.4.44.0206241311040.32473-100000@...21...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.44.0206241311040.32473-100000@...21...>; from jim@...3... on Mon, Jun 24, 2002 at 01:42:05PM -0600
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
Date: Thu Jun 27 08:26:01 2002
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

I don't know if my idea are really pertinent pertinent, I haven't deeply read
the code nor have a lot of experience, but here they are.

> As far as ports are concerned, I am thinking that a forking server 
> implementation of OpenVPN would listen for incoming connections on a fixed 
> port, but then switch over to a dynamic port to finalize initialization of 
> the session.

I have read in the libc info page that udp didn't provide listen/accept.
Thus it seems to me that moving to another port would imply telling back
the client the new port. Am I wrong ?
 
> (1) How do you fork on new clients without opening yourself up to DoS 
> attacks?  In order to be secure, the server would need to statelessly 
> authenticate the initial packet before forking.  Tricky, because SSL/TLS 

Why is it required to fork upon first packet reception ?

> requires a multi-packet exchange to authenticate.

I think there are 2 distinct possible Dos possible:
1) an attacker may connect many times, to get the server to fork, and open a
lot of ports
2) the tls authentication takes time and requires multi packets exchange. Thus
an attacker may try a lot of tls authentications to use server resources.
This point may be mitigated by the --tls-auth trick, but in case it is not,
the combination with forking may lead to a lot of resources used.

For 1), I can see 2 possible solutions. 

The first would be to fork only after the tls authentication has been done. 
In that case there are 2 possibilities:
* do tls authentications sequentially. The design could be simple, but the
clients would have to wait for the completion of the tls athentication.
* do tls authentications in parallell. It may be possible to have more
than one tls_multi object, each one associated with a thread (or multiple
calls in case there is no thread). The gain may no be consequent because 
crypto is cpu intensive and not io intensive, and all the clients could
end up waiting approximately the same time.

The second would be to put a limit on the nuber of forked child engaged in 
tls authentication which haven't succeded yet. This would imply having a 
possibility of communication between childs and the server process, to 
notice when the tls auth is done.

> (2) How does the server know which return routes to set up for the client, 
> without requiring an --up script on the server for every client that might 
> connect?  The client could send its routes to the server as part of the 
> initial authentication exchange, but there would need to be verification 
> machinery to ensure that that client could not attack the server by 
> sending it malformed routes.

Is it a different problem than with an unknown ip address allowed to connect
to a single port ?

Does somebody know about an udp server forking and using different ports, with
code available, of course ;-).

I may be wrong, but I think that it is not common because in the classical 
udp servers all the datagramms carry an identifier, or just need a response
and no long term association. Thus there is no need of forking. In the
openvpn case, there is a need of multi packet exchange during tls auth and
afterwards a long term tunnel is established.

Pat

