Date: Mon, 18 Jan 2021 12:58:22 +0100 (CET)
Message-Id: <202101181158.10IBwMpi047084@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210105131758.20311-1-arne@...1227...>
References: <20210105131758.20311-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Zero initialise msghdr prior to
 calling sendmesg
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

I have adjusted the whitespace as requested by Antonio, and added your 
SoB-Line (as agreed on IRC).

Your patch has been applied to the master, and release/2.5 branch (bugfix).

I have not merged it to 2.4 - it would nicely fit, but since this is all
TARGET_ANDROID, and nobody builds the Android client with an old tree, this
would just be "repo commit noise".

commit aa58035a955a2ae7ffa2b93ca2c8d2c6e5472695 (master)
commit a65d39bfd27cf5612e55dd536dd189e1a62624c2 (release/2.5)
Author: Arne Schwabe
Date:   Tue Jan 5 14:17:58 2021 +0100

     Zero initialise msghdr prior to calling sendmesg

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210105131758.20311-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21418.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


