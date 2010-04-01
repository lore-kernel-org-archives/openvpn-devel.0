Message-ID: <20100401091414.24106.qmail@...1287...>
Date: Thu, 1 Apr 2010 11:14:14 +0200
From: Peter Stuge <peter@...1287...>
References: <cover.1270060247.git.fabian.knittel@...1338...>
	<1ae7a5fdae1e6d71bb7708a4f75ff060e3237c1c.1270060247.git.fabian.knittel@...1338...>
	<20100331231158.2782.qmail@...1287...>
	<4BB45497.8040707@...1338...> <4BB46059.9080208@...1147...>
MIME-Version: 1.0
In-Reply-To: <4BB46059.9080208@...1147...>
Subject: Re: [Openvpn-devel] [PATCH 4/9] vlan: Prepend and remove
	VLAN	identifiers on outgoing and incoming frames
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Jan Just Keijser wrote:
> FYI: 802.1Q defines VLAN 1 as the 'native' LAN: all packets on VLAN 1 
> are *by definition* not encapsulated (according to my CCNA guide ;-))

802.1Q != CCNA..

Look at the spec, Table 9-2 on page 86. (100 in PDF)

VID Use
  0 "no VLAN identifier is present in the frame"
  1 "The default PVID value used for classifying frames on ingress ..
     The PVID value of a Port can be changed by management."
FFF "Reserved for implementation use."


> Perhaps we need to make sure that VID 1 means untagged ...

Any VID can be untagged. While 1 is the default it can change and
OpenVPN shouldn't really care.

One alternative approach to using tag 0 would be to introduce a
vlan-pvid (or vlan-default-tag) option to set the PVID.

But explicitly allowing tag 0 can also be useful.


//Peter

