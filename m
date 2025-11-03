Date: Mon, 3 Nov 2025 14:08:43 +0100 (CET)
Message-Id: <202511031308.5A3D8hBw001502@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251103091525.22108-1-gert@...1296...>
References: <20251103091525.22108-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: iservice: use interface index
 with netsh
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

This is a combination of master commit 5f6b5e38ca0d (WINS) and new code
for 2.6 (because master code is not using netsh commands for DNS anymore
after commit 99b35c378).  But it makes sense to apply this change to all
places 2.6 uses it.

Stared a bit at the code, compile tested, Lev has actually tested.  Ship it!

Your patch has been applied to the release/2.6 branch.

commit e02fa393985d9f2a562ed7bd51a6e0ac2557fb23 (release/2.6)
Author: Heiko Hund
Date:   Mon Nov 3 10:15:17 2025 +0100

     iservice: use interface index with netsh

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1337
     Message-Id: <20251103091525.22108-1-gert@...1296...>
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


