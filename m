Date: Tue, 17 Sep 2024 13:00:33 +0200 (CEST)
Message-Id: <202409171100.48HB0XMt043236@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240719131016.75042-1-frank@...2641...>
References: <20240719131016.75042-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Avoid SIGUSR1 to SIGHUP
 remapping when the configuration is read from stdin
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

I haven't tested this "for real", but the explanation makes sense and
the change is trivial enough.  I have word-smithed the Subject: and also
the comment line a bit.

Your patch has been applied to the master branch.

(Not really a issue on "non Android", it seems, and that one builds on
top of master only - so not applying to release/2.6)

commit b620025b9570a3d66ad3598dc22aa1b07c90fa31 (master)
Author: Arne Schwabe
Date:   Fri Jul 19 15:10:16 2024 +0200

     Avoid SIGUSR1 to SIGHUP remapping when the configuration is read from stdin

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240719131016.75042-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28941.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


