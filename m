Date: Tue, 31 Mar 2026 09:59:54 +0200 (CEST)
Message-Id: <202603310759.62V7xsoD058989@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260331060112.5195-1-gert@...1296...>
References: <20260331060112.5195-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_ncp: Fix type of found
 parameter of check_pull_client_ncp
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

Good catch :-) - since the other uint64 options bits patch did not go
to release/2.7, this one also doesn't.

Your patch has been applied to the master branch.

commit 3ba76022430adce09b1ead0438b5c1fe99d3e661
Author: Frank Lichtenheld
Date:   Tue Mar 31 08:01:05 2026 +0200

     ssl_ncp: Fix type of found parameter of check_pull_client_ncp

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1594
     Message-Id: <20260331060112.5195-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36364.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


