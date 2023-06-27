Date: Tue, 27 Jun 2023 18:03:22 +0200 (CEST)
Message-Id: <202306271603.35RG3MUr097646@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230620135310.94455-2-frank@...2641...>
References: <20230620135310.94455-2-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: add basic CMake based build
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

I understand that this is work in progress, does not change anything,
and is not feature-complete either (but due to shared authorship, this
is a separate commit).  It is not packaged into tarballs either.

According to one of Frank's latest mails, this patch series does not
work with 2.6 - so I'm going to apply all of it to master only, and if
we decide "we want this in 2.6", we can do a proper backport of the
relevant bits, in useful chunks.

Your patch has been applied to the master branch.

commit 0134184012dd46ec44cbca7eb3ece39037ae0bfa
Author: Arne Schwabe
Date:   Tue Jun 20 15:53:06 2023 +0200

     add basic CMake based build

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20230620135310.94455-2-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26758.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


