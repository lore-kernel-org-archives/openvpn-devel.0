From: Kenneth Porter <shiva.blacklist@...223...>
Message-ID: <Xns94F48258C2924shivawellcom@...224...>
Reply-To: shiva@...223...
Subject: [Openvpn-devel] RPM: Don't register /etc directory
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
Date: Wed May 26 08:26:02 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

I just installed openvpn-2.0_beta2-1 on Fedora Core 2 and was concerned 
that it includes /etc, /etc/rc.d and /etc/rc.d/init.d in its %files list. 
The package doesn't "own" those directories, so they shouldn't appear in 
"rpm -ql openvpn". I recommend explicitly listing those /etc contents that 
*do* belong to openvpn and not listing /etc:

/etc/openvpn
/etc/rc.d/init.d/openvpn

And thanks for providing RPM support!


