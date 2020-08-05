Date: Wed, 5 Aug 2020 15:42:25 +0200 (CEST)
Message-Id: <202008051342.075DgP01089010@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200805062548.38082-1-lstipakov@...277...>
References: <20200805062548.38082-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix compilation with
 --disable-lzo and --disable-lz4
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks.  Tested that it indeed fixes things, and that it is 
not necessary for 2.4 (compile-tested only).

Added "trac #1308" to the commit message.

Your patch has been applied to the master branch.

commit dab34fdd0639c6de8c5ca759cca00b7e60da32f1
Author: Lev Stipakov
Date:   Wed Aug 5 06:25:48 2020 +0000

     Fix compilation with --disable-lzo and --disable-lz4

     Signed-off-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200805062548.38082-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20637.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


