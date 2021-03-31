Date: Wed, 31 Mar 2021 17:22:28 +0200 (CEST)
Message-Id: <202103311522.12VFMS16063934@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1616991798-7179-1-git-send-email-selva.nair@...277...>
References: <1616991798-7179-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove automatic service
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

Your patch has been applied to the master branch.

I have stared at it for a bit (looks good) and test-compiled it on
Ubuntu 18 / MinGW (succeeded).  I have not tested it (thanks Lev).

I have added the vcxproj diff from Lev's mail, because that is
"sort of obvious" if a source file goes away completely.  We just 
forget all the time :-)

commit 2d5c437f7cf5b4f7d43c297373827d2c3597e955
Author: Selva Nair
Date:   Mon Mar 29 00:23:18 2021 -0400

     Remove automatic service

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <1616991798-7179-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21890.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


