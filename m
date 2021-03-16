From: tincanteksup <tincanteksup@...277...>
Message-ID: <b6276be3-faa4-ab16-2793-9c9a4757d582@...277...>
Date: Tue, 16 Mar 2021 23:26:18 +0000
MIME-Version: 1.0
Content-Language: en-GB
Subject: [Openvpn-devel]  Indicate correct PUSH status in log
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
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

This:

2021-03-16 23:11:15 us=420944 w-c01/10.10.201.226:53237 SENT CONTROL 
[w-c01]: 'P
USH_REPLY,comp-lzo no,explicit-exit-notify 2,route 10.33.70.1,topology 
net30,pin
g 10,ping-restart 60,ifconfig 10.33.70.6 10.33.70.5,peer-id 0,cipher 
AES-256-GCM
' (status=1)
2021-03-16 23:11:15 us=453465 w-c01/10.10.201.226:53237 PUSH: Received 
control m
essage: 'PUSH_REQUEST'

is likely to cause some confusion..

It may be worth having the client confirm receiving the PUSH,
in the server log.

Or the server indicate an initial unrequested PUSH, technically
this is not a PUSH_REPLY.

So that the log looks relatively logical.

Food for thought..
R


