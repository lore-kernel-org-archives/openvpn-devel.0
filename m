Date: Thu, 25 Feb 2016 13:01:52 +0100 (CET)
Message-Id: <201602251201.u1PC1qiO020709@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1455937988-12414-1-git-send-email-selva.nair@...277...>
References: <1455937988-12414-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Restrict options/configs for
	startup through interactive service
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Needed functionality, and the implementation looks good to me
(I wouldn't mind more closed scrutiny by one of the more experienced
windows programmers, but since they are all too busy, my reading of
the code will have to do).  I fixed one typo ("Retrurns") in a comment.

Your patch has been applied to the master branch.

commit f3c8a04d60216d532f239c951a4694d7c1d5eaa8
Author: Selva Nair
Date:   Fri Feb 19 22:13:08 2016 -0500

     Restrict options/configs for startup through interactive service

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1455937988-12414-1-git-send-email-selva.nair@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11225
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


