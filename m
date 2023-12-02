Date: Sat, 2 Dec 2023 16:23:12 +0100 (CET)
Message-Id: <202312021523.3B2FNCu5076412@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231201111846.15097-1-frank@...2641...>
References: <20231201111846.15097-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove dead remains of
 extract_x509_field_test
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

Obviously so :-) - haven't tested anything, as all removed code is
insides #ifdef that are never defined (and the function body itself 
is long gone).

Your patch has been applied to the master branch.

commit 5ce74caa39cf6335bb4b5b394e1ac4da3c9b9a3f
Author: Arne Schwabe
Date:   Fri Dec 1 12:18:46 2023 +0100

     Remove dead remains of extract_x509_field_test

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20231201111846.15097-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27625.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


