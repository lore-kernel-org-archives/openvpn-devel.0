Date: Fri, 14 Jan 2022 18:22:34 +0100 (CET)
Message-Id: <202201141722.20EHMYu2039663@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220101160632.2250072-1-arne@...1227...>
References: <20220101160632.2250072-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove
 BUFFER_LIST_AGGREGATE_TEST test code
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

That was an easy one... "only remove things, between an #ifdef..#endif
which nobody has ever enabled in the last 10 years" :-)

Your patch has been applied to the master branch.

commit 3272a04a36aabea6885c75c65dbb2d141676f652
Author: Arne Schwabe
Date:   Sat Jan 1 17:06:32 2022 +0100

     Remove BUFFER_LIST_AGGREGATE_TEST test code

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220101160632.2250072-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23492.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


