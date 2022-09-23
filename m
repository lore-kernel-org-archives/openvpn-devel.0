Date: Fri, 23 Sep 2022 18:32:22 +0200 (CEST)
Message-Id: <202209231632.28NGWMP7019849@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220917125811.13549-1-a@...2181...>
References: <20220917125811.13549-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: solaris/open_tun: prevent crash
 when dev is empty string
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

I'm not sure how "dev" can ever be an empty string here, but if it
can be one, we shouldn't crash :-) - subjected to t_client tests on
OpenIndiana 2019 that excercise --dev tun/tap and --dev tun3/tap3

Trying around a bit, I came up with "openvpn --dev '' --dev-type tun"
which would indeed end up there with an empty *dev, leading to *ptr
pointing to random garbage (no crash here, but that's more luck in
stack layout I'd say).  With the bugfix, I get

2022-09-23 18:31:28 dev=8043451, ptr=8043451, *dev='00', *dev='', *ptr=''

.. better.

Your patch has been applied to the master branch.

commit cec4353b60bc74a2d8d78ca6b8b6f9fae02e92eb
Author: Antonio Quartulli
Date:   Sat Sep 17 14:58:11 2022 +0200

     solaris/open_tun: prevent crash when dev is empty string

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220917125811.13549-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25235.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


