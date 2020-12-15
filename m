Date: Tue, 15 Dec 2020 20:21:51 +0100 (CET)
Message-Id: <202012151921.0BFJLpZH034686@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201215171600.25534-1-domagoj@...2540...>
References: <20201215171600.25534-1-domagoj@...2540...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix too early argv freeing when
 registering DNS
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
To: Domagoj Pensa <domagoj@...2540...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks.  As already said, all of a sudden it is very obvious
why it is crashing here... somewhat annoying that this wasn't
noticed before 2.5.0 release, though.

I've stared-at-code, and tested this on Win10 (ubuntu 18 / mingw build)
with a config with --register-dns. Without the patch, crash, with the 
patch, it just works.

Testing is not fully straightforward, as you can not "just run" such 
a config, but you need to either run openvpn-gui as admin, or run 
openvpn from a admin-cmd.exe - and it never OOMs for me, just never
proceeeds after "ipconfig.exe /flushdns".

Thanks :-)

Your patch has been applied to the master and release/2.5 branch.

commit ab4688e3bd78d010ccc96adec66ab552bd009328 (master)
commit 2f2df474158b6c24325a47334fc8b5eb77a69b85 (release/2.5)
Author: Domagoj Pensa
Date:   Tue Dec 15 18:16:00 2020 +0100

     Fix too early argv freeing when registering DNS

     Signed-off-by: Domagoj Pensa <domagoj@...2540...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20201215171600.25534-1-domagoj@...2540...>
     URL: https://www.mail-archive.com/search?l=mid&q=20201215171600.25534-1-domagoj@...2540...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


