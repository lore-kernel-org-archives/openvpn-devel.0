Date: Sun, 30 Aug 2020 22:16:35 +0200 (CEST)
Message-Id: <202008302016.07UKGZXg091535@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200830131440.10933-1-arne@...1227...>
References: <20200830131440.10933-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix client NCP OCC fallback
 when server and client cipher are identical
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

Besides the visual check ("nice, one level of indentation removed!"),
I have also added 5 more tests to our test environment (running on
phillip, so available for all t_client instances):

 - git master client to 2.3 server, "--cipher bf-cbc"
   ("OCC based NCP, same cipher on client and server")
 - git master client to 2.3 server, "--cipher aes-gcm, --data-ciphers bf-cbc"
   ("OCC based NCP, different cipher on client and server, but server
   client allowed on client")
 - git master client to 2.3 "--enable-small" server, --data-ciphers-fallback
   ("no NCP of any sort, falling back to the fallback cipher")
 - git master client to 2.4
   ("2.4 style NCP, receiving pushed AES-256-GCM")
 - git master client to 2.4 with "--ncp-disable"
   (fallback to OCC based NCP with "same cipher")

Previous git master nicely ran into the problem Gava reported for both
"same cipher on the client as OCC-signalled from the server" cases
(unsurprisingly) and with the patch, all 5 test cases succeeded.

Plus all the cases where this code is running on the server side (which
received much more scrutiny and testing than as-client-to-older-servers, 
alas).

Your patch has been applied to the master and release/2.5 branch.

commit 6ffe64e34004967a96514cc55abb22215fbe5640 (master)
commit ea3c0ecc11f64fe4a58441c6d9c889472f6ed606 (release/2.5)
Author: Arne Schwabe
Date:   Sun Aug 30 15:14:40 2020 +0200

     Fix client NCP OCC fallback when server and client cipher are identical

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200830131440.10933-1-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20200830131440.10933-1-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


