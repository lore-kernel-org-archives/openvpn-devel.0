Date: Wed, 26 Jun 2024 18:55:17 +0200 (CEST)
Message-Id: <202406261655.45QGtHEp022451@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240626161921.179301-1-frank@...2641...>
References: <20240626161921.179301-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure: Try to detect LZO
 with pkg-config
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Detailed test reports are in the gerrit notes... so not repeating them
here :-) - but finally, we have something that just detects LZO 
"wherever it is", as long as a pkg-config entry is there - the need
to have LZO_CFLAGS/LZO_LIBS on all the *BSDs has irked me since 2.1
or so...  (thanks!)

Sanity-tested the 2.6 branch via GHA.

Your patch has been applied to the master and release/2.6 branch
(no real code change, maintenance).

commit 0ea51261d096b54281287bbd2a6899041c4dbd43 (master)
commit 3c43b016e9767df74909ea5644399e8872e38c97 (release/2.6)
Author: Frank Lichtenheld
Date:   Wed Jun 26 18:19:21 2024 +0200

     configure: Try to detect LZO with pkg-config

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240626161921.179301-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28848.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


