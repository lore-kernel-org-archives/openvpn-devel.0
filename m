Date: Wed, 7 Apr 2021 09:07:35 +0200 (CEST)
Message-Id: <202104070707.13777ZA8098806@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210406162518.4075-2-arne@...1227...>
References: <20210406162518.4075-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove checks for uint* types
 that are part of C99
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

I have stared at the patch a bit, and pushed it ot all the buildbots,
which are "all green".  So that's the oldest stuff I care about...
(and since we require a C99 compiler anyway, expecting C99 headers
should be reasonable nowadays)

commit 6287538039e2ba787c096272c65ec067e667d773
Author: Arne Schwabe
Date:   Tue Apr 6 18:25:15 2021 +0200

     Remove checks for uint* types that are part of C99

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210406162518.4075-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22049.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


