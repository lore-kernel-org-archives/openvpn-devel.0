Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Thu, 3 Sep 2009 12:08:57 -0700
Message-ID: <1C795E2FCD154E46979DDDD5374B5ABE024D9766@...1261...>
In-Reply-To: <1251990413.20315.4@...1207...>
References: <1C795E2FCD154E46979DDDD5374B5ABE024D96FF@...1261...>(from
	jcullison@...1260... on Wed Sep 2 21:39:52 2009)
	<1251990413.20315.4@...1207...>
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

Correct -- a second attempt to communicate with a router whose OpenVPN
server instance is not running results in this failure.

By second attempt, I mean a second instance of the openvpn.exe run with
the command line arguments I gave in the original mail from our
specialized service.  I haven't done a huge amount of testing beyond
proving a reliable repro scenario.  I have not, for example, attempted
to interleave successful attempts within the failures to see if that
somehow clears up the problem.

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
Sent: Thursday, September 03, 2009 8:07 AM
To: John Cullison
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] Losing connectivity when OpenVPN cannot
establish tunnel under Windows

On 09/02/2009 09:39:52 PM, John Cullison wrote:

FWIW, I'm not a developer and may or may not have
useful info.  I'm just asking the questions I would
look into.  At some point I'll likely run out of
questions.

  Ping is not a valid test for
> us,
> as at least one of our firewalls blocks ICMP.

You could use a udp ping or something like telnet to port 80
just to keep the complication minimal, but you know your network best.

>=20
> I just ran ipconfig (it's like ifconfig, only for Windows) on my test
> XP
> box before and after the problem occurs, and the Default Gateway has
> indeed gone missing:

The next question is: Is the default gateway being configured
via DHCP options that are coming from OpenVPN or is there some
other reason why the default gateway is altered?  Is it the
local openvpn that's supposed to alter the gateway, the remote
end, or neither?  Your local and remote configs would help here.

>=20
> So I guess I can stop giving my guess as to what's going on and
> declare
> explicitly that something about OpenVPN is clobbering my default
> gateway
> setting when it cannot open a tunnel a second time.

Was there no OpenVPN on the other end both tests?  Does
it take 2 failed connection attempts to exhibit the
problem or just failure when there's no answer?





Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email=20
______________________________________________________________________

