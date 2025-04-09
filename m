Date: Wed, 9 Apr 2025 14:47:39 +0200 (CEST)
Message-Id: <202504091247.539Cld5d096950@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250409122409.17616-1-gert@...1296...>
References: <20250409122409.17616-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Also print key agreement when
 printing negotiated details
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

If everything works fine, nobody needs to look at this - but if things
break, extra information is always good to have.  I have stared at the
code, and compared code & compat code with the OpenSSL documentation,
and this all makes sense.  The buildbots have tested it (t_client
tests actually excercising this code, with various OpenSSL and mbedTLS
versions) and nothing breaks.

Your patch has been applied to the master branch.

Commit message adjusted ("not" inserted") as discussed.

commit 5b7a1bc34c8a3f86dfcc91b7a1aa520b1c549390
Author: Arne Schwabe
Date:   Wed Apr 9 14:24:03 2025 +0200

     Also print key agreement when printing negotiated details

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250409122409.17616-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31393.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


