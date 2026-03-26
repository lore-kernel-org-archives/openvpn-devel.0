Date: Thu, 26 Mar 2026 15:49:28 +0100 (CET)
Message-Id: <202603261449.62QEnSHe045234@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260325124526.124049-1-frank@...2641...>
References: <20260325124526.124049-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Increase default size of
 internal hash maps to 4 * --max-clients
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

Stared at the code for a bit, and spent some thoughts on it.  Makes sense.

I haven't actually tested this beyond "BB is green".  The server testbed
will give it a bit of testing, but this is not really meaningful either
(because I have 3 clients connected at maximum)...

If the environment is very tight on memory, reducing --max-clients is
way more effective (and shrinks the hash map accordingly).

Your patch has been applied to the master and release/2.7 branch
(scalability, low impact).

commit 7b5ebf7c447db16953c9541fdd00c7aa56124fc5 (master)
commit 216c76324d2ee9221346cdfb25891e634aff2b9e (release/2.7)
Author: Arne Schwabe
Date:   Wed Mar 25 13:45:26 2026 +0100

     Increase default size of internal hash maps to 4 * --max-clients

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1563
     Message-Id: <20260325124526.124049-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36268.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


