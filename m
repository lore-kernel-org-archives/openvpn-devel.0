Message-ID: <404B4D53.9050209@...177...>
From: Farkas Levente <lfarkas@...177...>
MIME-Version: 1.0
Subject: [Openvpn-devel] one more request for usability
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
Date: Sun Mar  7 14:19:03 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

hi,
a few mounth ago I requested the redirect-gateway feature and James was 
so kind to implement that feature. we use it but have to face another 
problem. our windows 2000/xp road-warrior clinets are not so "road 
warrior".  this means that the clinets has a DSL connection over which 
we use openvpn's vitual interface, and they always at the same place, 
but may get a new ip, but these machines always up. but unfortunately 
our ISP periodicaly (after 24 hours) disconnect the connection. and here 
comes the problems.
- we need to reconnect our client to the internet (redial the adsl 
connection).
- after we redial restart the openvpn service.
probably you don't understand why we need to restart openvpn service?! 
because we use the redirect-gateway option in openvpn! and even if we 
use the ping-restart options that's not enough. since the when we redial 
we can get a new ip. anyway this may happend even without redial! if the 
dhcp server gives a new ip for the client than the old route table and 
the old default gateway no longer valid.

what can be the solution?

a new feature for openvpn servicve:
- a new options -pre-up similar to the up script, but before the openvpn 
do anything else (which can be any kind of program which run 
synchronously with the same parameters as up).
- and the redirect-gateway's down and up part should have to run when 
restart (eg. ping-restart) is called.

in this case we can dial in this script.

our do I misunderstood something?
thanks in advance.
yours.

-- 
   Levente                               "Si vis pacem para bellum!"


