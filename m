Date: Wed, 15 Jul 2020 15:15:43 +0200 (CEST)
Message-Id: <202007151315.06FDFh7B068599@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200711093655.23686-7-arne@...1227...>
References: <20200711093655.23686-7-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: client-connect: Change
 cas_context from int to enum
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

Your patch has been applied to the master branch.

Fixed the typo in the commit message as requested.

Tested yesterday on client and server testbed, which tests all these states.

I have not modified the "static" hunk - it would be a better fit in 
another patch, but it's useful, reasonably harmless and does not warrant 
a new round with a "v6" for two patches just to move this hunk.

commit 4d500451e8b19deadb619d4ecf977363c6560a2e
Author: Arne Schwabe
Date:   Sat Jul 11 11:36:48 2020 +0200

     client-connect: Change cas_context from int to enum

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20200711093655.23686-7-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20292.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


