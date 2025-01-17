Date: Fri, 17 Jan 2025 12:28:39 +0100 (CET)
Message-Id: <202501171128.50HBSdtA094339@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250117110422.921-1-gert@...1296...>
References: <20250117110422.921-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: IPv6 MADDR LOG: Wrap IPv6
 addresses in square brackets and print port when the port is specified
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
To: Marco Baffo <marco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for addressing this long-standing itch... not sure why we actually
added a comment "back then" explaining why we don't do something, instead
of finding a way to actually do it.

I haven't actually looked at the output, only ran client-tests - but
the code change is straightforward enough.

Your patch has been applied to the master branch.

commit 5cea4bc75e1b87ec7225a89b7cf5cadb85e77e8a
Author: Marco Baffo
Date:   Fri Jan 17 12:04:22 2025 +0100

     IPv6 MADDR LOG: Wrap IPv6 addresses in square brackets and print port when the port is specified

     Signed-off-by: Marco Baffo <marco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250117110422.921-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30480.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


