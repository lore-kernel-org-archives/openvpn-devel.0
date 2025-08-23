Date: Sat, 23 Aug 2025 18:01:44 +0200 (CEST)
Message-Id: <202508231601.57NG1iTM039022@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250819212214.16218-1-gert@...1296...>
References: <20250819212214.16218-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Check message id/acked ids too
 when doing sessionid cookie checks
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

This is somewhat beyond my pay grade, but fortunately MaxF understands
these parts and has reviewed & ACKed it, and also Walter Doekes has
tested that it fixes his problem scenario.

I have tested that it does not break any of my scenarios (t_client,
t_server).  Code looks reasonable as well.

I have changed the commit message to "... where these ids *are* 0 or 1...".

Your patch has been applied to the master branch.

commit 518e122b42739b0dbb54e7169a8a3aadb4773125
Author: Arne Schwabe
Date:   Tue Aug 19 23:22:09 2025 +0200

     Check message id/acked ids too when doing sessionid cookie checks

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: MaxF <max@...2606...>
     Message-Id: <20250819212214.16218-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32626.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


