Date: Wed, 17 Jul 2024 22:01:08 +0200 (CEST)
Message-Id: <202407172001.46HK18DF089250@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240710140623.172829-1-frank@...2641...>
References: <20240710140623.172829-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow trailing \r and \n in
 control channel message
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

Stared at code, reviewed, and fed to my test case where the server
replies with "AUTH_FAIL,you stink\r\n" - which wasn't working with
the previous code (and was overlooked during testing), now works.

2024-07-17 20:54:32 AUTH: Received control message: AUTH_FAILED,you stink

Also, unit tests, yay :-)

Your patch has been applied to the master and release/2.6 branch
(backport will be applied to 2.5).

commit be31325e1dfdffbb152374985c2ae7b6644e3519 (master)
commit 343573990135023d855d151fcd9248e5c26d9f8b (release/2.6)
Author: Arne Schwabe
Date:   Wed Jul 10 16:06:23 2024 +0200

     Allow trailing \r and \n in control channel message

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240710140623.172829-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28910.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


