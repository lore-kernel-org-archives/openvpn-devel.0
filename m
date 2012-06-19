MIME-Version: 1.0
From: Igor Lopez Orbe <igorlor@...277...>
Date: Tue, 19 Jun 2012 16:29:25 +0200
Message-ID: <CAExtMO-9CcQu5=iJ5OB8xTRroFiVTmMh-a8PBcN=GF1prhOVpQ@...278...>
Subject: [Openvpn-devel] key exchange using a different physical channel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello everyone!

I would like to know if is there any "simple" way to do the key
exchange using our own method (which will use different physical
channel) in order to use the TLS control channel.
I have taken a look to the code of OpenVPN and the possible option i
found is to create key_method_3_write() and key_method_3_read() where
those functions will use my own way to get/set keys.
Could be a possible way or am i completely wrong about how to do that?

thanks in advance,

Igor

