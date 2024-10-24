Date: Thu, 24 Oct 2024 19:50:52 +0200 (CEST)
Message-Id: <202410241750.49OHoqRS031488@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241024133220.4864-1-gert@...1296...>
References: <20241024133220.4864-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: t_server_null: persist test log
 files
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
To: samuli.seppanen@...277...
Cc: openvpn-devel@lists.sourceforge.net

Stared at the changes, and had a look at what the buildbots produced,
and that is now all nicely in a subdirectory (= not overwritten by
the next BB run, which made figuring out why certain runs failed 
highly annoying).

Eventually we'll need to add a cleanup job in the BB infra now... ;-)

Your patch has been applied to the master branch.

(URL is only half-useful in the commit, because mail-archive refuses to
acknowledge receipt of the mail in question - I've added the gerrit URL)

commit a3a4844a3c558eeba31f45b5a4ddcdd8b76ab897
Author: Samuli Seppänen
Date:   Thu Oct 24 15:32:17 2024 +0200

     t_server_null: persist test log files

     Signed-off-by: Samuli Seppänen <samuli.seppanen@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20241024133220.4864-1-gert@...1296...>
     URL: https://www.mail-archive.com/search?l=mid&q=20241024133220.4864-1-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


