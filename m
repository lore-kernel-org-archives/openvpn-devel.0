Message-ID: <5519B242.2020009@...1856...>
Date: Mon, 30 Mar 2015 22:29:54 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
Subject: [Openvpn-devel] FreeBSD+cryptodev testers wanted
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net

Hi,

See https://community.openvpn.net/openvpn/ticket/480

A bug was reported when using openvpn in daemon mode (--daemon), in 
combination with the OpenSSL cryptodev engine on FreeBSD.  The 
originally proposed patch is reported to fix the problem, but caused a 
change in the interpretation of config files, so was NAK'ed.  I proposed 
an alternative patch, which I believe will fix the issue without 
changing config file interpretation, but I do not have a set up to 
verify this.

So, is there anyone with a FreeBSD machine with cryptodev engine 
available who is willing to test the patch?

Thanks,
-Steffan

