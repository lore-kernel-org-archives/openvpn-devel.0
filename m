Date: Tue, 18 Oct 2022 13:16:57 +0200 (CEST)
Message-Id: <202210181116.29IBGvmT042009@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220909195902.2011798-1-arne@...1227...>
References: <20220909195902.2011798-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allows renegotiation only to
 start if session is fully established
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

As discussed on IRC, I have adjusted the commit message to make *me*
understand what this is about, so maybe other readers find it easier
too :-)

Tested on the server test bench, with pre-NCP p2p client and regular
p2mp clients, and renegotiating often (auth-token test bench).  No
issues observed.  (So, technically, I have not tested "the behavioural
change", just verified that nothing breaks in - borderline - normal
environments)

Your patch has been applied to the master branch.

commit f786e8a41cde31b437f20a17cb3fd122b489d6b3
Author: Arne Schwabe
Date:   Fri Sep 9 21:59:00 2022 +0200

     Allows renegotiation only to start if session is fully established

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Heiko Hund <heiko@...2662...>
     Message-Id: <20220909195902.2011798-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25162.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


