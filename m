Date: Mon, 10 Oct 2022 16:37:39 +0200 (CEST)
Message-Id: <202210101437.29AEbdlY059785@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221010122745.19809-1-wardragon78@...277...>
References: <20221010122745.19809-1-wardragon78@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Insert client connection data
 into PAM environment
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
To: Paolo Cerrito <paolo.cerrito@...2517...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks for providing a v3, and following our sometimes difficult rules
for patch submission.

I have tested this with v4 and v6 connections, and it looks good:

   PLUGIN AUTH-PAM: BACKGROUND: REMOTE: 2001:608:0:814::f000:21
   PLUGIN AUTH-PAM: BACKGROUND: REMOTE: 194.97.140.21

(I have not tested with "both environment variables are unset" but I
think the code in v3 is good.  I have not tested with a PAM module that
actually makes uses of this - but the pam_set_item() and PAM_RHOST matche
the linux manpage, so "it should be fine").

Unfortunately, v3 still had a coding style problem - we require that
if() statements always - no exceptions - have {} brackets, so the
"empty string" part looks like this now:

+        if (remote == NULL)
+        {
+            remote = "";
+        }

(for "core developers", running uncrustify is required, but since this
was taking so long already, I ran the uncrustify for you and committed
the result)

I have also added a bit more of commit message to explain what the
patch does - how OpenVPN sends this information to the plugin interface,
and how the PAM stack needs it.  This helps future contributors to
understand why certain code lines are the way they are.

Your patch has been applied to the master branch.

commit 8e9f9d031f7f2dbf2a505af297b808f22430a381
Author: Paolo Cerrito
Date:   Mon Oct 10 14:27:46 2022 +0200

     Insert client connection data into PAM environment

     Signed-off-by: Paolo Cerrito <wardragon78@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221010122745.19809-1-wardragon78@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25375.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


