From: debbie10t <debbie10t@...277...>
Message-ID: <3fdeb614-4be9-8843-7992-2f1937402644@...277...>
Date: Wed, 18 Jan 2017 17:19:33 +0000
MIME-Version: 1.0
Subject: [Openvpn-devel] [openvpn-devel] --auth RSA-SHA512 vs --auth SHA512
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

I have following config:


** Server Win10 (as per default generally) v2.4.0
with --auth *RSA-SHA512* --ncp-disable

Log file shows:

Wed Jan 18 17:04:34 2017 us=914797 Outgoing Control Channel 
Authentication: Using 512 bit message hash '*SHA512*' for HMAC 
authentication
Wed Jan 18 17:04:34 2017 us=914797 Incoming Control Channel 
Authentication: Using 512 bit message hash '*SHA512*' for HMAC 
authentication


** Client Linux (as per default generally) v2.4.0
with --auth *RSA-SHA512*

Log file shows:

Wed Jan 18 17:05:00 2017 us=778089 Outgoing Control Channel 
Authentication: Using 512 bit message hash '*SHA512*' for HMAC 
authentication
Wed Jan 18 17:05:00 2017 us=778182 Incoming Control Channel 
Authentication: Using 512 bit message hash '*SHA512*' for HMAC 
authentication

The connection works but ..

Because there is another digest called SHA512 why does the log
*not* reflect the config correctly ? eg: hash '*RSA-SHA512*'

(This had me very confused for sometime today)

Thanks.

