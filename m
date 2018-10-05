Date: Fri, 5 Oct 2018 12:51:12 +0200 (CEST)
Message-Id: <201810051051.w95ApC2t040828@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1524752664-27946-1-git-send-email-selva.nair@...277...>
References: <1524752664-27946-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Pass the hash without the
 DigestInfo header to NCryptSignHash()
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

Your patch has been applied to the master branch.  Steffan says "it is
a bugfix so it should go to 2.4", but the underlying infrastructure 
does not seem to be there yet (git cherry-pick tries to bring in lots
of extra stuff).  So we can do that, but I need to be told which master
commits I need to bring to 2.4 first.


I have not even stared-at-code very much here, trusting the testers and
Steffan's code-staring abilities.

As a side note (rambling about comments today), this hunk makes the
comment above it slightly misleading:

     /* The hash OID is already in 'from'.  So set the hash algorithm
      * in the padding info struct to NULL.
      */
-    BCRYPT_PKCS1_PADDING_INFO padinfo = {NULL};
+    BCRYPT_PKCS1_PADDING_INFO padinfo = {hash_algo};

.. since we do not set it to NULL anymore...


commit 6b495dc4c5cfc118091ddc9c19330b3c9e3e3dff (master)
Author: Selva Nair 
Date:   Thu Apr 26 10:24:24 2018 -0400

     Pass the hash without the DigestInfo header to NCryptSignHash()

     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <1524752664-27946-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16840.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


