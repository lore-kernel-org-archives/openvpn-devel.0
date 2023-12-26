Date: Tue, 26 Dec 2023 20:40:49 +0100 (CET)
Message-Id: <202312261940.3BQJenI3032077@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231213105308.121460-1-frank@...2641...>
References: <20231213105308.121460-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Extend the error message when
 TLS 1.0 PRF fails
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

I have not actually tested this on a FIPS- or otherwise-impaired system,
just test compiled ("no stray characters") and looked at the new error
message, which is indeed more informative.

Your patch has been applied to the master and release/2.6 branch
(I claim it falls under "documentation improvements").

commit 6ff816142c1acdaee149c4daabb297fefc2ccde0 (master)
commit cfaf82d5eb62e1ed4804afa37817105e9aa4394a (release/2.6)
Author: Arne Schwabe
Date:   Wed Dec 13 11:53:08 2023 +0100

     Extend the error message when TLS 1.0 PRF fails

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20231213105308.121460-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27796.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


