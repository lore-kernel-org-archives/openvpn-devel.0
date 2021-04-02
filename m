Date: Fri, 2 Apr 2021 16:59:18 +0200 (CEST)
Message-Id: <202104021459.132ExIaO016257@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210401131337.3684-11-arne@...1227...>
References: <20210401131337.3684-11-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove thread_mode field of
 multi_context
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Stared at code (with "diff -w"), and since we're not doing threads and
the only value that ever is used is MC_SINGLE_THREADED, which is "1",
this effectively is not changing any code flow.  Lightly tested on 
FreeBSD client.

Your patch has been applied to the master branch.

commit 18b4a8380ba3237e870e84b25edf3f6e15145296
Author: Arne Schwabe
Date:   Thu Apr 1 15:13:33 2021 +0200

     Remove thread_mode field of multi_context

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210401131337.3684-11-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21952.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


