Date: Mon, 17 Feb 2020 20:25:09 +0100 (CET)
Message-Id: <202002171925.01HJP9wD086602@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200217144339.3273-4-arne@...1227...>
References: <20200217144339.3273-4-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement dynamic NCP
 negotiation
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

I have fixed a few misspellings in the commit message and reformatted
it slightly (git am wraps too long lines, resulting in funny output).

Code lightly tested (t_client) and stared-at-it a bit.

The algorithm is not very smart on the client side (yet), so if you put
100x the same client cipher on the command line, it will send exactly this
as IV_CIPHERS= to the remote side.  Not understanding the TLS handshake
bits well enough, I'm not sure what is happening but the string does
get capped after about 300 characters.  So, no ill effects, except an
incomplete string (5/5 will improve that).

commit 5bb71ab599a6c382b6bdc9e9cb449d11d64353b8
Author: Arne Schwabe
Date:   Mon Feb 17 15:43:37 2020 +0100

     Implement dynamic NCP negotiation

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200217144339.3273-4-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20200217144339.3273-4-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


