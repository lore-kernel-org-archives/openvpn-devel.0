Date: Wed, 1 Apr 2020 14:07:33 +0200 (CEST)
Message-Id: <202004011207.031C7XDg088851@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200331071437.12708-1-tom.van.leeuwen@...2499...>
References: <20200331071437.12708-1-tom.van.leeuwen@...2499...>
Subject: [Openvpn-devel] [PATCH applied] Re: mbedTLS: Make sure TLS session
 survives move
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
To: Tom van Leeuwen <tom.van.leeuwen@...2545...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch (bugfix).

Cherrypicking to release/2.4 caused merge conflicts due to slightly
different *context* in two places (EKM patch in master), but these were
easily fixed because very obvious.  I've tested the resulting 2.4 on
linux with mbedtls 2.19.1 and it works correctly (compiles + t_client).

commit a59e0754afd37a606d96cf24cea771ace3467289 (master)
commit 0efbd8e98eb7adfbf7ee6591941be0ff3c406d57 (release/2.4)
Author: Tom van LeeuwenS
Date:   Tue Mar 31 09:14:37 2020 +0200

     mbedTLS: Make sure TLS session survives move

     Signed-off-by: Tom van Leeuwen <tom.van.leeuwen@...2545...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20200331071437.12708-1-tom.van.leeuwen@...2499...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19661.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


