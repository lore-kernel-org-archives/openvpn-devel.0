Date: Wed, 6 May 2026 19:02:03 +0200 (CEST)
Message-Id: <202605061702.646H231W003080@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260506145933.22301-1-gert@...1296...>
References: <20260506145933.22301-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: t_client.sh: Do not use CA_CERT
 variable as indicator for good .rc file
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

I agree that this check has outlived its usefulness - "back then", the
assumption was "you always need a CA and Key and Cert", but with inline
configs & --fingerprint and all this, this no longer holds true.

I don't think there is a pressing need to backport this to the other
branches we regularily test (2.6, 2.7) as "as of now" our CI setups have
already been workarounded ("CA_CERT=1").

Your patch has been applied to the master branch.

commit 841ab0b216a424eb0100448362f76a2c12b3a516
Author: Frank Lichtenheld
Date:   Wed May 6 16:59:28 2026 +0200

     t_client.sh: Do not use CA_CERT variable as indicator for good .rc file

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1664
     Message-Id: <20260506145933.22301-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36827.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


