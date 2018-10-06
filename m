Date: Sat, 6 Oct 2018 14:56:28 +0200 (CEST)
Message-Id: <201810061256.w96CuSjs054872@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180819200703.20362-1-gert@...1296...>
References: <20180819200703.20362-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix combination of --dev tap
 and --topology subnet across multiple platforms.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for the review.

Patch has been applied to the release/2.4 branch.

For reference: this is still broken in master, but warrants a proper
cleanup/refactor approach there.

commit 6c13e24e5709f404231632f14758ea8f6bd9ec83
Author: Gert Doering
Date:   Sun Aug 19 22:07:03 2018 +0200

     Fix combination of --dev tap and --topology subnet across multiple platforms.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20180819200703.20362-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17414.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


