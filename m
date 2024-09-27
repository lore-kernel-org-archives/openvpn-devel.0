Date: Fri, 27 Sep 2024 18:49:37 +0200 (CEST)
Message-Id: <202409271649.48RGnbMK039806@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240927093045.22753-1-frank@...2641...>
References: <20240927093045.22753-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: better naming for function
 parameters
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

This "should" only be a renaming, but with so many #ifdef I've put this
on the Linux and FreeBSD DCO test servers, which run all the tests 
with and without --disable-dco - plus GHA for Windows building.  So I'm
reasonably sure it does not break anything :-)

Your patch has been applied to the master branch.

commit 95e5a0b4f0f0f45d29a5a995f151677b760ddf76
Author: Lev Stipakov
Date:   Fri Sep 27 11:30:45 2024 +0200

     dco: better naming for function parameters

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20240927093045.22753-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29460.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


