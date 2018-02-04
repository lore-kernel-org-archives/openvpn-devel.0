Date: Sun, 4 Feb 2018 11:50:03 +0100 (CET)
Message-Id: <201802041050.w14Ao3W3061831@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1517391662-21325-1-git-send-email-arne@...1227...>
References: <1517391662-21325-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Treat dhcp-option DNS6 and DNS
 identical
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

Your patch has been applied to the master and release/2.4 branch.

(2.4 because this is "long-term compatibility" stuff, and fairly 
non-intrusive)

I've taken the liberty to change the commit message and mention that it's
"v3" here :-)

commit 849006bf17bba524e6f3344598adcbe41bedf450 (master)
commit 61a72ecd59a57a50d0757b56b16f4ed3ce700f3f (release/2.4)
Author: Arne Schwabe
Date:   Wed Jan 31 10:41:02 2018 +0100

     Treat dhcp-option DNS6 and DNS identical

     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <1517391662-21325-1-git-send-email-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16413.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


