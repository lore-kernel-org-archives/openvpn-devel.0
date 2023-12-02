Date: Sat, 2 Dec 2023 17:40:34 +0100 (CET)
Message-Id: <202312021640.3B2GeY8P087200@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231128103950.62407-1-frank@...2641...>
References: <20231128103950.62407-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove compat versionhelpers.h
 and remove cmake/configure check for it
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

Since this is sort of an extention to "The Cmake Patch" that is in
release/2.6, I've also applied this patch there.  Tested via GHA builds
and local MinGW build.

Your patch has been applied to the master and release/2.6 branch.

commit a68595a582b2c6c220b4f4502753d5f4154000d8 (master)
commit 19bfb7021430ecac9946fa5eab2da03cff4718c1 (release/2.6)
Author: Arne Schwabe
Date:   Tue Nov 28 11:39:50 2023 +0100

     Remove compat versionhelpers.h and remove cmake/configure check for it

     Acked-by: Frank Lichtenheld <frank@...2641...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20231128103950.62407-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27573.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


