Message-ID: <8ff0ab0c0704051641q2a48171at40f731806a2d47e1@...278...>
Date: Thu, 5 Apr 2007 16:41:49 -0700
From: "Tim Tim" <timlikesdogs@...277...>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_51404_15784810.1175816509339"
Subject: [Openvpn-devel] Creating another network interface in windows - is
	the tap driver required?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

------=_Part_51404_15784810.1175816509339
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've been looking through the OpenVPN source code and it seems that in
Windows, the TAP-Win32 driver has to be used even if OpenVPN is creating an
IP tunnel.  I was wondering if there was another way for OpenVPN to create a
network interface without using a custom driver.  Is there something that
Windows provides?  A generic driver perhaps?

Thanks,
Tim

------=_Part_51404_15784810.1175816509339
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I&#39;ve been looking through the OpenVPN source code and it seems that in Windows, the TAP-Win32 driver has to be used even if OpenVPN is creating an IP tunnel.&nbsp; I was wondering if there was another way for OpenVPN to create a network interface without using a custom driver.&nbsp; Is there something that Windows provides?&nbsp; A generic driver perhaps?
<br><br>Thanks,<br>Tim<br>

------=_Part_51404_15784810.1175816509339--

