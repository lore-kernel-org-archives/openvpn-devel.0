Date: Wed, 25 Sep 2024 09:06:01 +0200 (CEST)
Message-Id: <202409250706.48P761KI031169@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240925063016.22532-1-gert@...1296...>
References: <20240925063016.22532-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ensure that the AF_UNIX socket
 pair has at least 65k of buffer space
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

The interesting part in this is the change to socket_set_buffers(),
introducing an "increase only" flag to avoid accidentially reducing
socket buffers (which happens when people use --sndbuf with a smaller
buffer size than the socket already has...) - sndbuf/rcvbuf behaviour
is not change, but for the newly created socketpair(), this is "increase
to 64k, or leave at already-larger value"...

Sanity check via a local FreeBSD test run (with lwipovpn) and a GHA run.

Your patch has been applied to the master branch.

commit bae48c1d58d5592ffecca8a490c2440ec3afe959
Author: Arne Schwabe
Date:   Wed Sep 25 08:30:16 2024 +0200

     Ensure that the AF_UNIX socket pair has at least 65k of buffer space

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240925063016.22532-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29413.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


