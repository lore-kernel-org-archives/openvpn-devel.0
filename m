From: Michael Grigoriev <mag@...34...>
Message-ID: <20020718220430.GG32636@...35...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Replay attacks
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Thu Jul 18 13:58:04 2002
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi all,

I am wondering how OpenVPN overcomes the inherit vulnerability of UDP 
comunications to "replay" or "cut-and-paste" attacks, since it is 
impossible to implement cipher block chaining.
Also, if anybody could point me to any theoretical documentation on the 
subject, it would be greatly appreciated. 
Thanks in advance,
	-- mag


