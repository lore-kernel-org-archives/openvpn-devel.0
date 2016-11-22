Date: Tue, 22 Nov 2016 17:31:13 +0100 (CET)
Message-Id: <201611221631.uAMGVDCI034465@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1479784332-21680-1-git-send-email-selva.nair@...277...>
References: <1479784332-21680-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Handle --dhcp-option DNS6 on
	Windows using netsh
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

ACK, code looks reasonable.  Only tested for "it compiles", though.

I've taken the liberty to reformat a few lines with leading blanks into
the (still-)current style with tabs.

Your patch has been applied to the master branch.

commit 786e06ade9f5dfad8ac360499187fa8e536d15cb
Author: Selva Nair
Date:   Mon Nov 21 22:12:12 2016 -0500

     Handle --dhcp-option DNS6 on Windows using netsh

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1479784332-21680-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13193.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


