Date: Sat, 17 Sep 2022 19:04:26 +0200 (CEST)
Message-Id: <202209171704.28HH4QKB076972@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220824140848.88013-1-arne@...1227...>
References: <20220824140848.88013-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow scripts and plugins to
 set a custom AUTH_FAILED message
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

My server test rig has a "--auth-user-pass-verify" script that already
does client-controlled success/failure returns (setenv UV...), and
this has now learned to return client-specific messages if 
$auth_failed_reason_file is set...

2022-09-17 17:44:53 AUTH: Received control message: AUTH_FAILED,you stink

.. works.

For the plugin case, I've tried to test this with my existing 
"--client-connect magic hooks plugin", but it seems this functionality
is not exported to client-connect (so, CC plugin fails can only return
basic AUTH_FAIL).  So I've hacked this into plugin-auth-pam, which is
used in a different server instance, and that one also works:

2022-09-17 18:07:47 AUTH: Received control message: AUTH_FAILED,my plugin does not like you

All the other tests (client+server) still works as well, no files
are left around in /tmp/, etc.


Staring at the code took me a bit, because of the two-fold way you
did the checks - half the locations call check_for_client_reason(),
while tls_authentication_status() prefers to do it "inline" (... leading
to the gc_free()... ;-) ).  Could this be unified, or am I overlooking
something?  Anyway, decided to not stop progress because of this.


Your patch has been applied to the master branch.

commit 8893fe49a4c593387d469ccc4a73ec0714f69315
Author: Arne Schwabe
Date:   Wed Aug 24 16:08:48 2022 +0200

     Allow scripts and plugins to set a custom AUTH_FAILED message

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Heiko Hund <heiko@...2662...>
     Message-Id: <20220824140848.88013-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25099.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


