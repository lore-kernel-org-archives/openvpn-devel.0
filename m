Date: Tue, 13 May 2025 17:38:23 +0200 (CEST)
Message-Id: <202505131538.54DFcNGn002510@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250513151006.13617-1-gert@...1296...>
References: <20250513151006.13617-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: win: remove Wintun support
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

The patch looks big, and we needed a few tries due to conflicts with
the commit before that also changed message types *and* introduced 
a WINTUN references... sorry for the noise.

Under the hood, the patch is quit simple, just taking away special
case branches and code, and I like that a lot :-)

Tested building via GHA, the new windows based buildbot and a local
MinGW build.  Stared a lot at the code and asked questions...

Your patch has been applied to the master branch.

commit ad7a6945144bc6d8e3347b8008e5a31d91f23cd4
Author: Lev Stipakov
Date:   Tue May 13 17:09:59 2025 +0200

     win: remove Wintun support

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250513151006.13617-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31631.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


