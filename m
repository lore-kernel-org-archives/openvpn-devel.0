Date: Tue, 14 Feb 2023 16:36:05 +0100 (CET)
Message-Id: <202302141536.31EFa5uj025063@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230128223421.2207802-2-selva.nair@...277...>
References: <20230128223421.2207802-2-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Option --cryptoapicert: support
 issuer name as a selector
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

I did hope that someone else would report back and say "I have tested this
and it works great!".  Nobody volunteered and I wanted this out of the
way (and I think it's a useful addition with very little code needed).

Code looks good according to documentation of CertFindCertificateInStore()
(though the microsoft documentation I found lacks the CERT_FIND...*_W
defines... but it's symmetric to CERT_FIND_SUBJECT_STR_W)

MinGW and GH tell me that the code compiles fine :-)

Documentation addition is good and well-understandable.

Your patch has been applied to the master and release/2.6 branch.

commit b9e0e4060798ed88d2170702f2935754616b1200 (master)
commit a8ff15ce49b69816b64387e3387b9a310891d12a (release/2.6)
Author: Selva Nair
Date:   Sat Jan 28 17:34:18 2023 -0500

     Option --cryptoapicert: support issuer name as a selector

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230128223421.2207802-2-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26092.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


