Message-ID: <50F78297.2030801@...515...>
Date: Wed, 16 Jan 2013 21:48:23 -0700
From: James Yonan <james@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN client released for iOS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Just wanted to let everyone know that the OpenVPN Connect client for iOS 
has just been released and is now available in the app store.

This is an official Apple-sanctioned OpenVPN client developed by OpenVPN 
Technologies in collaboration with Apple.

The client is based on the new C++ OpenVPN core that is also used in the 
OpenVPN Connect client for Android.  The C++ core is a portable, 
lightweight class library for building OpenVPN clients and is 100% 
protocol-compatible with the 2.x branch.

The current plan is to open-source the C++ core within the coming weeks. 
  We won't be able to open source the full iOS client because portions 
of it use Apple-proprietary APIs to integrate with the iOS VPN 
framework.  But we will be open-sourcing the core itself, which contains 
all of the code for building an OpenVPN client on Linux or Mac.

BTW, I'm going to be at FOSDEM in early February, so I look forward to 
meeting some of you there.

Enjoy,

James

