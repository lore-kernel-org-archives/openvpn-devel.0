Date: Mon, 26 Feb 2018 19:38:56 +0100 (CET)
Message-Id: <201802261838.w1QIcuev071132@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1518006166-14285-1-git-send-email-steffan.karger@...1435...>
References: <1518006166-14285-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: mbedtls: don't use API
 deprecated in mbed 2.7
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch.

(release/2.4 due to "long term compatibility" reasoning)

Smoke-tested 2.4 vs. mbedTLS 2.7 on Gentoo ("works").

commit f22e89bd2311d3cab511e574746c6f82f1fa1a54 (master)
commit 7c913600105505bd7f539d6b4206d358b6811943 (release/2.4)
Author: Steffan Karger
Date:   Wed Feb 7 13:22:46 2018 +0100

     mbedtls: don't use API deprecated in mbed 2.7

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <1518006166-14285-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16445.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


