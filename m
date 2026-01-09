Date: Fri, 9 Jan 2026 18:20:14 +0100 (CET)
Message-Id: <202601091720.609HKE2t018333@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260109163514.23051-1-gert@...1296...>
References: <20260109163514.23051-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure.ac: Clean up systemd
 support
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

This makes sense, and now is the right time :-) - I have stared a bit
at the change, and BB has tested it.  Another #ifdef gone!

Your patch has been applied to the master branch.

commit 50a6b663e49410456ef6497346dc4ec149d50b0b
Author: Frank Lichtenheld
Date:   Fri Jan 9 17:35:08 2026 +0100

     configure.ac: Clean up systemd support

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1463
     Message-Id: <20260109163514.23051-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35203.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


