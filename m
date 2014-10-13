Message-ID: <543B9FC6.3010800@...1937...>
Date: Mon, 13 Oct 2014 13:47:50 +0400
From: Alexander Pyhalov <alp@...1937...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Default gateway can't be determined on
	illumos/solaris
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello.
In openvpn 2.3.4 on illumos/Solaris clients gateway for client can't be 
determined, because default stub is used instead of 
get_default_gateway() function. This means that the following push route 
option in server config is not working:
push "route remote_host 255.255.255.255 net_gateway"

OpenVPN  client says that it doesn't know net_gateway.
The following patch mostly uses existing FreeBSD code to add 
get_default_gateway() implementation: 
https://github.com/pyhalov/oi-userland/blob/openvpn/components/openvpn/patches/get_default_gateway.patch 
.

The difference is that on Solaris there's no sa_len field.
I'm not absolutely sure that patch is correct, but as I see in route.c 
only sockaddr_in structures are supposed to be passed to NEXTADDR and 
ADVANCE macroses. This patch works for me.
-- 
Best regards,
Alexander Pyhalov,
system administrator of Southern Federal University IT department

