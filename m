Date: Thu, 18 May 2017 11:29:15 +0200 (CEST)
Message-Id: <201705180929.v4I9TFsn065413@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1494800196-8144-1-git-send-email-selva.nair@...277...>
References: <1494800196-8144-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Check for errors in the return
	value of GetModuleFileNameW()
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

ACK, thanks.  This brings 2.3 in line with 2.4/master, which is good :-)

Your patch has been applied to the release/2.3 branch.

commit c18802e2e2c5b156d1b40dab255cea273131a96c
Author: Selva Nair
Date:   Sun May 14 18:16:36 2017 -0400

     Check for errors in the return value of GetModuleFileNameW()

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1494800196-8144-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14654.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


