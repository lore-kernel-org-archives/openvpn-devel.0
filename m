Message-ID: <408EA7E8.2000601@...203...>
From: Lonnie Cumberland <lonnie@...203...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Bridging Question
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
Date: Tue Apr 27 11:36:01 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Openvpn-devel@lists.sourceforge.net

Hello Al,

I was looking over the OpenVPN site documentation on the Mini-Bridging 
HOWTO and came up with a question.

It appears that on each side of the VPN that the hubs are allowing got 
masked IP on the range of 192.189.0.0/24.

Since each side is allowing the same range of IP's, doesn't this 
particular set up require that no two machines have the same IP even 
though they are on different sides of the bridge?

I would think that an IP conflict would occur if that were to happen, right?

Thanks,
Lonnie



