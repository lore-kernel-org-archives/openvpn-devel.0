Date: Tue, 9 Jun 2020 16:09:20 +0200 (CEST)
Message-Id: <202006091409.059E9Kqi008264@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200609080229.2564-1-gert@...1296...>
References: <20200609080229.2564-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Simplify pool size handling,
 fix possible array overrun on pool reading.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Patch has been applied to the master branch.

I have amended most whitespace as requested, and removed the 
"pool-> size = 0" initialization (not needed, indeed).

I have left the brackets on the pool size calculation as they were -
uncrustify says "that is also ok", and I find visibly grouping the 
different parts of the formula helps understanding what it does.

commit e7c0cd996f35965172c5def9531b6ab9ca10c389
Author: Gert Doering
Date:   Tue Jun 9 10:02:29 2020 +0200

     Simplify pool size handling, fix possible array overrun on pool reading.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20200609080229.2564-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20006.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


