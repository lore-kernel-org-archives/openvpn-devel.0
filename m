Date: Thu, 9 Jul 2020 21:26:41 +0200 (CEST)
Message-Id: <202007091926.069JQfpm025189@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200709101603.11941-8-arne@...1227...>
References: <20200709101603.11941-8-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Code cleanup: remove superflous
 variable
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

Your patch has been applied to the master branch.

After some discussion on IRC, Antonio and I have come to the conclusion
that the original code was related to the pre-2.2 threading attempts, and
that "copying 'now' to a new local variable" might have been necessary to
avoid another thread messing with it while comparisons are being made - so
having a thread-local "local_now" is reasonable.

Now, the threading stuff was never finished and removed in 7aa6c12a4424d
nearly 10 years ago...  out with it :-)

commit ca514800ca126b69dbde846db819d8bf4c490e68
Author: Arne Schwabe
Date:   Thu Jul 9 12:16:03 2020 +0200

     Code cleanup: remove superflous variable

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20200709101603.11941-8-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20252.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


