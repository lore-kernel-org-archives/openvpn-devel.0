Date: Wed, 23 Jul 2025 11:39:47 +0200 (CEST)
Message-Id: <202507230939.56N9dlnb019737@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250723061034.20240-1-gert@...1296...>
References: <20250723061034.20240-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: multi: store multi_context
 address inside top instance
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
To: Antonio Quartulli <antonio@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

The change is fairly trivial, but helps basically all sort of 
"async things that need to access the multi context" later on.

I do look forward to crashing the new DCO code by running it in
"non multi" mode, though :-)  (which is the risk that code changes
relying on this commit bring with them - being run in a non-multi
environment).

Unlike the other patches in this series, *this* has been also subjected
to a full client/server side test run - it looks harmless, but sometimes
I overlook things a test run finds.

Your patch has been applied to the master branch.

commit 7f5a6deae33a338a23d7e8ff8526db8fdddf4bc2
Author: Antonio Quartulli
Date:   Wed Jul 23 08:10:25 2025 +0200

     multi: store multi_context address inside top instance

     Signed-off-by: Antonio Quartulli <antonio@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250723061034.20240-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32266.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


