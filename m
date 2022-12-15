Date: Thu, 15 Dec 2022 08:30:31 +0100 (CET)
Message-Id: <202212150730.2BF7UVDe040743@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221214153414.12671-1-maximilian.fillinger@...2507...>
References: <20221214153414.12671-1-maximilian.fillinger@...2507...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix message for too long
 tls-crypt-v2 metadata
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
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Arne Schwabe <arne@...1227...>

Thanks for the v2.  It's identical to v1, except for the off-by-one,
and removing the now-obsolete macro, so I've taken the ACK from Arne on v1.

I have only test-compiled (and looked at the diffs).

Your patch has been applied to the master and release/2.6 branch.

commit 860bf4bf9248077259690a518925ecc14da4b320 (master)
commit f8e576eba078acb1279506d8b6f334667dea1585 (release/2.6)
Author: Max Fillinger
Date:   Wed Dec 14 16:34:14 2022 +0100

     Fix message for too long tls-crypt-v2 metadata

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20221214153414.12671-1-maximilian.fillinger@...2507...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25694.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


