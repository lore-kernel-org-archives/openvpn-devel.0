Date: Wed, 17 Jan 2018 12:27:38 +0100 (CET)
Message-Id: <201801171127.w0HBRcHp092644@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1516185516-28125-1-git-send-email-arne@...1227...>
References: <1516185516-28125-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Replace buffer backed strings
 for management_android_control with simple stack variables
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

Acked-By: Gert Doering <gert@...1296...>

Patch looks reasonable, and is inside TARGET_ANDROID anyway, so if you
break it, it's your bug reports...

Your patch has been applied to the master branch.

commit 8fcc63b2e7d24d2fbf6d7ab10767c2347c723d31
Author: Arne Schwabe
Date:   Wed Jan 17 11:38:36 2018 +0100

     Replace buffer backed strings for management_android_control with simple stack variables

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1516185516-28125-1-git-send-email-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=1516185516-28125-1-git-send-email-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


