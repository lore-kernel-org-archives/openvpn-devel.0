Date: Wed, 26 Jan 2022 14:47:11 +0100 (CET)
Message-Id: <202201261347.20QDlBLt060177@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220121185752.14138-1-selva.nair@...277...>
References: <20220121185752.14138-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not error when md_kt_size()
 is called with mdname=none
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

Patch + explanation make sense and Arne indeed ACKed this.  Thanks.

Reproduced the problem (GCM + verb7):

   2022-01-26 14:40:34 us=15705 Data Channel: using negotiated cipher 'AES-256-GCM'
   ...
   2022-01-26 14:40:34 us=15829 Message hash algorithm 'none' not found
   2022-01-26 14:40:34 us=15849 Exiting due to fatal error

and can see the fix work

   2022-01-26 14:42:38 us=355685 Data Channel: using negotiated cipher 'AES-256-GCM'
   ...
   2022-01-26 14:42:38 us=355782 Master Encrypt (cipher): 0ba0d2b3 83f3f160 3ff8fe87 11c22db7 dc67c1fd 7f9ba3f0 9077f9e9 7ee77cf2
   2022-01-26 14:42:38 us=355791 Master Encrypt (hmac): 
   ...
   2022-01-26 14:42:38 us=355897 Incoming Data Channel: CIPHER block_size=16 iv_size=12
   2022-01-26 14:42:38 us=356020 ROUTE_GATEWAY 193.149.48.190/255.255.255.192 IFACE=bge0 HWADDR=3c:a8:2a:9f:70:90


Your patch has been applied to the master branch.

commit 9076d90684c06c8f0ac0ba4c099b00ddbc4ab29d
Author: Selva Nair
Date:   Fri Jan 21 13:57:52 2022 -0500

     Do not error when md_kt_size() is called with mdname=none

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220121185752.14138-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23631.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


