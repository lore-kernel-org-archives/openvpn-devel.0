Date: Mon, 5 Mar 2018 16:47:27 +0100 (CET)
Message-Id: <201803051547.w25FlRJt055895@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1520263680-1260-1-git-send-email-selva.nair@...277...>
References: <1520263680-1260-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Management: warn about password
 only when the option is in use
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

"Oops, stupid us..." - how fortunate that Jonathan stopped us before
integrating this into 2.4.5 :-)

Acked-by: Gert Doering <gert@...1296...>

(Stared at code, and actually tested all cases)

Your patch has been applied to the master branch.

commit 5961250e776194a411a8dfc1670c5c0c73107bf8 (master)
commit 0533bd715bc3865019a718fbe512f86e0a907103 (release/2.4)
Author: Selva Nair
Date:   Mon Mar 5 10:28:00 2018 -0500

     Management: warn about password only when the option is in use

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1520263680-1260-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16631.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


