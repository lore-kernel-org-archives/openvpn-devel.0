Date: Wed, 3 Aug 2022 21:47:02 +0200 (CEST)
Message-Id: <202208031947.273Jl2uJ012737@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220803154049.1213-1-a@...2181...>
References: <20220803154049.1213-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: push: fix compilation with
 --disable-management and --enable-werror
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"So simple" :-) - test compiled on linux, with and without
--disable-management, and with -Werror.

Uncrustify complains that the extra lines now require an "#endif /* ..."
comment -> added.

Your patch has been applied to the master branch.

commit bb44e87f6a51318547a94a47ebc8f1523a29bb03
Author: Antonio Quartulli
Date:   Wed Aug 3 17:40:49 2022 +0200

     push: fix compilation with --disable-management and --enable-werror

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220803154049.1213-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24792.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


