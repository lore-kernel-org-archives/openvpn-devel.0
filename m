Date: Mon, 13 Dec 2021 18:45:55 +0100 (CET)
Message-Id: <202112131745.1BDHjt3H080577@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211213150950.3993881-1-arne@...1227...>
References: <20211213150950.3993881-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move deprecation of
 SWEET32/64bit block size ciphers to 2.7
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

As agreed on IRC.  2.6 will already make BF-CBC inconvenient to use
(so, hopefully, more people will migrate off it), but let's not make
it too annoying.

Your patch has been applied to the master branch.

commit 7f2d7dbf986fd7233eabb250b35bf7c3112d3e37
Author: Arne Schwabe
Date:   Mon Dec 13 16:09:50 2021 +0100

     Move deprecation of SWEET32/64bit block size ciphers to 2.7

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211213150950.3993881-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23402.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


