Date: Wed, 25 Sep 2024 18:53:11 +0200 (CEST)
Message-Id: <202409251653.48PGrBmm049428@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240925151104.13036-1-gert@...1296...>
References: <20240925151104.13036-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove null check after
 checking for checking for did_open_tun
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

I've stared long and hard on the code - nothing really to test here, as
*this* pointer access will never be NULL, if the access before it already
triggers the crash - and I am reasonably sure that *in this function*,
if "c2.did_tun_open" is true, c1.tuntap will always be initialized, so
this is safe (after do_close_tun() this is no longer guaranteed,
but the code path inside do_up() does a new open right away, and the
other code paths will not call do_up()).

Your patch has been applied to the master branch.

commit a8cc97f94f3e7bb52270ca2acf89804093535839
Author: Arne Schwabe
Date:   Wed Sep 25 17:11:04 2024 +0200

     Remove null check after checking for checking for did_open_tun

     Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240925151104.13036-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29447.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


