From: Juan Rodriguez Hervella <jrh@...176...>
MIME-Version: 1.0
Message-Id: <200403171417.03939.jrh@...176...>
Subject: [Openvpn-devel] Status of IPv6 support in openVPN
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
Date: Wed Mar 17 05:24:29 2004
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hellooooo,

It seems that openVPN supports only IPv4 for making 
connections between the client and the server.

I'd like to be able to establish connections over IPv6,
what should be changed ? I feel quite depressed when
I look at the source code, because I think is gonna be a pain
to change the code to turn it to be AF-independent....sigh

This should have been done from the scratch...but I don't
blame anybody, specially because IPv6 is not widely used yet,
(^--^)

Is anybody willing to start doing this ?
Should we start changing everything to accomplish this task 
or is it enough to change "socket.c" ? and if we look at socket.c,
what's the best way of porting that stuff to IPv6 ? making new
functions like "gettaddr_ipv6",  "update_remote_ipv6".....or
changing the original functions to deal with both IPv4 and IPv6
at the same time ?...

Regards
 

-- 
******
JFRH
******

Passionate hatred can give meaning and purpose to an empty life.
		-- Eric Hoffer

