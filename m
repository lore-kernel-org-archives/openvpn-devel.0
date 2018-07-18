Date: Wed, 18 Jul 2018 19:49:25 +0200 (CEST)
Message-Id: <201807181749.w6IHnPH5000733@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1531924073-29243-3-git-send-email-steffan.karger@...1435...>
References: <1531924073-29243-3-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make second parameter to
 reliable_send_purge() const
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
To: Gert van Dijk <gert.vandijk@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Code doesn't modify *ack, so we can as well tell the compiler about it :)

Your patch has been applied to the master branch (this is not a bugfix
and not a long-term stability thing or documentation update, so it does 
not need to go to 2.4)

commit 0f83b5e33ed63fee9f8de384e46cf93b4687c508 (master)
Author: Gert van Dijk
Date:   Wed Jul 18 16:27:52 2018 +0200

     Make second parameter to reliable_send_purge() const

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1531924073-29243-3-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/search?l=mid&q=1531924073-29243-3-git-send-email-steffan.karger@...1435...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


