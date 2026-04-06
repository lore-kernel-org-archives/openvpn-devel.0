Date: Mon, 6 Apr 2026 12:01:16 +0200 (CEST)
Message-Id: <202604061001.636A1GXD019192@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260406074729.29903-1-gert@...1296...>
References: <20260406074729.29903-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: test_packet_id: Add a check
 after malloc to ensure value is valid
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

That's an easy one - test code, no dependencies on other patches, and
tests itself :-)

Your patch has been applied to the master branch.

commit cdb0fbde266a3c3013c1354a985e82c33db8dcdb
Author: Frank Lichtenheld
Date:   Mon Apr 6 09:47:24 2026 +0200

     test_packet_id: Add a check after malloc to ensure value is valid

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1621
     Message-Id: <20260406074729.29903-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36516.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


