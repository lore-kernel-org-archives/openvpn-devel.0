Date: Tue, 28 Jun 2022 17:33:34 +0200 (CEST)
Message-Id: <202206281533.25SFXYl5046911@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220628094144.17471-1-a@...2181...>
References: <20220628094144.17471-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: tls-crypt-v2: bail out if the
 client key is too small
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

I have taken the "why is this not a problem?" text from Arne's ACK and
included it into the commit message.

Your patch has been applied to the master and release/2.5 branch.

commit 462339a45089ef655faf02232d7d792def9b8afb (master)
commit ce24bec7e2518d4ea7aa931021454d1191f4906b (release/2.5)
Author: Antonio Quartulli
Date:   Tue Jun 28 11:41:44 2022 +0200

     tls-crypt-v2: bail out if the client key is too small

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20220628094144.17471-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24580.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


