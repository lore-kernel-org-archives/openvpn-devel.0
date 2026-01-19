Date: Mon, 19 Jan 2026 18:06:43 +0100 (CET)
Message-Id: <202601191706.60JH6heR046775@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260119122058.14865-1-gert@...1296...>
References: <20260119122058.14865-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_verify_openssl: Avoid
 conversion warning in x509_verify_cert_ku
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

+1 on the v4 integer change from Mathias, and BB is happy as well -> +2 from
me, in it goes.  v4 is also quite simple and straightforward :-)

Your patch has been applied to the master branch.

commit de3ef0dc65036b6efc650c768e0296419a801b20
Author: Frank Lichtenheld
Date:   Mon Jan 19 13:20:51 2026 +0100

     ssl_verify_openssl: Avoid conversion warning in x509_verify_cert_ku

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1445
     Message-Id: <20260119122058.14865-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35322.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


