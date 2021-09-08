Date: Wed, 8 Sep 2021 10:26:17 +0200 (CEST)
Message-Id: <202109080826.1888QHqg096075@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210908072606.5863-1-a@...2181...>
References: <20210908072606.5863-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: compat-mode: allow user to
 specify version to be compatible with
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

Acked-by: Gert Doering <gert@...1296...>

v2 is, basically "rebase, comment fix, and unsigned int" - so taking
plaisthos' ACK and adding my own.  As discussed on IRC we have worked
on the comments to make them more understandable.

I have not actually tested this, as there is nothing to test yet
("it compiles").

Your patch has been applied to the master branch.

commit 00a622f5656380b0e21a0583048aa57b35e78a19
Author: Antonio Quartulli
Date:   Wed Sep 8 09:26:06 2021 +0200

     compat-mode: allow user to specify version to be compatible with

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210908072606.5863-1-a@...2181...>
     URL: https://www.mail-archive.com/search?l=mid&q=20210908072606.5863-1-a@...2181...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


