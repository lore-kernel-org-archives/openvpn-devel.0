Date: Thu, 20 Feb 2025 11:07:15 +0100 (CET)
Message-Id: <202502201007.51KA7Fsa003281@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <cb8317eb-bfb6-47e8-9bc3-ae5cc603ff21@...68...>
References: <cb8317eb-bfb6-47e8-9bc3-ae5cc603ff21@...68...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove x509-username-fields
 uppercasing
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
To: Corubba Smith <corubba@...68...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks for helping us get rid of our technical debt ;-) - and indeed,
if we declared it obsolete years ago, it should go now.  Someone will
complain, but this is not something which can't be fixed with a small
config change.

I have not tested this beyond a GHA test run (which is compiling on
all platforms but not actually excercising this code).

Your patch has been applied to the master branch.

commit 90d89cc4cc41da6678d244f03c842d1b745f106b
Author: Corubba Smith
Date:   Sat Feb 15 20:00:33 2025 +0100

     Remove x509-username-fields uppercasing

     Signed-off-by: Corubba Smith <corubba@...68...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <cb8317eb-bfb6-47e8-9bc3-ae5cc603ff21@...68...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30915.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


