From: "Dick St.Peters" <stpeters@...181...>
Message-ID: <16471.22876.6664.647226@...182...>
In-Reply-To: <405756E7.3090906@...180...>
References: <405756E7.3090906@...180...>
Subject: [Openvpn-devel] Re: [Openvpn-users] no chance trying openvpn
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
Date: Tue Mar 16 13:16:37 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: pi <list@...180...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

pi writes:
> Installation is correct, but when I try to launch openvpn, I got the 
> following in /var/log/messages:
 ...
> Mar 16 20:30:05 moulinsart modprobe: modprobe: Can't locate module 
> char-major-10-200

Put "alias char-major-10-200 tun" in /etc/modules.conf

--
Dick St.Peters, stpeters@...181... 

