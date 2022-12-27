Date: Tue, 27 Dec 2022 10:47:29 +0100 (CET)
Message-Id: <202212270947.2BR9lTtc096710@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210907223614.8574-1-selva.nair@...277...>
References: <20210907223614.8574-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow skipping multple remotes
 via management interface
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

We really shouldn't let patches linger for so long... the options.h hunk
had context that now looks completely different, both up and down...

Looking at the code, I do wonder why we increase the unsuccessful_attempts
by the number of entries *skipped*

-                c->options.unsuccessful_attempts++;
+                c->options.unsuccessful_attempts += advance_count;

.. the rest of the patch looks fine.  Haven't actually tested beyond
"compile / t_client".

Your patch has been applied to the master branch.

commit ec5ffe35a394c44b1ea25b7c10dab7da7d792ef2 (master)
commit 42bfb5b03031de7b46a82bdec4f03dbaa1fc6ecb (release/2.6)
Author: Selva Nair
Date:   Tue Sep 7 18:36:14 2021 -0400

     Allow skipping multple remotes via management interface

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20210907223614.8574-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22817.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


