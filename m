Date: Mon, 5 Oct 2020 12:36:16 +0200 (CEST)
Message-Id: <202010051036.095AaG7a076271@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201005005114.13619-1-themiron@...2010...>
References: <20201005005114.13619-1-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH applied] Re: Support X509 field list to be
 username
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
To: Vladislav Grishenko <themiron@...2010...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

Client-side tested, and lightly stared at the code.

The whitespace dragon made me add that blank after comma (but not
the other one in code not already touched by this patch) - IRC
discussion points to "sp_after_comma", which we indeed do not set
today.  We need to discuss this with the dragons :-)

After quite some deliberation I've decided that this is "new feature"
and "too late for 2.5", so not applied to release/2.5 - it was not 
an easy decision, as this could indeed be a very useful feature for
server operators running "distribution provided" binaries, which 
usually is "2.5".  OTOH, at some point we want to get 2.5.0 *out*,
and if we keep adding features, we need more RCs, and then we'll
never get there.  OTOH, again, this is a fairly isolated change - so
if enough users yell at me that THEY MUST HAVE THIS, we could put
it in 2.5.1 or 2.5.2 ("small and isolated new features can be done
in small-numbered subreleases").

Also, we do want 2.6.0 to happen "soonish" this time, like "in one
year, not in four years".  Let's see...

commit 3b04c34de140355b5b1d4ed85f7ccf1db9b0135d
Author: Vladislav Grishenko
Date:   Mon Oct 5 05:51:14 2020 +0500

     Support X509 field list to be username

     Signed-off-by: Vladislav Grishenko <themiron@...2010...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20201005005114.13619-1-themiron@...2010...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21168.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


