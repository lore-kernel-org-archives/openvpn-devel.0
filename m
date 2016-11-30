Date: Wed, 30 Nov 2016 09:41:23 +0100 (CET)
Message-Id: <201611300841.uAU8fNfI094175@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1480470794-6349-1-git-send-email-selva.nair@...277...>
References: <1480470794-6349-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: When parsing '--setenv opt xx
	..' make sure a third parameter is present
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

(I thought "just checking for ...&& p[2] && ..." would be nicer, but then
it falls through and just silently setenv-s "opt" to "empty", which is
not the intent...)

I have changed the reference to the Trac ticket to the newly-agreed-upon
(yesterday on IRC) standard format, which is

Trac: #799

Your patch has been applied to the master and release/2.3 branch.

commit 997795353916ffcb413a2da02dc7f210fd621954 (master)
commit 290cc3f8d50435a6ed5f2cb1ecd9056dadcc4783 (release/2.3)
Author: Selva Nair
Date:   Tue Nov 29 20:53:14 2016 -0500

     When parsing '--setenv opt xx ..' make sure a third parameter is present

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1480470794-6349-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13311.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


