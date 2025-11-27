Date: Thu, 27 Nov 2025 13:01:04 +0100 (CET)
Message-Id: <202511271201.5ARC14Wp076885@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251127113517.1352-1-gert@...1296...>
References: <20251127113517.1352-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: extract_x509_field_ssl():
 verify that X509_NAME is not NULL.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Only subjected to basic t_client tests - this extracts the subject name
to print it, so things still work for the non-error case (and I have no
cert that would trigger the error case).

Opened github #917 to start a discussion about the ENABLE_X509ALTUSERNAME
conditional... (one cannot simply touch OpenVPN code without finding
things :-/ )

Your patch has been applied to the master branch.

commit f18e3141fae709fff47b82d7931024249ba09cc1
Author: Gert Doering
Date:   Thu Nov 27 12:35:12 2025 +0100

     extract_x509_field_ssl(): verify that X509_NAME is not NULL.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1388
     Message-Id: <20251127113517.1352-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34748.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


