Message-ID: <4C1A5A36.7000706@...1194...>
Date: Thu, 17 Jun 2010 10:24:06 -0700
From: Roman Vasilyev <roman@...1194...>
MIME-Version: 1.0
Subject: [Openvpn-devel] How to get destination IP address in UDP mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

my company using openvpn and we have more than 10 IP addresses on 
interface cards. And we accepting connections on all this interfaces. 
But we need to have statistics how much connections we have on IP 
address. In case of "local 0.0.0.0" I'm getting on connection string 
$local_1 "0.0.0.0", in case of default value I'm just not getting 
anything on input.

My question is: "How to get IP address to which was connection 
established in case of 'local 0.0.0.0' udp mode?"

Regards.

