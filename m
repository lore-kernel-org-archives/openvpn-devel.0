Date: Mon, 1 Nov 2021 21:10:21 +0100 (CET)
Message-Id: <202111012010.1A1KALvS086567@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211019183127.614175-14-arne@...1227...>
References: <20211019183127.614175-14-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove dependency on BF-CBC
 existance from test_ncp
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

I can confirm that this fixes ncp_testdriver for 3.0.0 builds,
which is what it says :-) (and 1.1.1 builds still succeed).

Took me a bit to understand the new if/else clauses, but after a while
it started making sense :-)

Your patch has been applied to the master branch.

commit c07f95f3cacdf7c877762db8d1a3f7cf0a4a4675
Author: Arne Schwabe
Date:   Tue Oct 19 20:31:19 2021 +0200

     Remove dependency on BF-CBC existance from test_ncp

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Max Fillinger <maximilian.fillinger@...2507...>
     Message-Id: <20211019183127.614175-14-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23003.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


