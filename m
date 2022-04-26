Date: Tue, 26 Apr 2022 09:53:44 +0200 (CEST)
Message-Id: <202204260753.23Q7rime092253@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220425215822.18569-1-becm@...68...>
References: <20220425215822.18569-1-becm@...68...>
Subject: [Openvpn-devel] [PATCH applied] Re: fix GitHub workflow working
 directories in MinGW builds
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
To: Marc Becker <becm@...68...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Applied (changes look reasonable and simplify future version bumps), and 
verified that everything builds in my GH repo and that it does, indeed, 
build with pkcs11-helper 1.29.0 (.bz2!) and OpenSSL 1.1.1n.

Your patch has been applied to the master branch.

commit 33abca041519b3f72bb6cc3eea81eb987e72d178
Author: Marc Becker
Date:   Mon Apr 25 23:58:22 2022 +0200

     fix GitHub workflow working directories in MinGW builds

     Signed-off-by: Marc Becker <becm@...68...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220425215822.18569-1-becm@...68...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24202.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


