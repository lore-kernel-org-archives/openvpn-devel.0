Date: Thu, 30 Oct 2025 22:14:23 +0100 (CET)
Message-Id: <202510302114.59ULENN8026695@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251030194736.2151-1-gert@...1296...>
References: <20251030194736.2151-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: iservice: check return value of
 MultiByteToWideChar
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

Not sure if MultiByteToWideChar() could ever fail here (UTF8 decoding
errors are only reported if MB_ERR_INVALID_CHARS is passed in), but
then, checking for an error here will ensure that we can't crash 
further down.  So, good practice.

I have verified that all callers of utf8to16_size() and utf8to16()
can handle NULL returns fine, so this is safe.

Your patch has been applied to the master and release/2.6 branch
(bugfix, with some shoehorning).

commit fdd4072541ba52e297c19672d3b1e7021d14bc91 (master)
commit 5b5fdb05d969abc0be7a701c752821299cb98d5e (release/2.6)
Author: Heiko Hund
Date:   Thu Oct 30 20:47:31 2025 +0100

     iservice: check return value of MultiByteToWideChar

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1306
     Message-Id: <20251030194736.2151-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34071.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


