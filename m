Date: Sun, 19 Apr 2026 15:36:50 +0200 (CEST)
Message-Id: <202604191336.63JDaoQn055212@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260414055830.17032-1-gert@...1296...>
References: <20260414055830.17032-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: verify_x509_name: Improve the
 error message on failure
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

With all these crypto things, figuring out why something isn't working
can be hard enough as it is - without OpenVPN printing non-helpful 
details about "something else".  I have not tested this, but just
turning the if() monster into a proper switch/case and per-test
message is worth the excercise :-) - Arne has ACKed it, and BB 
confirms "no breakage".  Thanks for this.

Your patch has been applied to the master and release/2.7 branch
(fixing the bug of not printing what was really matched).

commit c610746a2cceb27032c6687a33854e9967966a39 (master)
commit 20b4ecd934d5632895e330af534f105b621e4124 (release/2.7)
Author: Selva Nair
Date:   Tue Apr 14 07:58:24 2026 +0200

     verify_x509_name: Improve the error message on failure

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1624
     Message-Id: <20260414055830.17032-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36606.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


