Date: Thu, 25 Jan 2018 09:35:50 +0100 (CET)
Message-Id: <201801250835.w0P8ZoWF081671@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1516468294-32635-1-git-send-email-selva.nair@...277...>
References: <1516468294-32635-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add
 SSL_CTX_get_max_proto_version() not in openssl 1.0
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Same code as in master (+ifdef), compile-tested with 1.0.1 and 0.9.8

Your patch has been applied to the release/2.4 branch.

commit 51ab66a52b9b12402495274bc7070d0b9a2ebde6
Author: Selva Nair
Date:   Sat Jan 20 12:11:34 2018 -0500

     Add SSL_CTX_get_max_proto_version() not in openssl 1.0

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1516468294-32635-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16304.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


