Date: Mon, 9 Jan 2017 19:57:07 +0100 (CET)
Message-Id: <201701091857.v09Iv70q070240@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1483362584-28452-1-git-send-email-steffan.karger@...1435...>
References: <1483362584-28452-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove deprecated --no-iv option
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

(I was halfway done with my own review when life interfered :) - done
right, this is quite a number of code changes, but they all *do* look
very reasonable ['git show -w' helps], and my non--no-iv-using tests 
still pass...)

commit ef910e3e3a6c608a47de0b84b83c3a2331440359
Author: Steffan Karger
Date:   Mon Jan 2 14:09:44 2017 +0100

     Remove deprecated --no-iv option

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1483362584-28452-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13798.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


