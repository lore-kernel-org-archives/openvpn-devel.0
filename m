Date: Thu, 27 Oct 2022 21:02:52 +0200 (CEST)
Message-Id: <202210271902.29RJ2qTm038532@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221027160619.11894-1-selva.nair@...277...>
References: <20221027160619.11894-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not copy auth_token username
 to itself
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

Testing this was fairly easy - I added a msg() call in that if()
branch, connected to a server with auth-token and verified that it did
the strncpynt() only on the "I have a real username here" call.  And
that token reauth still works ("username properly copied"), which
it all did.

Your patch has been applied to the master branch, for now - it needs
to go to 2.5 as well, but we're right in the middle of a 2.5.8 
release, and I need to check with Samuli & Frank if anything has been
done already that would cause havoc if I change the (preliminary)
v2.5.8 tag...

commit dbf142ffe597b21aa09a47677ea2061b74a9354e
Author: Selva Nair
Date:   Thu Oct 27 12:06:19 2022 -0400

     Do not copy auth_token username to itself

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221027160619.11894-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/search?l=mid&q=20221027160619.11894-1-selva.nair@...277...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


