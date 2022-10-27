Date: Thu, 27 Oct 2022 08:07:59 +0200 (CEST)
Message-Id: <202210270607.29R67xBm021921@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221023195105.31714-1-selva.nair@...277...>
References: <20221023195105.31714-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ensure --auth-nocache is
 handled during renegotiation
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

Looking at the code, I'd say your commit description makes a lot of
sense, and explains the observed "funnies" quite well (which I could
reproduce).  The code change looks reasonable, Arne ACKed this, and
I could not find a way to break it.  Good :-)

One comment, though: when auth-tokens are in use, this call chain

        if (auth_token.token_defined && auth_token.defined)
        {
            up = &auth_token;
        }   
        /* save username for auth-token which may get pushed later */
        if (session->opt->pull)
        {   
            strncpynt(auth_token.username, up->username, USER_PASS_LEN);
        } 

.. will effectively copy auth_token.username to itself, which looks
a bit silly but *should* be well-defined.  At least it did not cause
issues in my auth-token tests.  If we think this is unwanted, having
a check like

        if (session->opt->pull && up != &auth_token)

would avoid that ("copy only if not working on auth_token already").


Testing took quite a bit of test cases + renegotiations to catch
"the original problem" and verify that "the fix" does not break 
related use cases (since this is a tangled mess of a-u-p and tokens)...
but it looks good!

old code (commit 7d48d31b8226d5, fairly recent "master", and also 
with 2.5.6 / commit 7b1b100557):

 * --auth-user-pass --auth-nocache --reneg-sec 150  (no tokens)
   expected behaviour:
     - u+p reauth every 150 seconds, prompt for username+password
   result: 
     - asks on *first* renegotiation
     - ran into a --ping-restart timeout
     - reconnected with *cached* username + password  <<< this is unwanted
     - asks again on *first* reneg
     - next 100 renegs with *cached* u+p <<< unwanted

   -> so, clearly somewhat nondeterministic and not what was ordered

with "master + patch" and also "release/2.5 + patch":

 * --auth-user-pass --reneg-sec 150
   expected behaviour:
     - u+p reauth every 150 seconds, no prompting on reneg
   result: works fine (no prompts after the initial ones)

 * --auth-user-pass --auth-nocache --reneg-sec 150
   expected behaviour:
     - u+p reauth every 150 seconds, prompt for username+password
   result: works fine (prompts on every reneg)

 * --auth-user-pass --reneg-sec 150                 + server-pushed auth-token
   expected behaviour:
     - token reauth ever 150 sec
     - u+p reauth when the token expires (600s here), no prompting
   result: works fine (no prompts on reneg ever)
     - terminate + restart server -> reauth with token, no prompting
   result: works fine

   NOTE: due to reasons outside of this patch, "renegotiate with UP without
   prompting" only works if there is a continuous connection to the server
   - if the server connection breaks, server_pushed_signal()->ssl_purge_auth()
   happens, and UP is forgotten, so when the token expires, prompts ensue
   (surprising behaviour, but not caused by this patch).

 * --auth-user-pass --auth-nocache --reneg-sec 150  + server-pushed auth-token
   expected behaviour:
     - token reauth ever 150 sec
     - u+p reauth when the token expires (600s), prompt for username+password
   result: works fine (prompts at token expiry, *only*)
     - terminate + restart server -> reauth with token, no prompting
   result: works fine

(never using --auth-user-pass <file>, because that makes it hard to verify
without extra instrumentation whether it used the cached copy, or the
on-file copy)

Your patch has been applied to the master and release/2.5 branch.

commit 3a4fb17d103be37599d72d072bbee42cc121a39d (master)
commit 5ad4b4b374f072459ab2436ed372c92d3a42d65d (HEAD -> release/2.5)
Author: Selva Nair
Date:   Sun Oct 23 15:51:05 2022 -0400

     Ensure --auth-nocache is handled during renegotiation

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20221023195105.31714-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25452.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


