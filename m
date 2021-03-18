Date: Thu, 18 Mar 2021 08:44:36 +0100 (CET)
Message-Id: <202103180744.12I7iaE2073329@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210317220642.38741-1-openvpn@...2080...>
References: <20210317220642.38741-1-openvpn@...2080...>
Subject: [Openvpn-devel] [PATCH applied] Re: build: Remove compat-lz4
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

I have tested compilation "with default options" on FreeBSD with lz4
(works), Gentoo without lz4 (errors out), Gentoo with lz4 (works), and
with --disable-lz4 on Gentoo without lz4 (works).

I assume some of the buildbots will need a bit of tending now (because
"no lz4 installed, since we bundle it anyway").  They will tell me...

Your patch has been applied to the master branch.

commit 24596b258aa3a9c0bd79e7e7bd4753c48a435408
Author: David Sommerseth
Date:   Wed Mar 17 23:06:42 2021 +0100

     build: Remove compat-lz4

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210317220642.38741-1-openvpn@...2080...>
     URL: https://www.mail-archive.com/search?l=mid&q=20210317220642.38741-1-openvpn@...2080...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


