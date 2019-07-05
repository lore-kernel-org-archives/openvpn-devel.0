Date: Fri, 5 Jul 2019 12:33:40 +0200 (CEST)
Message-Id: <201907051033.x65AXeno089630@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190613134834.5709-1-arne@...1227...>
References: <20190613134834.5709-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement --genkey type keyfile
 syntax and migrate tls-crypt-v2
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

Have only done a cursory review + "make check" since David did the
thorough review already.  One small code wart...

 +    if (options->mlock && (options->genkey))

(asymmetric brackets) ... we can fix that when we pass here next time...

I have adjusted openvpn.8 according to tincantech's comments about
dashes and the typo.

commit 0d80b562e48a243c36dba9f1f66c3da6e3b3eb98
Author: Arne Schwabe
Date:   Thu Jun 13 15:48:29 2019 +0200

     Implement --genkey type keyfile syntax and migrate tls-crypt-v2

     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20190613134834.5709-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18524.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


