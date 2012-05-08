From: Adrien Bustany <adrien@...1716...>
Date: Tue,  8 May 2012 10:30:02 +0300
Message-Id: <1336462203-20226-1-git-send-email-adrien@...1716...>
Subject: [Openvpn-devel] [PATCH] Don't require DAF_INITIAL_AUTH to send
	ADDRESS/DISCONNECT messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Adrien Bustany <adrien.bustany@...1719...>

From: Adrien Bustany <adrien.bustany@...1719...>

As discussed in [1], here is a cleaned up version of my patch to fix
the sending of CLIENT:ADDRESS/CLIENT:DISCONNECT message on the
management interface when using password-less TLS certificate
authentication. It seems that DAF_INITIAL_AUTH is now unused, should I
send another patch that removes it altogether?


Adrien Bustany (1):
  management: Don't require DAF_INITIAL_AUTH to send ADDRESS/DISCONNECT
    messages

 src/openvpn/manage.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.7.8.1


