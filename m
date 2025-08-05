Date: Tue, 5 Aug 2025 19:10:43 +0200 (CEST)
Message-Id: <202508051710.575HAhtc067025@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250805165906.30010-1-gert@...1296...>
References: <20250805165906.30010-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove uncrustify config and
 reformat-all.sh
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

I discussed a while (mostly with myself) whether we want to keep this,
as it is a useful tool "for the next great reformatting, at least" - but
it's way too complicated for what we need to day (like, pre-patching
files to work around uncrustify bugs is what we didn't do in a long time).

For the record, the source tree can be reformatted just fine with this:

  clang-format --verbose -i \
	`find . -name "*.[ch]" -print | egrep -v 'ovpn_dco_(linux|win)\.h'`

Your patch has been applied to the master branch.

commit 75f9bd37ae94ad2e126f68276cee52fc8af3079f
Author: Frank Lichtenheld
Date:   Tue Aug 5 18:59:00 2025 +0200

     Remove uncrustify config and reformat-all.sh

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250805165906.30010-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32543.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


