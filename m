Date: Tue, 13 Jun 2017 09:11:05 +0200 (CEST)
Message-Id: <201706130711.v5D7B5Ix068284@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1494537221-12050-2-git-send-email-steffan@...1856...>
References: <1494537221-12050-2-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: cleanup: merge
 packet_id_alloc_outgoing() into packet_id_write()
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Same patch as in 2.3

Diffing the two *patches* shows differences like this one:

-         else if (cipher_kt_mode_ofb_cfb(cipher_kt))
+         else if (mode == EVP_CIPH_CFB_MODE || mode == EVP_CIPH_OFB_MODE)

.. but's not a patch change, but different context (old 2.2 crypto style).

Your patch has been applied to the release/2.2 branch.

commit aded94168651ffc4346e73604b62cfcee4ef7297
Author: Steffan Karger
Date:   Thu May 11 23:13:40 2017 +0200

     cleanup: merge packet_id_alloc_outgoing() into packet_id_write()

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1494537221-12050-2-git-send-email-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14644.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


