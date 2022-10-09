Date: Sun, 9 Oct 2022 09:44:31 +0200 (CEST)
Message-Id: <202210090744.2997iVb7011159@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220914185937.31423-2-a@...2181...>
References: <20220914185937.31423-2-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: get_user_pass_cr: get password
 from stdin if missing inline
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Amazingly trivial, as soon as one understands the intricacies of
get_user_pass_cr() ;-) - of course I have tested this.  Without the
patch, <auth-user-pass> with no password will send an empty password,
with the patch, it will query on stdin and things will succeed
(hard to test in an automated way, though).

I have not tested if this would query via systemd, as I don't have
any systemd systems - but since this is using already-existing paths to
query for password, I'd expect so.

Now, to management interface - as Selva correctly remarked, all these
"we have a username and now need to query for a password" cases should
really work via management interface as well, otherwise the user experience
(especially on windows) will be fairly poor.  Inside auth_user_pass_cr()
this should be doable with some reshuffling, and from the documentation
I see that the managment interface already knows how to query "only for
password".  So maybe something like

   >PASSWORD:Need 'Auth' password user=$username

(extend Need 'Auth' with a username) and the GUI could then present
a user/password dialogue with a non-editable "user" field, or so...

Your patch has been applied to the master branch.

commit 39619b7fab213e9cadaa4a8b50b795ad63d9d91f
Author: Antonio Quartulli
Date:   Wed Sep 14 20:59:37 2022 +0200

     get_user_pass_cr: get password from stdin if missing inline

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220914185937.31423-2-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25215.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


