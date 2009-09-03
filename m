Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Wed, 2 Sep 2009 19:39:52 -0700
Message-ID: <1C795E2FCD154E46979DDDD5374B5ABE024D96FF@...1261...>
In-Reply-To: <1251942611.20315.2@...1207...>
References: <1C795E2FCD154E46979DDDD5374B5ABE024D96F6@...1261...>(from
	jcullison@...1260... on Wed Sep 2 18:29:26 2009)
	<1251942611.20315.2@...1207...>
From: "John Cullison" <jcullison@...1260...>
Subject: Re: [Openvpn-devel] Losing connectivity when OpenVPN cannot
	establish tunnel under Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

Hi, Karl,

Thank you for your reply.

"Can't access anything outside the subnet" means that if I try to
connect to or interact with anything which does not share the first
three octets of my computer's IP address, it fails.  For example, using
a well known browser, if I attempt to connect to a well known website
using its IP address (say http://65.55.12.249/), the browser presents a
generic page which indicates that it cannot display the desired page;
whereas I can send e-mail messages in a certain well known e-mail client
to our well known e-mail server which happens to be running on a system
which shares the first three octets of my computer's IP address, and my
e-mail server can then forward those messages out across the Internet
for me, and I can get responses back -- but only because the e-mail
server is not affected by whatever I happen to be suffering once this
problem crops up.  Instant messaging programs are also instantly
disconnected when this problem occurs.  Ping is not a valid test for us,
as at least one of our firewalls blocks ICMP.

I just ran ipconfig (it's like ifconfig, only for Windows) on my test XP
box before and after the problem occurs, and the Default Gateway has
indeed gone missing:

Before the second failed OpenVPN connection attempt:

C:\Documents and Settings\jcullison>ipconfig

Windows IP Configuration


Ethernet adapter Wireless Network Connection 2:

        Media State . . . . . . . . . . . : Media disconnected

Ethernet adapter Local Area Connection 2:

        Connection-specific DNS Suffix  . : teltone.com
        IP Address. . . . . . . . . . . . : 192.168.1.115
        Subnet Mask . . . . . . . . . . . : 255.255.255.0
        Default Gateway . . . . . . . . . : 192.168.1.1

Ethernet adapter Local Area Connection 39:

        Media State . . . . . . . . . . . : Media disconnected

Ethernet adapter Local Area Connection 40:

        Media State . . . . . . . . . . . : Media disconnected

Ethernet adapter Local Area Connection 41:

        Media State . . . . . . . . . . . : Media disconnected

Ethernet adapter Local Area Connection 42:

        Media State . . . . . . . . . . . : Media disconnected

Ethernet adapter Local Area Connection 43:

        Media State . . . . . . . . . . . : Media disconnected

After the second failed OpenVPN connection attempt:

C:\Documents and Settings\jcullison>ipconfig

Windows IP Configuration


Ethernet adapter Wireless Network Connection 2:

        Media State . . . . . . . . . . . : Media disconnected

Ethernet adapter Local Area Connection 2:

        Connection-specific DNS Suffix  . : teltone.com
        IP Address. . . . . . . . . . . . : 192.168.1.115
        Subnet Mask . . . . . . . . . . . : 255.255.255.0
        Default Gateway . . . . . . . . . :

Ethernet adapter Local Area Connection 39:

        Media State . . . . . . . . . . . : Media disconnected

Ethernet adapter Local Area Connection 40:

        Media State . . . . . . . . . . . : Media disconnected

Ethernet adapter Local Area Connection 41:

        Media State . . . . . . . . . . . : Media disconnected

Ethernet adapter Local Area Connection 42:

        Media State . . . . . . . . . . . : Media disconnected

Ethernet adapter Local Area Connection 43:

        Media State . . . . . . . . . . . : Media disconnected


(We configure five TAP adapters for OpenVPN.)

So I guess I can stop giving my guess as to what's going on and declare
explicitly that something about OpenVPN is clobbering my default gateway
setting when it cannot open a tunnel a second time.

I opted for the devel list and not the user list because I figure I may
find myself deep in OpenVPN code in the near future, and I am looking
for any pointers, hints, suggestions, etc., by any folks who might be
knowledgeable on the Windows side of OpenVPN development.

Regards,
John Cullison
Software Engineer
Industrial Defender - Cyber Risk Protection=20
jcullison@...1260...
425-951-3567
FAX: 425-487-2288
Industrial Defender, Inc.
21312 30th Drive SE, Suite 102=20
Bothell, Washington USA 98021 21312=20
(c)Copyright 2009 Industrial Defender Inc. owns copyright content of
this document and all attachments unless otherwise indicated. All rights
reserved. Users of Industrial Defender Inc. software and tools
associated with the software such as sales & marketing collateral,
presentations, user manuals, training documentation etc. may not
republish nor reproduce in whole or in part the information, in any form
or by any means, in any manner whatsoever without the prior written
permission of Industrial Defender Inc., and any such unauthorized use
constitutes copyright infringement. An acknowledgment of the source must
be included whenever Industrial Defender Inc. material is copied or
published. If you require further information on a permitted use or
license to reproduce or republish any material, address your inquiry to
Industrial Defender Inc. 16 Chestnut Street, Suite 300, Foxborough,
Massachusetts, 02035. Any infringement of Industrial Defender Inc.
rights will result in appropriate legal action. Industrial Defender Inc.
disclaims any and all liability for any consequences which may result
from any unauthorized reproduction or use of this Work whatsoever.
www.industrialdefender.com=20



-----Original Message-----
From: Karl O. Pinc [mailto:kop@...1206...]=20
Sent: Wednesday, September 02, 2009 6:50 PM
To: John Cullison
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] Losing connectivity when OpenVPN cannot
establish tunnel under Windows

On 09/02/2009 06:29:26 PM, John Cullison wrote:

 I noticed today, however, that I had lost Internet
> connectivity once more upon attempting to create a tunnel - only this
> time (or perhaps, I was looking more closely this time?) it was when=20
> I
> was attempting to create a tunnel to a router that was not online.
> Ipconfig /renew restores the network, and sure enough, attempting to
> establish that tunnel again, when nothing is on the other side, is
> causing my networking to die the second time I attempt to establish
> the
> tunnel.  Windows seems to be forgetting about its default gateway or
> something, as I can't go anywhere outside the local subnet.

I'm sure it would be helpful to know whether it's a default
gateway problem "or something".  If you can't get the routing
tables out of Windows (about which I treasure my ignorance :-)
you could try using ping with and without domain names/dns resolution
to find out.

If it's a dns problem, and depending on what "go(ing) anywhere"
on "the local subnet" means in Windows, it could be a dns
problem.  Then see http://support.microsoft.com/kb/311218
referenced from the FAQ=20
http://openvpn.net/index.php/open-source/faq.html
(Note that this is really a dhcp Windows problem
that typically causes dns problems.)

Note that the dns problem was what your message reminded
me of.  I've not looked closely at your openvpn log
and am not familiar enough to be able to tell offhand
if it indicates any sort of problem or not.

You also might try the openvpn users list as this
could just be (as above) some sort of MS Windows bug exposed
by your particular configuration, which would be good
to post so people have a better idea of what your
doing.

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email=20
______________________________________________________________________

