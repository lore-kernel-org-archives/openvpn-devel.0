Date: Sat, 6 Oct 2018 22:49:53 +0200 (CEST)
Message-Id: <201810062049.w96KnrnC059503@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20171111161836.23356-3-a@...2181...>
References: <20171111161836.23356-3-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: ensure function declarations
 are compiled with their definitions
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
To: Antonio Quartulli <antonio@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

There was a bit of hassle again due to ENABLE_CRYPTO (so the comment about
the typo in the comment ended up being moot anyway, because that was 
#ifndef ENABLE_CRYPTO) and also because someone took out so much stuff
from misc.h that git could find the proper spot on its own anymore :-)

Verified that the end result still is what we think it is with
--color-moved=zebra - and by test building, of course.

commit 632af53a515aa1570028f9f82e4b11ab7171f3a3
Author: Antonio Quartulli
Date:   Sun Nov 12 00:18:36 2017 +0800

     ensure function declarations are compiled with their definitions

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20171111161836.23356-3-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15820.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


