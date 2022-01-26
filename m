Date: Wed, 26 Jan 2022 13:53:37 +0100 (CET)
Message-Id: <202201261253.20QCrbXc057617@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220125025128.2117-2-selva.nair@...277...>
References: <20220125025128.2117-2-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix max saltlen calculation in
 cryptoapi.c
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

I won't claim to understand this, but if Arne says the math is (now)
fine, I'm happy to believe this :-) - only compile tested on 3.0.1 / Linux.

Your patch has been applied to the master branch.

commit 72daac6973c304b93e6516879948c5470d0c805a
Author: Selva Nair
Date:   Mon Jan 24 21:51:27 2022 -0500

     Fix max saltlen calculation in cryptoapi.c

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20220125025128.2117-2-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23648.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


