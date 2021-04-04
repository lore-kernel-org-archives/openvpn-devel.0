Date: Sun, 4 Apr 2021 10:59:13 +0200 (CEST)
Message-Id: <202104040859.1348xDWR013194@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210402173414.14216-1-gert@...1296...>
References: <20210402173414.14216-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix potential NULL ptr crash if
 compiled with DMALLOC
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Patch has been applied to the master, release/2.5 and release/2.4 branch 
(crazily important bugfix!).

commit e2acfad40c0d79ce7fd431c380d7466d383bcefa (master)
commit acf52dda9f4cb117e9d020dd06fccd7ecb90d303 (release/2.5)
commit a7263a125199c6d11710ecf50f9a07424369fdbc (release/2.4)
Author: Gert Doering
Date:   Fri Apr 2 19:34:14 2021 +0200

     Fix potential NULL ptr crash if compiled with DMALLOC

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210402173414.14216-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21981.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


