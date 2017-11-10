Date: Fri, 10 Nov 2017 15:37:56 +0100 (CET)
Message-Id: <201711101437.vAAEbuVY085846@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20171110110858.11482-1-steffan@...1856...>
References: <20171110110858.11482-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Simplify and inline clear_buf()
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Makes sense, simplifies things slightly, and passes all tests :)

Your patch has been applied to the master branch.

(I'm experimenting a bit with the formatting and the patchwork headers,
so do not wonder why the remainder looks a bit atypical)

commit 3280c4c2c7064c0c6719621703f46596212396fd
Author: Steffan Karger
Date:   Fri Nov 10 12:08:58 2017 +0100

     Simplify and inline clear_buf()

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20171110110858.11482-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15796.html
     Signed-off-by: Gert Doering <gert@...1296...>


Acked-by: Gert Doering <gert@...1296...>
X-Patchwork-State: Accepted
--
kind regards,

Gert Doering


