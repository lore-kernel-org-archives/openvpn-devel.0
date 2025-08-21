Date: Thu, 21 Aug 2025 15:44:14 +0200 (CEST)
Message-Id: <202508211344.57LDiEmG042138@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250821121442.30679-1-gert@...1296...>
References: <20250821121442.30679-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add sample FFDH parameters file
 and use that in t_server_null tests
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
To: sasepp@...2705...
Cc: openvpn-devel@lists.sourceforge.net

Thanks for this.

*This* time, the change is really fully Gerrit/BB and GHA tested, and
all green.  On the last commit Gerrit didn't want to test ("no code change")
and I only pushed the 2.6 branch to GHA which does not have t_server_null
.. *sigh*

Your patch has been applied to the master branch.

commit b60ba20c3d4021762eb1366f6a40fe5c8e6a95c8
Author: Samuli Seppänen
Date:   Thu Aug 21 14:14:34 2025 +0200

     Add sample FFDH parameters file and use that in t_server_null tests

     Signed-off-by: Samuli Seppänen <sasepp@...2705...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250821121442.30679-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32643.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


