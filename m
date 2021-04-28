Date: Wed, 28 Apr 2021 14:08:09 +0200 (CEST)
Message-Id: <202104281208.13SC89mD023099@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210407154951.13330-1-arne@...1227...>
References: <20210407154951.13330-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement deferred auth for
 scripts
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

Acked-by: Gert Doering <gert@...1296...>

I've taken Antonio's ACK on previous versions, plus add my own.

v6 differs only minimally from v5 (in the addition of the inotify for
the script auth control file), so ACKs and test results of v5 are valid.

I have subjected this to the server side cabinet of horrors, with a
mixture of plugin and scripts active, including a new test instance
that does deferred and synchronous "auth-user-pass-verify script".

It does not break any of the existing tests, especially not the "plugin 
fails after delay while script auth succeeds right away", which broke 
v3 or v4, and the new functionality also works.

Staring at the code, it also looks fine now.  Rewriting all these
"s1" and "s2" is really a good thing, though it makes the code take
a bit more space.  But it was really hard to understand before.

As discussed on IRC, I've reworded the comment in ssl_verify.c

  /* auth_plugin and auth_man are either ACF_DISABLED or ACF_SUCCEEDED */

to include "auth_script" and a bit of extra clarification.


Further, as discussed on IRC, we noticed that this lost the hunk in
ssl_verify.c / verify_user_pass_script() that does error handling in
the case of "platform_create_temp_file() failed".  This is an unlikely
case, but if you have a script that expects a file argument and just
silently and occasionally get "no argument", this is bad - the old
error handling was not right either (it reported the error, but
still proceeded).  To get on with this patchset, we've decided to
merge v6 anyway, and clean this in a followup patch.


Your patch has been applied to the master branch.

commit 28e6103096ae8ba0a4498da1625a61150a50e6c1
Author: Arne Schwabe
Date:   Wed Apr 7 17:49:51 2021 +0200

     Implement deferred auth for scripts

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Tested-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210407154951.13330-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22072.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


