Date: Wed, 14 Jan 2026 12:14:32 +0100 (CET)
Message-Id: <202601141114.60EBEW5k028656@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260114110452.4976-1-gert@...1296...>
References: <20260114110452.4976-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: remove ENABLE_X509ALTUSERNAME
 conditional
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

Thanks for the review :-) - and in it goes.  Most of it is trivial, just
the mbedtls adjustment needed a bit of new code ("return false").

Added a "Changes.rst" entry

Your patch has been applied to the master branch.

commit faac9681cce54f576eddea4b6389395542c24315
Author: Gert Doering
Date:   Wed Jan 14 12:04:47 2026 +0100

     remove ENABLE_X509ALTUSERNAME conditional

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1442
     Message-Id: <20260114110452.4976-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35237.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


