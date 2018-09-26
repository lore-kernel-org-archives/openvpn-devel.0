Date: Wed, 26 Sep 2018 12:06:08 +0200 (CEST)
Message-Id: <201809261006.w8QA68rP038606@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1536916459-25900-2-git-send-email-steffan.karger@...1435...>
References: <1536916459-25900-2-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: mbedtls: make external signing
 code generic
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Tested with a mbedTLS "t_client" run, but no "external key" tests here
- trusting Arne and Steffan on this.  Cursory review.

Your patch has been applied to the master branch.

commit 03defa3b29eafc954304532d766aff11712ff9de
Author: Steffan Karger
Date:   Fri Sep 14 11:14:18 2018 +0200

     mbedtls: make external signing code generic

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1536916459-25900-2-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17465.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


