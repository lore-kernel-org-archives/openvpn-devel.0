Date: Thu, 31 Jul 2025 14:56:19 +0200 (CEST)
Message-Id: <202507311256.56VCuJgB090033@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250731122410.12200-1-gert@...1296...>
References: <20250731122410.12200-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix DNS options duplication on
 PUSH_UPDATE
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

This looks generally reasonable, and if Heiko (who understands the "DNS
related data flow" around options.c way better than I do) says this is
fine, it should be :-) - so, in it goes, just in time for Alpha3...

Test compiled on Windows/MinGW (as the buildbots are busy and I am
impatient).

Your patch has been applied to the master branch.

commit 70d4c6776bd563f487add399bd4acf58c5e22334
Author: Lev Stipakov
Date:   Thu Jul 31 14:24:05 2025 +0200

     Fix DNS options duplication on PUSH_UPDATE

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Heiko Hund <heiko@...515...>
     Message-Id: <20250731122410.12200-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32448.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


