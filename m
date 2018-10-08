Date: Mon, 8 Oct 2018 20:47:13 +0200 (CEST)
Message-Id: <201810081847.w98IlDNo033724@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181008181618.8976-2-arne@...1227...>
References: <20181008181618.8976-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove AUTO_USERID feature
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

Acked-by: Gert Doering <gert@...1296...>

For the reasons given - it's code that has not been activated anywhere
in the last 5+ years, there is no way to turn it on by configure, and
it's likely not working right on half the platforms.  And less #ifdef!

I had to whack the patch to make it apply - no changes to the actual
code, but the context was full of ENABLE_MANAGEMENT where our tree has
ENABLE_CLIENT_CR.  I seem to remember that there was a patch to get rid
of the letter (because it is auto-defined #if ENABLE_MANAGEMENT) but we
seem to have lost track of it... only your tree remembers.

Your patch has been applied to the master branch.

commit 00d78cd57fa52aa5a65df1707922791e72313663
Author: Arne Schwabe
Date:   Mon Oct 8 20:16:16 2018 +0200

     Remove AUTO_USERID feature

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20181008181618.8976-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17664.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


