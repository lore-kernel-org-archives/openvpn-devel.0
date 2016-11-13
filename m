Date: Sun, 13 Nov 2016 18:16:02 +0100 (CET)
Message-Id: <201611131716.uADHG2ap007609@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1474085439-28766-1-git-send-email-selva.nair@...277...>
References: <1474085439-28766-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Support --block-outside-dns on
	multiple tunnels
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

ACK.

I won't claim I have deep insights in the WFP stuff (truly not), but 
the code looks reasonable otherwise - much of it is just re-shuffling
and changing to a well-known GUID -, the explanation makes sense, and
it works for me :-) - tested on Win7, with one or two active tunnels both
using block-outside-dns - in all cases, "DNS through either tunnel" 
worked, and "DNS via LAN" did not.

In addition to that, we have the positive test report from "supergregg"
in trac #718.

Your patch has been applied to the master branch.

commit fc30dc5f20d455242ed8489fb1a99446287ba9cb
Author: Selva Nair
Date:   Sat Sep 17 00:10:38 2016 -0400

     Support --block-outside-dns on multiple tunnels

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1474085439-28766-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12465.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


