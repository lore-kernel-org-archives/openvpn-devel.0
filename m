MIME-Version: 1.0
Date: Fri, 12 Jun 2009 15:32:13 +0200
From: Arne Schwabe <arne@...1227...>
Message-ID: <c91c634ea4a3bbe7dd72c9c423b68849@...1228...>
Subject: [Openvpn-devel] Packet filtering in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Openvpn-devel@lists.sourceforge.net

Hello,

I am at the moment looking to integrating packet filtering into OpenVPN. My
reason to do so, are the following: 

- Windows own Firewall does not work when routing/bridging is used
- I am not aware of a OpenSource Firewall for windows 
- Being able to do NAT without the help of the operating system can be very
nice

I have not yet looked very much at the code. But I would like to ask if
this is a feature which could go into the main OpenVPN release. If I
unterstood this correctly the OpenVPN code is currently released under GPL
but available under a non GPL license. So newly added code needs to honour
this. But BSD licensed code (eg. parts of ipfw2 or pf code) would be okay?

Arne

