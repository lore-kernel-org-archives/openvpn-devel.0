Date: Fri, 26 Sep 2025 19:11:52 +0200 (CEST)
Message-Id: <202509261711.58QHBqPX083892@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250926165151.1502-1-gert@...1296...>
References: <20250926165151.1502-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco_win: In dco_new_key,
 document size assumptions for the integer casts
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Looks reasonable... especially since there already was a (char) cast for
both KeyId and KeyLen, it was just missing the right signedness...

Your patch has been applied to the master branch.

commit e77c34370dbe0f894a2a927e18eb9f50a5820954
Author: Frank Lichtenheld
Date:   Fri Sep 26 18:51:46 2025 +0200

     dco_win: In dco_new_key, document size assumptions for the integer casts

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: MaxF <max@...2606...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1221
     Message-Id: <20250926165151.1502-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33229.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


