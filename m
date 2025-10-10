Date: Fri, 10 Oct 2025 09:33:11 +0200 (CEST)
Message-Id: <202510100733.59A7XBBq073674@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251009205951.32301-1-gert@...1296...>
References: <20251009205951.32301-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: options: Review use of
 positive_atoi vs atoi_constrained
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

Changes makes sense.  BB happy (though the t-client tests do not
really excercise just these options).  I have smoke tested --mssfix
(because I had a test bed around from the checksum tests), works, gives
nice error messages and does the job for acceptable values.

MaxF has done the initial review, and had doubts about changing the
behaviour of "max-routes-per-client 0" - which used to be
"silent upgrade to 1", and now "error".

Given that this is one of the very obscure openvpn options anyway, the
chance that anyone is being hit by this is fairly small - and if it 
hits, their config was (silently) broken before.  So, +2 from me, in 
it goes.

Your patch has been applied to the master branch.

commit 7579749fee05ee8a06dd6169396fb60f7558925a
Author: Frank Lichtenheld
Date:   Thu Oct 9 22:59:46 2025 +0200

     options: Review use of positive_atoi vs atoi_constrained

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1153
     Message-Id: <20251009205951.32301-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59244617/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


