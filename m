Date: Fri, 22 Sep 2023 15:36:18 +0200 (CEST)
Message-Id: <202309221336.38MDaIp9033487@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230922104334.37619-1-frank@...2641...>
References: <20230922104334.37619-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: dns option: remove support for
 exclude-domains
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

Change makes sense, and doesn't break any of the GH tests :-)

I have applied this to 2.6 as well, as it doesn't really make sense
to keep these options, pretending "an implementation might come" when
we already know they are going away.

Something strange has happened to the mailing list archive - it pretends
that *this* patch e-mail just never arrived there, while the original
patch is there - so I've pointed "URL:" there.

Your patch has been applied to the master and release/2.6 branch.

commit b7eea48708ee73a5999f98626fb8d31d8f88ea6f (master)
commit b033683bf982200471e53b18600e3a2f541ab3f2 (release/2.6)
Author: Heiko Hund
Date:   Fri Sep 22 12:43:34 2023 +0200

     dns option: remove support for exclude-domains

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20230922104334.37619-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27008.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


