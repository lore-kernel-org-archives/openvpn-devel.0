From: Eric Thorpe <eric@...1918...>
Message-ID: <28a15eaf-16e5-0756-82c7-29035ec15382@...1918...>
Date: Fri, 21 Aug 2020 10:56:14 +1000
MIME-Version: 1.0
Content-Language: en-US
Subject: [Openvpn-devel] AUTH_PENDING from client-pending-auth query
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
To: openvpn-devel@lists.sourceforge.net

Hi All,

Arne might be best to answer this but wasn't sure. I've been testing out 
the client-pending-auth/cr-response stuff recently and had a question. 
Currently, the first thing that happens from the client-pending-auth 
management command is the client is sent an AUTH_PENDING control channel 
notification, however this isn't handled, all the client receives is a 
log message about an unknown push notification. Is there a plan for this 
AUTH_PENDING message to do something in the future, is it for 
compatibility for something else or is it simply extraneous and can be 
removed?

Cheers,
Eric

-- 
---
Eric Thorpe
SparkLabs Developer
https://www.sparklabs.com
https://twitter.com/sparklabs
support@...1918...


