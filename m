Date: Wed, 23 Oct 2024 16:19:02 +0200 (CEST)
Message-Id: <202410231419.49NEJ29x032899@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241023084208.12317-1-gert@...1296...>
References: <20241023084208.12317-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: io_work: convert shift argument
 to uintptr_t
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

This code really wants improvement later on, which is promised by the
commit message... so I hope for the best.

Tested on the server testbed, and while I wouldn't trust myself to 
state "this patch does not break anything", *these* code paths are really
well-excercised there - and the patch does not break anything.

Your patch has been applied to the master branch.

commit 04c34f81be920ce57c0c886c627057cc12453b85
Author: Antonio Quartulli
Date:   Wed Oct 23 10:42:08 2024 +0200

     io_work: convert shift argument to uintptr_t

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20241023084208.12317-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29604.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


