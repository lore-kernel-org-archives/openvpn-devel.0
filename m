Date: Fri, 6 May 2022 14:45:38 +0200 (CEST)
Message-Id: <202205061245.246CjcdB071795@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220505130348.1183195-1-arne@...1227...>
References: <20220505130348.1183195-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement HMAC based session id
 for tls-crypt v2
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

I have stared at the code for a bit (and fixed "the comment"), all looks
reasonable.

Building a test setup took quite a bit of time (different client-side keys, 
different client versions, --verify script, etc.) but the server did 
exactly what was documented -> good :-)

I have also tested "force-cookie", "default" and "allow-noncookie" with
2.5.6 and "same codebase master" clients - it works as documented, *but*
in the "force-cookie" case, the logging is unsatisfactory - --verb 4 will
show "yes, there is activity", but the 

  tls-crypt-v2 force-cookie is enabled,ignoring connection attempt from old client...

message needs --verb 7 -> this needs to go to a more clearly visible
log level, so admins have a better chance to see what is happening.

Discussed on IRC, agreed on "let's make the logging more useful in
a followup patch".


I have rewrapped one msg() line in mudp.c, because the 3 lines nicely fit in
two, making the result more readable.  Also, added a ")" to a comment in
ssl.c, and rewrapped slightly.


Your patch has been applied to the master branch.

commit e7d8c4a72002cbaa7542ea0cff8acca1b971b1f5
Author: Arne Schwabe
Date:   Thu May 5 15:03:48 2022 +0200

     Implement HMAC based session id for tls-crypt v2

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20220505130348.1183195-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24287.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


