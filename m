Date: Thu, 1 Dec 2016 09:21:29 +0100 (CET)
Message-Id: <201612010821.uB18LTdC072864@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1480542696-7123-1-git-send-email-selva.nair@...277...>
References: <1480542696-7123-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not restart dns client
	service as a part of --register-dns processing
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

ACK, thanks.

Code looks good, and test compiles.  Have not test-run yet but do not
expect any surprises there.

I have added a Changes.rst entry (someone *might* notice and wonder if
this was intentional :) ) and updated doc/openvpn.8 and the help text
in options.c which both used to list all the commands run...

Your patch has been applied to the master branch.

commit fb56058a98dcc81b34cffbdc46417d672b8926e1
Author: Selva Nair
Date:   Wed Nov 30 16:51:36 2016 -0500

     Do not restart dns client service as a part of --register-dns processing

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1480542696-7123-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13331.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


