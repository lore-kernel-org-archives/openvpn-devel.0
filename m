Date: Sun, 28 Jul 2019 22:02:03 +0200 (CEST)
Message-Id: <201907282002.x6SK23tJ081635@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1564173557-11776-1-git-send-email-selva.nair@...277...>
References: <1564173557-11776-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Correct the return value of
 cryptoapi RSA signature callbacks
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

Thanks (and thanks for sending the patch for 2.4 right with it)

I have not tested anything, but the patch looks very much "obviously
correct".

Your patch has been applied to the master branch.

commit f4ac6b780db2e0c3b60d180bd6545efe30a52059
Author: Selva Nair
Date:   Fri Jul 26 16:39:17 2019 -0400

     Correct the return value of cryptoapi RSA signature callbacks

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <1564173557-11776-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18706.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


