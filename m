From: Vasil Dimov <vd@...262...>
Message-ID: <20040810061835.GA16326@...263...>
Reply-To: vd@...262...
Mime-Version: 1.0
Subject: [Openvpn-devel] add support for floating ports only
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
Date: Wed Aug 11 07:28:01 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

This is a change request (im not sure if this is the place for it):

Configuration: UDP+TLS, tls-client is behind NAT
The NAT box (1.2.3.4) changes source port unpredictably - sometimes
it is the --port specified on the tls-client machine, sometimes not,
but its ip address is permanent.

So I want to add --remote 1.2.3.4 in the server config, but that permits
packets only from 1.2.3.4:rport and does not always work.

It would be nice if we have a feature:

--rport any (to permit packets only from --remote but from any port)
or
--float-port

Cheerz!

