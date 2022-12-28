Date: Wed, 28 Dec 2022 22:47:00 +0100 (CET)
Message-Id: <202212282147.2BSLl00c042577@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221228171314.133115-1-frank@...2641...>
References: <20221228171314.133115-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: options.c: update usage
 description of --cipher
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

Acked-by: Gert Doering <gert@...1296...>

"makes sense" and I can confirm the ((null))...  now it's

--cipher alg    : Encrypt packets with cipher algorithm alg.
                  You should usually use --data-ciphers instead.
                  Set alg=none to disable encryption.

Your patch has been applied to the master and release/2.6 branch.

commit 4410daac5af8be778cb2dd2d45a44b5e67938496 (master)
commit f45c2c595857b40e2648f2542962cfe2e82e9b44 (release/2.6)
Author: Frank Lichtenheld
Date:   Wed Dec 28 18:13:14 2022 +0100

     options.c: update usage description of --cipher

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221228171314.133115-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25851.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


