Date: Thu, 27 May 2021 09:11:24 +0200 (CEST)
Message-Id: <202105270711.14R7BOiW072533@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210525173838.3969-1-selva.nair@...277...>
References: <20210525173838.3969-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Print format spec changes for
 tapctl and openvpnmscia
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

Have not tested this, just stared a bit at the code.  Did not "fix"
the "%s v%s" issue Lev pointed out as this will be fixed in the next
patch...  thanks.

(I do wonder if "support ansi builds" is really something we want, if
that makes the code so complicated - "always UNICODE" seems to be much
simpler.  What is the drawback of not supporting "ansi" builds?)

Your patch has been applied to the master branch.

commit a13f6b16b20d7cae7f1ff50d325e13e303c8d3b3
Author: Selva Nair
Date:   Tue May 25 13:38:38 2021 -0400

     Print format spec changes for tapctl and openvpnmscia

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20210525173838.3969-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22453.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


