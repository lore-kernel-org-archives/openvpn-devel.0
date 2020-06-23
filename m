Date: Tue, 23 Jun 2020 08:28:36 +0200 (CEST)
Message-Id: <202006230628.05N6Sa3g001325@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200622232319.8143-2-James.Bottomley@...2316...>
References: <20200622232319.8143-2-James.Bottomley@...2316...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add unit tests for engine keys
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
To: James Bottomley <James.Bottomley@...2316...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Tested on :
 - MacOS Mojave with OpenSSL 1.1.1c (brew) and out-of-tree build, works.
 - Linux with mbedtls (does not try engine tests, good :-) )
 - Linux with OpenSSL 1.1.1, works
 - FreeBSD 11.3 with OpenSSL 1.0.2s -> v6 fails, v6 works \o/

Conferred with Arne, we agreed on "this is good enough, and who wants 
something more sophisticated is welcome to send more patches".

Your patch has been applied to the master branch.

Thanks :)

commit 542c69c37b347d1895dde076508d0f6554544860
Author: James Bottomley
Date:   Mon Jun 22 16:23:19 2020 -0700

     Add unit tests for engine keys

     Signed-off-by: James Bottomley <James.Bottomley@...2316...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200622232319.8143-2-James.Bottomley@...2316...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20075.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


