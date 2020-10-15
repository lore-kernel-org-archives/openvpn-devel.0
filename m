Date: Thu, 15 Oct 2020 15:37:16 +0200 (CEST)
Message-Id: <202010151337.09FDbGVE091942@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201013204758.2472-1-gert@...1296...>
References: <20201013204758.2472-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Avoid passing NULL to
 argv_printf_cat() in temp_file error case.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Patch has been applied to the master and release/2.5 branch.

I have beaten this somewhat on the server torture bench, having
a config with plugin-auth-pam (deferred), auth-user-pass-verify *and*
auth-gen-token, testing both "via-env" (script-security 3 needed!)
and "via-file", testing script success and failure.

There might be a race between deferred plugin-auth and a failing
script - I saw something weird, but could not reproduce it (it might
have been "restarted the client too often, so the server log was
unclear on 'which message belongs to what instance'").

commit bbcada8abb410d077f7bc13b8157198b4bf6a3d1 (master)
commit 20965a18e52e60966ed754e6171e08ebe67432d6 (release/2.5)
Author: Gert Doering
Date:   Tue Oct 13 22:47:58 2020 +0200

     Avoid passing NULL to argv_printf_cat() in temp_file error case.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20201013204758.2472-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21204.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


