Date: Thu, 11 Apr 2019 20:32:15 +0200 (CEST)
Message-Id: <201904111832.x3BIWFRK089413@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190411074519.9982-2-chipitsine@...277...>
References: <20190411074519.9982-2-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure.ac: fix compile-time
 error in argv_testdriver
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
To: Ilya Shipitsin <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Tested on FreeBSD 12, fixes the problem.  Thanks.  

(For the record, this needs a setup where *lzo* needs extra -L/-I 
flags, but OpenSSL does *not*.  If you have your local OpenSSL in 
the same place as your local lzo, the "OpenSSL cflags" will bring 
in all the build needs, so I had a bit of trouble to figure this out)

Your patch has been applied to the master branch.

commit aa830e1217ddce8fdcf9995a13a8907124508e36
Author: Ilya Shipitsin
Date:   Thu Apr 11 12:45:19 2019 +0500

     configure.ac: fix compile-time error in argv_testdriver

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190411074519.9982-2-chipitsine@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18357.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


