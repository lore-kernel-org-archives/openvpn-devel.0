Date: Thu, 3 Feb 2022 11:38:04 +0100 (CET)
Message-Id: <202202031038.213Ac4hu057169@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220203082620.8186-1-a@...2181...>
References: <20220203082620.8186-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: keyingmaterialexporter.c:
 include strings.h
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

FreeBSD manpage confirms that <strings.h> should be used.  Insanity,
but well.

Your patch has been applied to the master and release/2.5 branch (bugfix,
even if not very critical).

commit d93a2b6160759d42d3fbaecc7fc868a7120221ef (master)
commit 2d31bf20dcffaab00a677bab06c8fe3816b6605b (release/2.5)
Author: Antonio Quartulli
Date:   Thu Feb 3 09:26:20 2022 +0100

     keyingmaterialexporter.c: include strings.h

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220203082620.8186-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23702.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


