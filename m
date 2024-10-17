Date: Thu, 17 Oct 2024 09:01:01 +0200 (CEST)
Message-Id: <202410170701.49H71192039177@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241017064955.23959-1-gert@...1296...>
References: <20241017064955.23959-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Improve data channel crypto
 error messages
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Stared a bit at the code, poked MaxF to do a more thorough review (thanks),
did a test compile.

Out of curiosity - are you really seeing that many "authentication
errors on bad connections"?  Aka "shouldn't lower-layer checksums not
catch and drop packet corruptions"?

Your patch has been applied to the master branch.

commit bacdbbee7e2c0c1114b9f5e19b124f91680fd937
Author: Steffan Karger
Date:   Thu Oct 17 08:49:55 2024 +0200

     Improve data channel crypto error messages

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: MaxF <max@...2606...>
     Message-Id: <20241017064955.23959-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29569.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


