Date: Tue, 30 Aug 2022 21:57:07 +0200 (CEST)
Message-Id: <202208301957.27UJv74w093000@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220829190124.2636045-1-gert@...1296...>
References: <20220829190124.2636045-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Adjust Linux+FreeBSD DCO device
 name handling to 'non DCO linux style'
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for the review.  strcmp() fixed (space) as instructed.

I'll send a manpage patch next to (try to...) document the expected behaviour
across platforms.

Your patch has been applied to the master branch.

commit a5cf4cfb77f74588759d96258e7435e54db12b2c
Author: Gert Doering
Date:   Mon Aug 29 21:01:24 2022 +0200

     Adjust Linux+FreeBSD DCO device name handling to 'non DCO linux style'

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Kristof Provost <kprovost@...2661...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20220829190124.2636045-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25134.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


