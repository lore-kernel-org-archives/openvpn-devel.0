Date: Tue, 14 Jul 2020 15:26:57 +0200 (CEST)
Message-Id: <202007141326.06EDQvT6047364@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200711093655.23686-3-arne@...1227...>
References: <20200711093655.23686-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: client-connect: Refactor
 multi_client_connect_source_ccd
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
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

Tested on the server side framework (though I still do not have a ccd/DEFAULT
file set up...) - it's not breaking anything unexpected, and the change "should"
not break DEFAULT.

Rewrapped as discussed on the list (... I have the itch to go through all the
source and rewrap all these "long assignments and the function arguments
line up in the last 20 characters of each line"... but that's a different
patch)

commit 62a840e2ab3096ded56971a1fa789fe22896ba35
Author: Fabian Knittel
Date:   Sat Jul 11 11:36:44 2020 +0200

     client-connect: Refactor multi_client_connect_source_ccd

     Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20200711093655.23686-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20287.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


