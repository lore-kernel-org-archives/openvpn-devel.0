Date: Fri, 10 Jul 2020 18:04:34 +0200 (CEST)
Message-Id: <202007101604.06AG4YAQ048745@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200709101603.11941-5-arne@...1227...>
References: <20200709101603.11941-5-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Generate data channel keys
 after connect options have been parsed
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Antonio and I have stared at the code.  It has stared back.  And it 
makes sense (AND it reduces quite a bit of code!) - *and* it passes all 
client and server side tests I have, including async-auth pam.

I have fixed the whitespace mistake, and skipped the "const" hunk
(that we already did in 2/8).

Your patch has been applied to the master branch.

commit 07560d9ed11a4bfdd7f2446f2c6ff854ee091154
Author: Arne Schwabe
Date:   Thu Jul 9 12:16:00 2020 +0200

     Generate data channel keys after connect options have been parsed

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200709101603.11941-5-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20253.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


