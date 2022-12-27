Date: Tue, 27 Dec 2022 18:24:58 +0100 (CET)
Message-Id: <202212271724.2BRHOwpp016111@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221227140249.3524943-1-arne@...1227...>
References: <20221227140249.3524943-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Replace custom min macro and
 use more C99 style in man_remote_entry_get
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

Thanks.

Have not done much testing beyond "push to github and enjoy the green"
(but this is very nice indeed).  Well, except for the clang-asan red, 
which I did not notice before... but there is 2/2 for that :-)

Your patch has been applied to the master branch.

commit 841524153fbdcd377065e221e91ef163d83b9cc9 (master)
commit f5919a42e4a6772c4116d19cd09132bedb6d77f5 (release/2.6)
Author: Arne Schwabe
Date:   Tue Dec 27 15:02:44 2022 +0100

     Replace custom min macro and use more C99 style in man_remote_entry_get

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221227140249.3524943-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25830.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


