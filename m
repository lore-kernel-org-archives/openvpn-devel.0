Date: Mon, 1 Dec 2025 12:11:01 +0100 (CET)
Message-Id: <202512011111.5B1BB1xM076924@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251201090110.5487-1-gert@...1296...>
References: <20251201090110.5487-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Set UTF-8 as the codepage using
 manifest declaration
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

I have not tested it, nor fully read the documenation and the background
info - but the explanation makes sense.  Since this does not affect code,
all I tested was "does it still build?" - and it does (mingw).

I have added a reference to GH #920, as it seems we received multiple
reports on this.

Your patch has been applied to the master branch.

commit bcc7fb2d626ac428401a7877a8cc0098999a077e
Author: Selva Nair
Date:   Mon Dec 1 10:01:03 2025 +0100

     Set UTF-8 as the codepage using manifest declaration

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1413
     Message-Id: <20251201090110.5487-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34805.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


