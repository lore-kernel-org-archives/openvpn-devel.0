Date: Sun, 24 May 2015 21:31:57 +0200 (CEST)
Message-Id: <201505241931.t4OJVvx4026907@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1432472554-24666-1-git-send-email-gert@...1296...>
References: <1432472554-24666-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Disallow usage of
	--server-poll-timeout in --secret key mode.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
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

Patch has been applied to the master and release/2.3 branch.

(I had to add an extra #if P2MP around the MUST_BE_UNDEF(server_poll_timeout)
to avoid breaking non-P2MP compiles, but no functional change made).

commit 6478c1f359e6b0ea2046d9e2801830753e53c06a (master)
commit 7895590cf1f513f508132f8987fee8fef2759df7 (release/2.3)

Author: Gert Doering
Date:   Sun May 24 15:02:34 2015 +0200

     Disallow usage of --server-poll-timeout in --secret key mode.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <1432472554-24666-1-git-send-email-gert@...1296...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/9736


--
kind regards,

Gert Doering


