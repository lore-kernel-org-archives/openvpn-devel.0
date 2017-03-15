Date: Wed, 15 Mar 2017 21:16:19 +0100 (CET)
Message-Id: <201703152016.v2FKGJdF089008@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1489047212-31994-1-git-send-email-steffan@...1856...>
References: <1489047212-31994-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove duplicate X509 env
	variables
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  "Stared at the code and mulled over whether it's safe" (plus
ran my test set).  Tested by the reporter in trac #854, so that should
be good enough.

Your patch has been applied to the master and release/2.4 branch.

commit fd0361813cd3d5a55f3408a018e2ed776d79fef6 (master)
commit 19d6cd4e63557c983cb0ab5094688c974588c2ff (release/2.4)
Author: Steffan Karger
Date:   Thu Mar 9 09:13:32 2017 +0100

     Remove duplicate X509 env variables

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1489047212-31994-1-git-send-email-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14237.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


