Date: Mon, 26 Apr 2021 17:19:42 +0200 (CEST)
Message-Id: <202104261519.13QFJgXl068606@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210421234908.12817-1-a@...2181...>
References: <20210421234908.12817-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: options: check for blanks in
 fingerprints and reject string if found
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
To: Antonio Quartulli <antonio@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

That said, I find this function pretty insane, tbh.  Parsing a sequence
of double-digit hex bytes should be doable in half the lines of code,
and without needing to copy bytes to temp buffers to pass to scanf()...
(https://stackoverflow.com/questions/10156409/convert-hex-string-char-to-int)

commit 9e71cf13134c10bb7e952e3dadbcc79884f60b93
Author: Antonio Quartulli
Date:   Thu Apr 22 01:49:08 2021 +0200

     options: check for blanks in fingerprints and reject string if found

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20210421234908.12817-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22182.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


