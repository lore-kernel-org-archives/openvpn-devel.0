Message-ID: <4F36E202.3010503@...1549...>
Date: Sat, 11 Feb 2012 22:47:46 +0100
From: Freek Dijkstra <public@...1549...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Cipher problem on Mac OS X
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I'm sorry for cross-posting, this perhaps should have gone to -devel
instead of -users in the first place.

I have a problem running OpenVPN from the git master branch on Mac OS X
(checkout 3a90edbd194140eef51c245edfcf9afc0ecb2d13). (It runs fine on
FreeBSD). There seems to be a problem with the default Blowfish (BF-CBC)
cipher:

% git clone git://openvpn.git.sourceforge.net/gitroot/openvpn/openvpn.git
% cd openvpn
% autoreconf -i -v
% ./configure --with-lzo-headers=/opt/local/include \
  --with-lzo-lib=/opt/local/lib
% make
% make check
...
Sat Feb 11 22:46:37 2012 OpenVPN 2.x-master x86_64-apple-darwin11.2.0
[SSL (OpenSSL)] [LZO2] [eurephia] [MH] [PF_INET6] [IPv6 payload
20110522-1 (2.2.0)] built on Feb 11 2012
Sat Feb 11 22:46:37 2012 Cipher 'BF-CBC' uses a mode not supported by
OpenVPN in your current configuration.  CBC mode is always supported,
while CFB and OFB modes are supported only when using SSL/TLS
authentication and key exchange mode, and when OpenVPN has been built
with ALLOW_NON_CBC_CIPHERS.
Sat Feb 11 22:46:37 2012 Exiting due to fatal error
FAIL: t_lpback.sh
...

On the other hand, BF-CBC cipher seem normally compiled in:

% /usr/local/sbin/openvpn --show-ciphers
...
BF-CBC 128 bit default key (variable)
...

openvpn is compiled with openssl 1.0.0f.
From otool -l:
         name /opt/local/lib/libssl.1.0.0.dylib (offset 24)
         name /opt/local/lib/libcrypto.1.0.0.dylib (offset 24)
         name /opt/local/lib/liblzo2.2.dylib (offset 24)
         name /usr/lib/libSystem.B.dylib (offset 24)

I just tried to see if this error was always there. It seems to be
introduced with the refactoring by Adriaan de Jong last year.

Revision e8c950f12dfd6187f084fb06b6fe6e57c030bdad works fine
Revision 670f9dd91aed7ac435b79c0e28e49fa7c256642c fails with the above
error.

Revision 670f9dd91aed7ac435b79c0e28e49fa7c256642c has the following log
message:
Refactored cipher key types

Signed-off-by: Adriaan de Jong <dejong@...1435...>
Acked-by: David Sommerseth <davids@...1347...>
Acked-by: James Yonan <james@...515...>
Signed-off-by: David Sommerseth <davids@...1347...>


Is the above intended behaviour or a bug?

Any advise how to further dissect this?


Regards,
Freek Dijkstra

