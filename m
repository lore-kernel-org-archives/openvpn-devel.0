Date: Thu, 12 Jan 2023 13:31:45 +0100 (CET)
Message-Id: <202301121231.30CCVjEu027018@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230111235052.24855-1-a@...2181...>
References: <20230111235052.24855-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: print proper message in
 case of transport disconnection
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

As discussed on IRC, there will be another patch with a license change
"really soon now".  THIS patch is important to get into rc2, so people
can test new kernel modules and get proper DCO exit code reporting.

The patch itself is trivial ("compile tested so it won't accidentially
break something").

Your patch has been applied to the master and release/2.6 branch.

commit 67c4eebdaee5b51aa041ee7ed9f697397c04a01f (master)
commit 1a97b93a347bdc061a039048935d2f6827b3b5e8 (release/2.6)
Author: Antonio Quartulli
Date:   Thu Jan 12 00:50:52 2023 +0100

     dco: print proper message in case of transport disconnection

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20230111235052.24855-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25977.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


