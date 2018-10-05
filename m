Date: Fri, 5 Oct 2018 16:46:39 +0200 (CEST)
Message-Id: <201810051446.w95EkdoD043837@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181005131632.32515-1-arne@...1227...>
References: <20181005131632.32515-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Skip error about
 ioctl(SIOCGIFCONF) failed on Android
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

Acked-by: Gert Doering <gert@...1296...>

Passes the style guide filter, fixes an annoying and misleading warning,
and affects only Android.  Fixed two typos in the comment.

Your patch has been applied to the master branch.

commit 5e80600a45c22dd96eb1dcce6a4af7a6c361396b
Author: Arne Schwabe
Date:   Fri Oct 5 15:16:32 2018 +0200

     Skip error about ioctl(SIOCGIFCONF) failed on Android

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20181005131632.32515-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17565.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


