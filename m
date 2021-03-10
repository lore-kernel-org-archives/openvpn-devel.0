Date: Wed, 10 Mar 2021 15:11:38 +0100 (CET)
Message-Id: <202103101411.12AEBcx4081503@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210125125628.30364-9-arne@...1227...>
References: <20210125125628.30364-9-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow pending auth to be send
 from a auth plugin
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

Stared at the code a bit, tortured it on the server test rig (which
excercises delayed-auth plugin and delayed-client-connect-*anything*,
so breaking something plugin-related "big time" should have been
caught).  I have not tested the delayed-auth plugin feature yet.

A few observations, staring at key_state_check_auth_pending_file():

 - it would benefit from early-return... 3 levels deep for most of
   the function...

 - if "timeout" cannot be parsed, the function does an early-return,
   but does not call "key_state_rm_auth_pending_file(ks);" - this looks
   somewhat intentional ("we keep trying until we can parse the timeout 
   value")...?

 - "char* pending_method = BSTR(iv_buf);" is a bit confusingly named -
   especially as "iv_buf" is not continaing the client-side IV_SSO
   value set, but the plugin-requested method.  So maybe iv_buf could
   be renamed to "pending_method_buf" or so?

These are all not reasons to reject the patch, but if you feel like
"ah, today is openvpn source cleanup day", this would be a candidate :-)

I have taken the liberty to fix the comment in verify_user_pass_plugin().

Your patch has been applied to the master branch.

commit fdb4f27685f38621b72467e3038c2116f0e809c4
Author: Arne Schwabe
Date:   Mon Jan 25 13:56:25 2021 +0100

     Allow pending auth to be send from a auth plugin

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20210125125628.30364-9-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21489.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


