Date: Thu, 11 Jan 2018 12:59:29 +0100 (CET)
Message-Id: <201801111159.w0BBxTFv009429@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1513246897-28171-1-git-send-email-steffan@...1856...>
References: <1513246897-28171-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_openssl: fix compiler
 warning by removing getbio() wrapper
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch.

commit 006d6a57b8835c15222359bfb42c95005723394c (master)
commit 041b94c0ab1981c35f4294afc3f9e4f73ba9056c (release/2.4)
Author: Steffan Karger
Date:   Thu Dec 14 11:21:37 2017 +0100

     ssl_openssl: fix compiler warning by removing getbio() wrapper

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1513246897-28171-1-git-send-email-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16083.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


