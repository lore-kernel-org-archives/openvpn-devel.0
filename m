Date: Tue, 29 Nov 2016 22:07:25 +0100 (CET)
Message-Id: <201611292107.uATL7PJI006042@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1480371252-3880-1-git-send-email-steffan@...1856...>
References: <1480371252-3880-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Introduce and use
	secure_memzero() to erase secrets
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

Another ACK from me.

(David agreed on IRC that even while he is not happy with CLEAR(), it's
ok to go forward with this one as it's a somewhat independent issue)

Your patch has been applied to the master branch.

commit 009521ac8ae613084b23b9e3e5dc4ebeccd4c6c8
Author: Steffan Karger
Date:   Mon Nov 28 23:14:12 2016 +0100

     Introduce and use secure_memzero() to erase secrets

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1480371252-3880-1-git-send-email-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13278.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


