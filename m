Message-ID: <4F8D6C6F.3080403@...1698...>
Date: Tue, 17 Apr 2012 17:13:19 +0400
From: Sergey Matveychuk <sem@...1698...>
MIME-Version: 1.0
Subject: [Openvpn-devel] adding ipv6 routes wrong for tap
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Hi.

I see openvpn adds ipv6 routes always for interface not addresses. I 
think it should be like in add_route(): something like is_on_link() to 
determ if interface should be added or address.

