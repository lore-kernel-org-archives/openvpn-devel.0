Date: Tue, 20 Feb 2018 14:46:14 +0100 (CET)
Message-Id: <201802201346.w1KDkEAs068040@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1514972448-7010-1-git-send-email-steffan.karger@...1435...>
References: <1514972448-7010-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: reliable: remove
 reliable_unique_retry()
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

Acked-by: Gert Doering <gert@...1296...>

Note that this change does not actually remove the exponential backoff
logic, just some magic extra bits added to it - possibly to avoid server 
side synchronization if there are lots of clients that all have packet 
loss.  Since ovpn3 has no server side, it's not exactly surprising that
it does not have code to handle such a situation :-)

Your patch has been applied to the master branch.

commit 2af8853ec23ac33f02cce816f686702e7c6516a7
Author: Steffan Karger
Date:   Wed Jan 3 10:40:48 2018 +0100

     reliable: remove reliable_unique_retry()

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1514972448-7010-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16146.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


