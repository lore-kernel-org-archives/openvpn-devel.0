Date: Sat, 1 Feb 2025 19:37:26 +0100 (CET)
Message-Id: <202502011837.511IbQmB007646@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250201122006.32098-1-gert@...1296...>
References: <20250201122006.32098-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Improve error reporting from
 AF_UNIX tun/tap support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Significant improvement, this :-)

Old code, when executing a nonexistant binary:

2025-02-01 19:33:56 Child process PID 7167 for afunix dead? Return code: 32512
2025-02-01 19:33:56 write to TUN/TAP : No error: 0 (fd=-1,code=0)

New code:

2025-02-01 19:35:06 Protocol options: protocol-flags tls-ekm
2025-02-01 19:35:07 ERROR: failure during write to AF_UNIX socket: could not execute external program (exit code 127)
2025-02-01 19:35:07 write to TUN/TAP : No error: 0 (fd=-1,code=0)
2025-02-01 19:35:07 read from TUN/TAP : Connection reset by peer (fd=-1,code=54)
2025-02-01 19:35:08 write to TUN/TAP : No error: 0 (fd=-1,code=0)

Killing lwipovpn while OpenVPN is active yields

2025-02-01 19:36:13 ERROR: failure during write to AF_UNIX socket: external program received signal 15
2025-02-01 19:36:13 write to TUN/TAP : No error: 0 (fd=-1,code=0)
2025-02-01 19:36:13 read from TUN/TAP : Connection reset by peer (fd=-1,code=54)

(the "write to TUN/TAP: No error" is still repeating itself for every
 packet, so dunno, maybe we should trigger something-SIG* then?  But
 that's just "room for further improvement")


Your patch has been applied to the master branch.

commit 800e8abdecd6cab62fd2074594b4e08aa72d0d82
Author: Arne Schwabe
Date:   Sat Feb 1 13:20:06 2025 +0100

     Improve error reporting from AF_UNIX tun/tap support

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250201122006.32098-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30782.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


