From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Pre-1.3.3 beta available for testing
Message-ID: <20030219140022.GA29018@...33...>
References: <200302161913.h1GJDuf19905@...41...>
Mime-Version: 1.0
In-Reply-To: <200302161913.h1GJDuf19905@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Feb 19 06:02:11 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Sun, 16 Feb 2003, James Yonan wrote:

> 2003.02.16 -- Version 1.3.2.9
> 
> * Added --replay-persist feature to allow replay
>   protection across sessions.

The persist stuff seems to break when --disable-crypto is in effect:
/usr/include/netinet/in.h:69: warning: empty declaration
/home/ma/tmp/openvpn/openvpn.c:175: warning: `struct packet_id_persist' declared inside parameter list
/home/ma/tmp/openvpn/openvpn.c:175: warning: its scope is only this definition or declaration, which is probably not what you want.
/home/ma/tmp/openvpn/openvpn.c: In function `openvpn':
/home/ma/tmp/openvpn/openvpn.c:346: structure has no member named `packet_id_file'
/home/ma/tmp/openvpn/openvpn.c:347: structure has no member named `packet_id_file'
/home/ma/tmp/openvpn/openvpn.c: In function `main':
/home/ma/tmp/openvpn/openvpn.c:1730: storage size of `pid_persist' isn't known

-- 
Matthias Andree

