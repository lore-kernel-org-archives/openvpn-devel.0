Date: Thu, 9 Jan 2025 22:25:29 +0100 (CET)
Message-Id: <202501092125.509LPTF9022444@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250109174928.17862-1-gert@...1296...>
References: <20250109174928.17862-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not attempt to decrypt
 packets anymore after 2**36 failed decryptions
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

I have not actually tested this (hard to get 2^35 correctly-bad packets
out into reasonable time...) but stared at the code, and ran the full
client/server test suite "just to be sure".  MaxF understands crypto
and has ACKed it in Gerrit.

As discussed on IRC, I have added a few references to the commit message
so people with a less deep crypto background can inform themselves what
this is all about.

Your patch has been applied to the master branch.

commit ffe0ad41985d7d5f67ae6fc7d58ffa327243f76b
Author: Arne Schwabe
Date:   Thu Jan 9 18:49:28 2025 +0100

     Do not attempt to decrypt packets anymore after 2**36 failed decryptions

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: MaxF <max@...2606...>
     Message-Id: <20250109174928.17862-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30387.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


