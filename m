Date: Mon, 9 May 2016 20:19:03 +0200 (CEST)
Message-Id: <201605091819.u49IJ39T073686@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <280154CA-9468-429B-BCAC-DB632C0AFB32@...2127...>
References: <280154CA-9468-429B-BCAC-DB632C0AFB32@...2127...>
Subject: [Openvpn-devel] [PATCH applied] Re: Prevent integration test
	timeout bc. of sudo
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
To: Jens Neuhalfen <jens@...2127...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.

Your patch has been applied to the master branch.

I found out what the issue is: your mailer chops off whitespace at the
beginning of the line, so the patch is corrupt ("^fi" instead of "^ fi"),
and after adding a blank to every single line that has no "^+", it worked.

So, please use "git send-email" - it will get this right, always.

commit f40f10ea9607934faeb2b8cd84aefff0e0790189
Author: Jens Neuhalfen
Date:   Sun May 8 18:17:48 2016 +0200

     Prevent integration test timeout bc. of sudo

     Signed-off-by: Jens Neuhalfen <jens@...2127...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <280154CA-9468-429B-BCAC-DB632C0AFB32@...2127...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11622
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


