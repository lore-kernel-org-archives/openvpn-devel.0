Date: Tue, 20 May 2025 14:09:55 +0200 (CEST)
Message-Id: <202505201209.54KC9tJd034885@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250520085513.28213-1-gert@...1296...>
References: <20250520085513.28213-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: win: fix collecting DNS exclude
 data
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

Explanation sounds very logical, code looks reasonable, and Lev has 
verified that the NRPT exclude domains stuff indeed works now if
multiple domains are involved.  Great :-)

Your patch has been applied to the master branch.

commit 21c8f820d15e7891b042d33cdd989316ed987dab
Author: Heiko Hund
Date:   Tue May 20 10:55:06 2025 +0200

     win: fix collecting DNS exclude data

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20250520085513.28213-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31727.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


