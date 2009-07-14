Message-ID: <4A5C362C.5020703@...1164...>
Date: Tue, 14 Jul 2009 09:39:24 +0200
From: Emrah <eka@...1164...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030806060108040601060208"
Subject: [Openvpn-devel] [Fwd: [Openvpn-users] Bridging OpenVPN on an
 interface that has multiple virtual aliases]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030806060108040601060208
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello Dev guys,

Any idea here about my issue?

Best regards,
Emrah

--------------030806060108040601060208
Content-Type: message/rfc822;
	name="[Openvpn-users] Bridging OpenVPN on an interface that has
	multiple	virtualaliases.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="[Openvpn-users] Bridging OpenVPN on an interface that has
	mu"; filename*1="ltiple	virtual aliases.eml"

Return-path: <openvpn-users-bounces@lists.sourceforge.net>
Envelope-to: eka@...1164...
Message-ID: <4A59BE01.40502@...1164...>
Date: Sun, 12 Jul 2009 12:42:09 +0200
From: Emrah <eka@...1164...>
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
MIME-Version: 1.0
To: openvpn-users@lists.sourceforge.net
X-Headers-End: 1MPwoR-0000vO-V3
Subject: [Openvpn-users] Bridging OpenVPN on an interface that has multiple
	virtual aliases
X-BeenThere: openvpn-users@lists.sourceforge.net
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: <openvpn-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-users>, 
	<mailto:openvpn-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-users>
List-Post: <mailto:openvpn-users@lists.sourceforge.net>
List-Help: <mailto:openvpn-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-users>, 
	<mailto:openvpn-users-request@lists.sourceforge.net?subject=subscribe>
Errors-To: openvpn-users-bounces@lists.sourceforge.net
X-EsetId: 3D18DF25643536326A5C
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

I am trying to use OpenVPN in bridge mode on a box that has multiple IP
aliases. eth0, eth0:0, eth0:1 and so on.
My questions are:
* What are the interfaces I am supposed to bridge? Only eth0 or
additional stuff?
* Once eth0 and tap0 become br0, how do I listen to my IP addresses like
I used to do with eth0:x?

For instance, when I bridge eth0 and I boot a virtual server that is
supposed to listen on eth0:0, my ifconfig shows br0 with the main IP and
eth0 with the alias IP address. Both are reachable but users are not
bridged anymore.


Your help will be greately appreciated. I'm stuck!

Cheers,
Emrah

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Openvpn-users mailing list
Openvpn-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-users

--------------030806060108040601060208--

