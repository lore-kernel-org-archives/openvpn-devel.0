From: mts.spb.suxx@...450...
Reply-To: mts.spb.suxx@...450...
Message-ID: <1325448807.20060306150717@...450...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Securing the OpenVPN on windows: How to? (Repeated)
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
Date: Mon Mar  6 04:08:03 2006
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello List,

  I've installed the OpenVPN client on a winXP-SP2 box.
  I use it with OpenVPN GUI and eToken. The account is non-admin one.
  
  I'm trying to secure this installation and so far I see some strange
  things:
  1) "ta.key" file must be accessible for a non-admin user. Why? I
     thought this file is for openvpn.exe's use as the service. It
     should not be user-accessible, should it?
  2) no matter OpenVPN is v2.1b11 - it takes to add a user to the
     "Network Configuration Operators" group to be able to control the
     TAP-Win32 instance in "tap" mode. The v2.1x changelog says the
     plain mortal now is capable of controlling it. What I did wrong?

  Please CC me, I'm not subscribed to the list now.

  Thank you in advance.
     
-- 
Best regards,
 Tony             mailto:mts.spb.suxx@...450...


