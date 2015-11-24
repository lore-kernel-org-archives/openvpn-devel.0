Date: Tue, 24 Nov 2015 16:33:18 +0100 (CET)
Message-Id: <201511241533.tAOFXIEg085069@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1448312335-25908-1-git-send-email-steffan@...1856...>
References: <1448312335-25908-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix memory leak in add_option()
	by simplifying get_ipv6_addr
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the release/2.3 branch and cherry-picked to
master (with some minor massaging...).

commit 7e618994f3112ff4b29b9f08d087fb558636a6af (release/2.3)
commit 4f19cd1ddde3929d4a715ad59cd603eff16c66bf (master)

Author: Steffan Karger
Date:   Mon Nov 23 21:58:55 2015 +0100

     Fix memory leak in add_option() by simplifying get_ipv6_addr

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1448312335-25908-1-git-send-email-steffan@...1856...>
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


