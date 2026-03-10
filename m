Date: Tue, 10 Mar 2026 09:27:19 +0100 (CET)
Message-Id: <202603100827.62A8RJqm094150@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260309133236.29732-1-frank@...2641...>
References: <20260309133236.29732-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_verify_openssl: Clean up
 extract_x509_extension
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

This looked good to me, but "OpenSSL innards" are still foreign territory,
so thanks Arne for looking at the ia5/rfc822Name change (I found it 
surprising since we had an "ia5->length" before and now need to do
ASN1_STRING_LENGTH(), but I'm sure there is a good reason behind this).

Your patch has been applied to the master branch.

commit 66060627a8cf05c8761d75985e76482d20df4f29
Author: Frank Lichtenheld
Date:   Mon Mar 9 14:32:36 2026 +0100

     ssl_verify_openssl: Clean up extract_x509_extension

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1507
     Message-Id: <20260309133236.29732-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35980.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


