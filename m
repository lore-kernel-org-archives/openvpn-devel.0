MIME-Version: 1.0
Date: Thu, 10 Mar 2011 17:04:48 -0800
Message-ID: <AANLkTi=gX2zHuk40P5RVtM8XmgZCp3V5_o20OeSy80N_@...278...>
From: Vineet Kumar <vineet.kumar@...277...>
Subject: [Openvpn-devel] openvpn protocol breaks proxies intercepting SSL ...
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

Hi,
  Due to the reliability layer wrapping the SSL handshake packets plus
a few non-SSL messages during tunnel-setup time the openvpn protocol
when targeted to port 443 (instead of 1194) ends up breaking if a
proxy sits in the middle and is expecting SSL procol on 443. How can I
get around this (well apart of not using 443)?

Can I run my openvpn *without* reliability layer, for example?

Also, doesn't this make openvpn different from other SSL VPNs which
advertise the fact that they are truly SSL?

Thanks in advance,

Vineet

