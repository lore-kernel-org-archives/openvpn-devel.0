From: "John A. Sullivan III" <jsullivan@...525...>
Message-Id: <1136067619.2595.13.camel@...23...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Connect scripts failing with variables (glibc detected double free
 or corruption)
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
Date: Sat Dec 31 14:21:08 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Never mind.  Someone has placed conflicting versions of iptables on the
server.  These were causing the seg fault.  My apologies - John


Hello, all, and thank you for a wonderful project.  I am having some
grief with the client connect scripts.  I've included my original post
to the user list in case it adds any valuable information.  I am running
2.1 beta 7 on a fedora core 3 server in a Xen domU.

I dramatically simplified my script so that it is now only:

#!/bin/sh
IF_TYPE=tun+
PEER_ADDR=$ifconfig_pool_remote_ip
PEER_ID=$tls_id_0
PEER_CA=$tls_id_1
PEPDIR=/etc/openvpn
iptables -v -n -L VPN_ALLOW > ipt.log
#. $PEPDIR/DNRead A
exit 0

And this is what I see in the openvpn.log:

Sat Dec 31 14:25:09 2005 24.xx.xx.xx:34019 Control Channel: TLSv1,
cipher TLSv1/SSLv3 DHE-RSA-AES256-SHA, 1024 bit RSA
Sat Dec 31 14:25:09 2005 24.xx.xx.xx:34019 [TOVPNUser] Peer Connection
Initiated with 24.xx.xx.xx.:34019
/etc/openvpn/clientconn.script: line 7:  1523 Segmentation fault
iptables -v -n -L VPN_ALLOW >ipt.log
Sat Dec 31 14:25:09 2005 TOVPNUser/24.xx.xx.xx:34019 MULTI: Learn:
172.26.201.4 -> TOVPNUser/24.xx.xx.xx:34019

Notice the segmentation fault when trying to simply list iptables rules.

Here is my original post with the original script and error:

I'm pulling my hair our after hours of beating my head against the wall.
We are trying to use a client-connect script.  The script is simple:

#!/bin/sh
IF_TYPE=tun+
PEER_ADDR=$ifconfig_pool_remote_ip
PEER_ID=$tls_id_0
PEER_CA=$tls_id_1
PEPDIR=/etc/openvpn
. $PEPDIR/DNRead A
exit 0

DNRead is a more complex script that set dynamic iptables rules based
upon the user's X.509 DER_ASN.1_DN.  The script works perfectly fine
from a shell.  However, whenever openvpn tries to run it (I am running
openvpn as root for now), I get:

Fri Dec 30 03:39:45 2005 24.xx.xx.xx:34127 [TOVPNUser] Peer Connection
Initiated with 24.xx.xx.xx:34127
*** glibc detected *** double free or corruption (!prev): 0x080544e0 ***
/etc/openvpn/DNRead: line 53:  2444 Aborted                 $IPT -I
VPN_ALLOW 1 -s "$PEER_ADDR" -j RETURN
*** glibc detected *** double free or corruption (!prev): 0x08054048 ***
/etc/openvpn/DNRead: line 173:  2445 Aborted                 $IPT -$1
ACCESS_GROUPS -s "$PEER_ADDR" -i $IF_TYPE -j "${group[1]}"
Fri Dec 30 03:39:45 2005 TOVPNUser/24.xx.xx.xx:34127 MULTI: Learn:
172.26.201.4 -> TOVPNUser/24.xx.xx.xx:34127

It's almost as if it is not expanding the variables.  Here is a
pertinent excerpt from DNRead -- for testing, I even manually set the
variables:

PEER_ID=/C=US/O=Atlas/OU=Eng/CN=TOVPNUser
PEER_ADDR=172.26.201.4
PEER_CA=/C=US/O=Atlas/OU=PKI/CN=AtlasTestCA
IF_TYPE=tun+
PEPDIR=/etc/openvpn
echo "Action=$1 ID=$PEER_ID IP=$PEER_ADDR CA=$PEER_CA IF=$IF_TYPE IPT=
$(which iptables)" >> /var/openvpn/learn.log

if [[ "$1" != [AD] ]] # make sure we've passed the needed parameters
from X509updown
then
        echo "Needed action parameter not passed to iptables - aborting
connection!!!!!"
        exit 13
fi
DelimitedID="$PEER_ID/"  # We need to add a / on the end or the match
test for the last field will not work
IPT=$(which iptables)

case $1 in
        "A" )
                $IPT -I VPN_ALLOW 1 -s "$PEER_ADDR" -j RETURN
                ;;
        "D" )
                $IPT -D VPN_ALLOW -s "$PEER_ADDR" -j RETURN
                ;;
        * )
                echo "Needed action parameter not passed to iptables -
aborting connection!!!!!"
                exit 13
                ;;
esac

What in the world is going on! Thanks - John

PS - openvpn-2.1 beta7 on Fedora Core 3 in a Xen domU

-- 
John A. Sullivan III
Strategist
Senior Consultant
Atlas Group
+1 207-985-7880
jsullivan@...524...
-- 
John A. Sullivan III
Open Source Development Corporation
+1 207-985-7880
jsullivan@...525...

Financially sustainable open source development
http://www.opensourcedevel.com
-- 
John A. Sullivan III
Open Source Development Corporation
+1 207-985-7880
jsullivan@...525...

Financially sustainable open source development
http://www.opensourcedevel.com


