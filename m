Date: Mon, 28 Oct 2024 16:42:16 +0100 (CET)
Message-Id: <202410281542.49SFgGNB010389@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241028135505.28651-1-gert@...1296...>
References: <20241028135505.28651-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Refuse clients if username or
 password is longer than USER_PASS_LEN
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

Tested this on the local t_server installation, sending overlong usernames
from a client with --enable-pkcs11 - without the patch, there's no crashes
or anything (= not a security relevant bug), but the server gets confused
and does not send a proper TLS FAIL back.  With the patch, the server 
will send a proper AUTH FAIL

   2024-10-27 10:34:48 AUTH: Received control message: AUTH_FAILED,Username or password is too long. Maximum length is 128 bytes

We have a bit more work to do (the client is not properly rejecting
overlong usernames either, at least if reading an "--auth-user-pass up.txt"
file) - but at least the server side is behaving more nicely now.

Your patch has been applied to the master and release/2.6 branch (bugfix).

commit a7f80d402fb95df3c58a8fc5d12cdb8f39c37d3e (master)
commit b98ff0e7c60c6592a2e8d2c80dfd5999e5d2e65b (release/2.6)
Author: Arne Schwabe
Date:   Mon Oct 28 14:55:04 2024 +0100

     Refuse clients if username or password is longer than USER_PASS_LEN

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20241028135505.28651-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29675.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


