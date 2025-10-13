Date: Mon, 13 Oct 2025 18:32:47 +0200 (CEST)
Message-Id: <202510131632.59DGWlRe084604@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251013162221.2156-1-gert@...1296...>
References: <20251013162221.2156-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: win32: Change some APIs to use
 DWORD instead of size_t
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

Straightforward enough.  The #ifdef addition surprised me first, but
that's just "the mocked function exists only on windows", so it can
be DWORD - but that data type might not be available elsewhere.

Stared-at-code, and BB is all green.  GHA will actually run a windows
test client, so in case something went wrong, we'll be told...

Your patch has been applied to the master branch.

commit c4f7b418c223ba1bd4614b3fa5ec243b385c8dc5
Author: Frank Lichtenheld
Date:   Mon Oct 13 18:22:15 2025 +0200

     win32: Change some APIs to use DWORD instead of size_t

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1269
     Message-Id: <20251013162221.2156-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59246222/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


