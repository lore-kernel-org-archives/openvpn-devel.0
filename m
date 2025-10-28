Date: Tue, 28 Oct 2025 12:46:09 +0100 (CET)
Message-Id: <202510281146.59SBk9nQ099612@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251028113310.19921-1-gert@...1296...>
References: <20251028113310.19921-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-freebsd: fix peer stats
 storage on client instances
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
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Marco, thanks for the review, and for finding the problem in the first
place :-)

I have tested this on FreeBSD 14 + DCO, and both the client and the server
side are now well-behaved and put the counter values in a nice place and
do not crash (I might have found a new bug - GH #881 - but that's not 
directly related to the counter stuff).

Your patch has been applied to the master branch.

commit dc6b75788c626add84384ac121e11b65f9e02a6a
Author: Ralf Lici
Date:   Tue Oct 28 12:33:05 2025 +0100

     dco-freebsd: fix peer stats storage on client instances

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1290
     Message-Id: <20251028113310.19921-1-gert@...1296...>
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


