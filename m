From: mts.spb.suxx@...450...
Reply-To: mts.spb.suxx@...450...
Message-ID: <423638938.20050903211124@...450...>
MIME-Version: 1.0
Subject: [Openvpn-devel] The use of lzo if OpenSSL has zlib
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
Date: Sat Sep  3 10:15:05 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello openvpn-devel,

  I did not have lzo's lib and headers before I attempted OpenVPN
  port, so I had to "./configure --disable-lzo".

  When I ported OpenSSL (long ago) - I ./configure'd it to use zlib.

  Now, when I use the resulting ssl.lib for OpenVPN (or any other
  SSL-dependent package) - I have to link with zlib as well (otherwise
  I get unresolved symbols errors).

  What if I port lzo too and use it for OpenVPN configuration?
  I will still have to link with the zlib, but which compression the
  OpenVPN daemon will use if lzo is enabled in it's configuration?

-- 
Best regards,
 Tony               mailto:mts.spb.suxx@...450...


