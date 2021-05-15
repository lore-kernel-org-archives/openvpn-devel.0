Date: Sat, 15 May 2021 18:27:56 +0200 (CEST)
Message-Id: <202105151627.14FGRuNH014864@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210506141259.309741-1-arne@...1227...>
References: <20210506141259.309741-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Return cached result in
 tls_authentication_status
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

I have tested this on the server test rig, and it did not change
server side behaviour (in a way that breaks the defined tests).

I've also stared at the code a bit and tried to figure out what is 
going on, and came across a slightly incomplete comment for 
key_state_test_auth_control_file() which has escaped the dragon's 
wrath - rewritten to match my understanding of the function.

Ditto for the comment in ssl_verify.h for tls_authentication_status(),
which was not updated to reflect the removal of TLS_AUTHENTICATION_UNDEFINED
(slightly moot as the "exponential" patch will remove that parameter
and the comment with it).

Your patch has been applied to the master branch.

commit 9a4305020777ce92d4143828b39027f43951ac32
Author: Arne Schwabe
Date:   Thu May 6 16:12:59 2021 +0200

     Return cached result in tls_authentication_status

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210506141259.309741-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22318.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


