Date: Fri, 24 Jul 2020 22:30:33 +0200 (CEST)
Message-Id: <202007242030.06OKUXSI061381@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200724195634.493-1-lstipakov@...277...>
References: <20200724195634.493-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Improve Windows version
 detection with manifest
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks for the v2.  Builds nicely with "./build-snapshot" on my 
ubuntu 18.04 builder now.  I have not tested the resulting installer.

The code change for the C code look good to me.

Thanks for the explanation about the manifest ("I've heard that 
before, but I won't ever become a windows programmer, it seems"),
and I assume that the .vcproj adaptions are related to that.

You are the expert on MSVC building, so if you say this is needed,
and it does not look harmful, I'm fine :-)

Your patch has been applied to the master branch.

commit a7d6977e6e14c512c89e51886b235af153cd4841
Author: Lev Stipakov
Date:   Fri Jul 24 22:56:34 2020 +0300

     Improve Windows version detection with manifest

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200724195634.493-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20580.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


