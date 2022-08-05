Date: Fri, 5 Aug 2022 13:01:59 +0200 (CEST)
Message-Id: <202208051101.275B1xlY052439@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220804082502.1750074-1-gert@...1296...>
References: <20220804082502.1750074-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Break 'try 256 dco devices'
 loop on EPERM
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Of course I have tested this, very scientifically, like "do two runs
with and without sufficient permissions on a DCO-enabled system" :-)

Patch has been applied to the master branch.

commit 78c02dd12bcfe7c4b4e96ea534b39ade9ee2c4d6
Author: Gert Doering
Date:   Thu Aug 4 10:25:02 2022 +0200

     Break 'try 256 dco devices' loop on EPERM

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20220804082502.1750074-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24799.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


