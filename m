Date: Sun, 7 Oct 2018 10:54:22 +0200 (CEST)
Message-Id: <201810070854.w978sMQ4087392@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180413124756.5756-1-simon@...2293...>
References: <20180413124756.5756-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: Signed/unsigned warnings of
 MSVC resolved
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

I went back and read the discussion we had on v1 of this patch, so we
already agreed on this changes (or we let Simon convince us :)) - we just 
asked for a v2 because parts of v1 ("return -err") got fixed in parallel 
already. 

Test compiled on ubuntu1604/mingw.

Your patch has been applied to the master branch.

commit f755c992915b25acd114ef98e61dd9eae7ff57fe
Author: Simon Rozman
Date:   Fri Apr 13 14:47:56 2018 +0200

     Signed/unsigned warnings of MSVC resolved

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20180413124756.5756-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16756.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


