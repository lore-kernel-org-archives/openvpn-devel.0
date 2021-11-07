Date: Sun, 7 Nov 2021 20:36:14 +0100 (CET)
Message-Id: <202111071936.1A7JaEZE052246@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211106180055.3073072-1-arne@...1227...>
References: <20211106180055.3073072-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Refactor early initialisation
 and uninitialisation into methods
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

Took us long enough for such a "simple" refactoring task... pesky 
language, this "C" stuff :-)

Thanks, Antonio, for verifying the sitnl stuff.

(GCC on Linux actually found and errored on the v4 bit with the missing
"&", I just did not look at the compile result because I saw the mismatch
in the diff earlier... now, no more warnings, and success on Linux/sitnl
with the v5 patch)

Your patch has been applied to the master branch.

commit 97056dbf936b01b367a66ea78cca3dadc41bdf64
Author: Arne Schwabe
Date:   Sat Nov 6 19:00:55 2021 +0100

     Refactor early initialisation and uninitialisation into methods

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20211106180055.3073072-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23110.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


