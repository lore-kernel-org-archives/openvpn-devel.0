Date: Wed, 28 Jul 2021 13:26:05 +0200 (CEST)
Message-Id: <202107281126.16SBQ5F8044722@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210719133132.128783-1-arne@...1227...>
References: <20210719133132.128783-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Cleanup handling of initial
 auth token
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

I have stared a bit at the code, and the changes mostly look reasonable
(though I got confused on the way, see below :-) ).  Also, extra tests
are certainly good :-)

I have also run this through the client- and server-side test parcours.  
The latter has auth-token instances, so also testing "renegotiate with 
auth-token" and "token expiry, fall back to AUTH_FAILED, client falling
back to 'ok, here's password'".  Together with deferred (25s) auth.

These all worked nicely.  

I have changed whitespace (blank line and indent) as suggested, but 
not the "new define" part.  This is code...


Some additional remarks that could go to a followup cleanup patch:

 - the "We null terminate the old token..." comment in auth_token.c is
   in the wrong place - at that point, it's about the old_tstamp_initial

 - since the "in renegotiation time?" check in verify_auth_token() is
   no longer checking for "&& !initialtoken", the code might become even
   more readable by getting rid of "in_renegotiation_time" and just
   doing the check directly in the if() clause.

 - the wrapped "session id in token changed (Rejecting token." line is 
   missing a closing bracket and looks ugly if wrapped for just a single
   word, especially if the memcmp_constant_time() expression above 
   already has a longer line...


Your patch has been applied to the master branch.

commit d75e0736b4a0501a2c038ecb55730bf4f482b990
Author: Arne Schwabe
Date:   Mon Jul 19 15:31:32 2021 +0200

     Cleanup handling of initial auth token

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210719133132.128783-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22645.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


