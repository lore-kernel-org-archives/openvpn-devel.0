From: James Yonan <jim@...3...>
Subject: Re: [Openvpn-devel] add a server feature to openvpn to share udp
 ports ?
In-Reply-To: <1024902829.1463.9.camel@...2...>
Message-ID: <Pine.LNX.4.44.0206241311040.32473-100000@...21...>
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
Date: Mon Jun 24 12:44:03 2002
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Jan Johansson <jan.johansson@...1...>
Cc: openvpn-devel@lists.sourceforge.net

On 24 Jun 2002, Jan Johansson wrote:

> On Sun, 2002-06-23 at 09:18, James Yonan wrote:
> > Hello Pat,
> > 
> > I think it's a good idea, something we're considering for the next release.
> 
> I would like to have some info then on how to stop accepting a certain
> client certificate, since I base my "expirations" on stopping the port
> in question in case I no longer want a specific certificate to be able
> to connect to the network. I mean, of course the one-port-per-person
> will work after such an addition, but for folks that get in later.

One way to stop accepting a certain client certificate is to write a 
--tls-verify script to check the certificate fields.

As far as ports are concerned, I am thinking that a forking server 
implementation of OpenVPN would listen for incoming connections on a fixed 
port, but then switch over to a dynamic port to finalize initialization of 
the session.

There are still a number of design issues that need to be worked out such 
as:

(1) How do you fork on new clients without opening yourself up to DoS 
attacks?  In order to be secure, the server would need to statelessly 
authenticate the initial packet before forking.  Tricky, because SSL/TLS 
requires a multi-packet exchange to authenticate.

(2) How does the server know which return routes to set up for the client, 
without requiring an --up script on the server for every client that might 
connect?  The client could send its routes to the server as part of the 
initial authentication exchange, but there would need to be verification 
machinery to ensure that that client could not attack the server by 
sending it malformed routes.

If anyone else has ideas on how to securely implement a forking-server, 
please share them with the list.

James


