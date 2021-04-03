Date: Sat, 3 Apr 2021 10:58:42 +0200 (CEST)
Message-Id: <202104030858.1338wg8t052614@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210219165252.4562-1-arne@...1227...>
References: <20210219165252.4562-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow running a default
 configuration with TLS libraries without BF-CBC
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

Taking Antonio's ACK on v3, adding my own (positive) test results on v5
to make my own ACK.

The code of v3 and v5 only differs in one line

++            || (options->ncp_enabled && tls_item_in_cipher_list("BF-CBC", options->ncp_ciphers))

which covers the special case broken in v3 (talking to a 2.4 server with
--ncp-disable).  Server side tests all succeed as well.

Your patch has been applied to the master branch.

commit 79ff3f79ebd98b880e77f323bd591eeb85df8411
Author: Arne Schwabe
Date:   Fri Feb 19 17:52:52 2021 +0100

     Allow running a default configuration with TLS libraries without BF-CBC

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210219165252.4562-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21577.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


