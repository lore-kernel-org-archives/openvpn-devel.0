Date: Fri, 10 Jan 2025 08:19:25 +0100 (CET)
Message-Id: <202501100719.50A7JPPV042963@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250109212803.11505-1-gert@...1296...>
References: <20250109212803.11505-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Rename aead-tag-at-end to
 aead-epoch
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

Fairly straightforward renaming of things, which makes sense.  Just
test compiled (as there is nothing yet which would care for the IV_
sent and push back "aead-epoch").

I've moved the "is" in the crypto.h comment to the end of the sentence,
where it now seems to make more sense.

Your patch has been applied to the master branch.

commit 0671a4d009ae89870b645d1a8f3078d9943d5010
Author: Arne Schwabe
Date:   Thu Jan 9 22:28:03 2025 +0100

     Rename aead-tag-at-end to aead-epoch

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: MaxF <max@...2606...>
     Message-Id: <20250109212803.11505-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30395.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


