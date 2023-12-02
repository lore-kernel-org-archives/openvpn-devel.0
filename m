Date: Sat, 2 Dec 2023 16:13:05 +0100 (CET)
Message-Id: <202312021513.3B2FD5ik075791@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231201123211.17619-1-frank@...2641...>
References: <20231201123211.17619-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove unused/unneeded/add
 missing defines from configure/cmake
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

Removing all that autoconf cruft that we do not really care about is
welcome :-) - a slightly more verbose commit message would have been
nice ("remove readv/writev/vsnprintf check because we do not test for
the result anyway, add getrlimit to cmake")...

Your patch has been applied to the master branch.

commit 28871fec80d143b5c3c7a4083384c33f60b927e8
Author: Arne Schwabe
Date:   Fri Dec 1 13:32:11 2023 +0100

     Remove unused/unneeded/add missing defines from configure/cmake

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20231201123211.17619-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27634.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


