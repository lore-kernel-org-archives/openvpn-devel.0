Date: Fri, 26 Sep 2025 19:05:38 +0200 (CEST)
Message-Id: <202509261705.58QH5cKd083546@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250926164845.1215-1-gert@...1296...>
References: <20250926164845.1215-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: comp-lz4: Fix types in call to
 LZ4_decompress_safe
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

Ints all around... and one set of #pragma gone again :-) - BB t_client
tests do test lz4, so the code is excercised.

Your patch has been applied to the master branch.

commit 2682fb541ef9068e9707a3a90c16038e6f516b0f
Author: Frank Lichtenheld
Date:   Fri Sep 26 18:48:39 2025 +0200

     comp-lz4: Fix types in call to LZ4_decompress_safe

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: MaxF <max@...2606...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1215
     Message-Id: <20250926164845.1215-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33228.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


