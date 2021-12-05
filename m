Date: Sun, 5 Dec 2021 18:26:42 +0100 (CET)
Message-Id: <202112051726.1B5HQgGv089936@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211201180727.2496903-2-arne@...1227...>
References: <20211201180727.2496903-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Directly use hardcoed
 OPENVPN_AEAD_TAG_LENGTH instead lookup
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

Verified that these changes are only done within "aead" encrypt/decrypt
crypto functions, and we already know it's an AEAD cipher.  Changed the 
commit subject to actually name it "AEAD" TAG_LENGTH :-)

(I wondered why the patch does not remove cipher_kt_tag_size() right
away, but that's our beloved crypto_adjust_frame_parameters()... so
I assume that will come as part of the frame cleanup later on)

Lightly tested client side, with BF-CBC and AEAD connections.

Your patch has been applied to the master branch.

commit e82e3382384846456881eec97d626b2d4cfb2df6
Author: Arne Schwabe
Date:   Wed Dec 1 19:07:20 2021 +0100

     Directly use hardcoed OPENVPN_AEAD_TAG_LENGTH instead lookup

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211201180727.2496903-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23273.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


