From: Charles Appel <cng@...375...>
Message-ID: <loom.20050427T040756-483@...171...>
References: <loom.20050418T200325-934@...171...> <Pine.LNX.4.58.0504250157260.14285@...41...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: Looking for Media Status patch
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
Date: Tue Apr 26 19:27:07 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

James Yonan <jim <at> yonan.net> writes:

> 
> You can disable the media status functionality by going to the TAP-Win32 
> driver advanced properties and setting Media Status to Always Connected.
> 
> James

Thanks.

This seems to unreliable in OpenVPN 2.0_rc1. 

There are only two options when configuring the TAP properties:
"Application Controlled" and "Always Connected".  When Always
Connected is selected it attempts to get an IP address and ends
up with the MS default 169.254.55.234.  After initiating an 
OpenVPN connection usually it loops with 
"Route: Waiting for TUN/TAP interface to come up..."

Sometimes it does connect, but then the ip address is still
the 169. address and you have to release/renew in order to
get an ip address from the OpenVPN server.  Of course, Windows
isn't great about it's release/renew procedure so sometimes
this fails.

I'd still be interested in the patch if you can dig it up; or,
any other suggestions you can think of.

Regards,
Charles



