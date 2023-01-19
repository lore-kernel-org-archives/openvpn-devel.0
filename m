Date: Thu, 19 Jan 2023 10:53:48 +0100 (CET)
Message-Id: <202301190953.30J9rmT6005033@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230112163737.1240059-1-arne@...1227...>
References: <20230112163737.1240059-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Workaround: make ovpn-dco more
 reliable
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

"Another bandaid so 2.6 does not fall apart right away"...  but anyway,
while not pretty, it seems to get the job done...

Tested on the Ubuntu 20.04 / DCO server, client and server.

Your patch has been applied to the master and release/2.6 branch.

commit f84a9fc5d4ac0f24912d239a3fccf3701926a50c (master)
commit 74a7cf9b9b9a4cb04d0bff9a85880e9bafbefca8 (release/2.6)
Author: Arne Schwabe
Date:   Thu Jan 12 17:37:37 2023 +0100

     Workaround: make ovpn-dco more reliable

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20230112163737.1240059-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25988.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


