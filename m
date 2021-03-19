Date: Fri, 19 Mar 2021 15:36:21 +0100 (CET)
Message-Id: <202103191436.12JEaL1H033864@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210319114631.20459-1-arne@...1227...>
References: <20210319114631.20459-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix multiple problems when
 compiling with LLVM/Windows (clang-cl)
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

Acked-by: Gert Doering <gert@...1296...>

I've stared at the code changes (look fine) and sanity checked by a 
compile on Ubuntu 18/MinGW.  According to the IRC discussions, Arne
tested MSVC with "microsoft C" as well, so no need to have that tested
again.

Your patch has been applied to the master branch.

commit 45e7d4124c258b8c5b682909b1a0e93ded4cd0cf
Author: Arne Schwabe
Date:   Fri Mar 19 12:46:31 2021 +0100

     Fix multiple problems when compiling with LLVM/Windows (clang-cl)

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210319114631.20459-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21719.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


