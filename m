Date: Tue, 27 Jun 2017 21:02:24 +0200 (CEST)
Message-Id: <201706271902.v5RJ2Owu037771@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170621211043.6490-1-steffan@...1856...>
References: <20170621211043.6490-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move adjust_power_of_2() to
 integer.h
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

Your patch has been applied to the master and release/2.4 branch.

(After some deliberation wrt release/2.4 - normally, a refactoring patch
would not go to 2.4, but this improves our testing infrastructure
and is not *rewriting* any code, just *moving* it - so I decided it 
makes much sense to have it in 2.4, and the stability risk is minimal)

commit 9fc0e963c757ffec3cc9fbf797fb7609f409c370 (master)
commit 8b55a445385ce55244cb659b8cdd0dc3156550af (release/2.4)
Author: Steffan Karger
Date:   Wed Jun 21 23:10:43 2017 +0200

     Move adjust_power_of_2() to integer.h

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20170621211043.6490-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14940.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


