Message-ID: <44EF4EB1.4050804@...745...>
Date: Fri, 25 Aug 2006 15:25:37 -0400
From: Louis <louis@...745...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Feature Request for UDP connect-retry
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

First my concern:
When openvpn is not connected, the client continually sends udp packets every 2 seconds (tls-timeout).
This traffic is unnecessary/wasteful if the server is unreachable.
Ideally there would be a setting to allow udp connections to take a break.
I don't know why this has been implemented for tcp (connect-retry) but not udp.

Yes, I do realize that udp is not "connection oriented".
However from a higher level perspective the vpn is either connected or not 
(after ping-restart seconds of inactivity, openvpn brings down the tun interface).

Why isn't connect-retry allowed with udp? Openvpn is hardcoded to wait 2 seconds before the next attempt.
All justifications for supporting "connect-retry" on tcp also apply to udp as well.

Oddly I see that the connect-retry was explicitly disabled for udp.
So before I touch anything I'd like to hear feedback.
Below is a summary of the changes that I think would need to be made.

---- options.c ----
/**** Remove this check... ****/
  if (options->connect_retry_defined && options->proto != PROTO_TCPv4_CLIENT)
    msg (M_USAGE, "--connect-retry doesn't make sense unless also used with --proto tcp-client");

---- init.c ----
  switch (c->options.proto)
    {
    case PROTO_UDPv4:
/**** Remove this if... ****/
      if (proxy)
	sec = c->options.connect_retry_seconds;
      break;
    case PROTO_TCPv4_SERVER:
      sec = 1;
      break;
    case PROTO_TCPv4_CLIENT:
      sec = c->options.connect_retry_seconds;
      break;
    }



