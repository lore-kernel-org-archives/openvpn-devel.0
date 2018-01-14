Date: Sun, 14 Jan 2018 19:09:54 +0100 (CET)
Message-Id: <201801141809.w0EI9sVw054132@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1515884446-27152-1-git-send-email-selva.nair@...277...>
References: <1515884446-27152-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use RSA_meth_free instead of
 free
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch.

commit 508741c1cf99b8a24205601800fa5056c6d0192b (master)
commit 73bb2a7d32069343b8bfd211bd5783482c8a490d (release/2.4)
Author: Selva Nair
Date:   Sat Jan 13 18:00:46 2018 -0500

     Use RSA_meth_free instead of free

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Emmanuel Deloget <logout@...260...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <1515884446-27152-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16207.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


