Date: Sun, 12 Apr 2026 18:06:30 +0200 (CEST)
Message-Id: <202604121606.63CG6UIg078970@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260407112434.5588-1-gert@...1296...>
References: <20260407112434.5588-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change type of max_clients to
 uint32_t
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

I thought this needed the previous patch (introduce max_peerid) as
basis, but it's independent - different iterating loops.  To be sure 
the combination would not introduce new warnings -> -Werror build
errors I pushed this to gerrit + GHA and let both build...

Your patch has been applied to the master branch.

commit 0e1899971e4f0e8e73b22347925aefaa19d635d2
Author: Frank Lichtenheld
Date:   Tue Apr 7 13:24:28 2026 +0200

     Change type of max_clients to uint32_t

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1564
     Message-Id: <20260407112434.5588-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36535.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


