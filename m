Mime-Version: 1.0 (Apple Message framework v746.2)
Message-Id: <4042EF03-D431-4127-B9B8-BE8067855306@...583...>
From: Vilmos Nebehaj <vili@...583...>
Subject: [Openvpn-devel] Porting OpenVPN to OSF1/Tru64
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
Date: Tue Mar 21 09:24:30 2006
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hey,

anybody interested in porting OpenVPN to OSF1/Tru64? I've prepared a
tap driver for it[1], so at least layer 2 tunneling should work.

The driver's behaviour is mostly the same as the *BSD ones (although  
it's
not a port of either of them). It was tested on Digital UNIX V4.0B  
running on
a DEC 3000, and seems to work quite nicely.

[1] http://innoidea.com/~vili/osf1_tap.tar.gz

-vili

