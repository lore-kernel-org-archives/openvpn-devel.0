Date: Sun, 14 Jan 2018 20:50:40 +0100 (CET)
Message-Id: <201801141950.w0EJoeKW062144@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1515956662-30572-1-git-send-email-selva.nair@...277...>
References: <1515956662-30572-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Bring cryptoapi.c upto speed
 with openssl 1.1
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

(Technically it might not look like a bugfix, but since we decided 
"2.4 gets support for OpenSSL 1.1" and cryptoapi was overlooked, this 
*makes* it a bugfix.  I have not even compile-tested it, trusting Selva
and Steffan here - and buildbot will tell me if they overlooked 
something :-) )

commit 862cbe538b6d53435f60065b0235639095c9ad0d (master)
commit 94de253e720154efd2202281042560af18f2bdcb (release/2.4)
Author: Selva Nair
Date:   Sun Jan 14 14:04:22 2018 -0500

     Bring cryptoapi.c upto speed with openssl 1.1

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <1515956662-30572-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/search?l=mid&q=1515956662-30572-1-git-send-email-selva.nair@...277...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


