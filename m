Date: Sun, 21 Mar 2021 18:55:59 +0100 (CET)
Message-Id: <202103211755.12LHtxI4077129@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210321142538.1656-1-arne@...1227...>
References: <20210321142538.1656-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Extend verify-hash to allow
 multiple hashes
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

Your patch has been applied to the master branch.

I have not really tested it, but stared a bit at code and documentation,
and done a basic t_client test.  Haven't set up anything that could
thoroughly test this (yet!).

As discussed on IRC, I have removed the "return NULL" as suggested,
and there will be a cleanup patch to fix this function for good.

commit d1fe6d52ca066ec2d49712081d5056825c8973b2
Author: Arne Schwabe
Date:   Sun Mar 21 15:25:38 2021 +0100

     Extend verify-hash to allow multiple hashes

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210321142538.1656-1-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20210321142538.1656-1-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


