Message-ID: <20040408230310.46717.qmail@...198...>
From: gary ng <garyng2000@...109...>
Subject: Re: [Openvpn-devel] key management ?
In-Reply-To: <twig.1081462087.95165@...41...>
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
Date: Fri Apr  9 08:25:03 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>, openvpn-devel@lists.sourceforge.net

--- James Yonan <jim@...41...> wrote:
> OpenVPN currently supports intermediate CAs (one or
> multiple levels).
How would I do this in the configuration file ? I
tried to create a self-signed root CA then an
intermediate CA but if I just place the intermediate
CA as the 'ca' parameter(both node cert is signed by
it), openvpn didn't work. So I revert to sign the
nodes with the root CA and things work. That is why it
gives me the impression that only root CA is
supported.

> 
> > Another nice to have feature is to associate(or
> limit)
> > the remote IPs based on certificates. 
> 
> This is possible using the --tls-verify script which
> can examine the IP
> address and x509 name of an incoming cert and decide
> whether or not to accept it.
> 
> Some people even use this capability to do an nmap
> on the IP address to make
> sure the client hasn't been compromised, before
> allowing the connection.
> 
Thanks. that is nice to know. I am not sure if this is
the same as I envisioned. What I am working at is a
setup that depending on the remote certificate, the
openvpn server would assign a certain range of ip(the
virtual ip, not the real remote ip which I believe is
what this nmap thing is about) to the node. The
scenario behind it is that say for certain server(or
applications), I would only allow incoming connections
from a selected list of workstations/nodes(either on
vpn or simple inter network). Currently, it is worked
around in openvpn by using different ports(it is
needed anyway for serving multiple clients). However,
I see that new feature of openvpn 2.0 that would make
it possible to use one public port, so I am wondering
if it is possible to do this based on certificates so
if the certificate is 'administrator', an ip is
assigned from the admin pool etc.


__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/

