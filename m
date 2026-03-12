Date: Thu, 12 Mar 2026 08:38:34 +0100 (CET)
Message-Id: <202603120738.62C7cYNq038297@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260306163202.2586-1-gert@...1296...>
References: <20260306163202.2586-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: socket: Avoid sign-compare
 issue by comparing before assignment
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

Patch looks good.  Easy enough.  BB green :-)

(Note: there is a v4 in gerrit now, and the ACK applied to v3 - but the
actual patch is identical, it just was rebased in the meantime since
the +2 was sent a while ago)

Your patch has been applied to the master branch.

commit 45f52d3aef2c014127e9a9d19368ee6c0547c1a2
Author: Frank Lichtenheld
Date:   Fri Mar 6 17:31:56 2026 +0100

     socket: Avoid sign-compare issue by comparing before assignment

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1523
     Message-Id: <20260306163202.2586-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35961.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


