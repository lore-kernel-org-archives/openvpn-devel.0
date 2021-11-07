Date: Sun, 7 Nov 2021 22:04:46 +0100 (CET)
Message-Id: <202111072104.1A7L4kBt053701@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211107160508.3935-1-maximilian.fillinger@...2507...>
References: <20211107160508.3935-1-maximilian.fillinger@...2507...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove unused havege.h header
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

Acked-by: Gert Doering <gert@...1296...>

That seems to be an easy one - all definitions in that file have
"havege" in their name, and "git grep havege" does not show any uses
of them.  Out it goes!

Your patch has been applied to the master branch.

commit d6d4feb4ddd0f23c3816878ff88b49b37379e31b
Author: Max Fillinger
Date:   Sun Nov 7 17:05:08 2021 +0100

     Remove unused havege.h header

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211107160508.3935-1-maximilian.fillinger@...2507...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23126.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


