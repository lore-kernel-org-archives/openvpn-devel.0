Date: Mon, 28 Jul 2025 10:04:59 +0200 (CEST)
Message-Id: <202507280804.56S84xjX041635@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250723083816.71604-2-kprovost@...2661...>
References: <20250723083816.71604-2-kprovost@...2661...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: support float
 notifications on FreeBSD
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
To: Kristof Provost <kp@...1376...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks.  Tested, works (and I already got chided for my lack of faith).

Uncrustify complained about whitespace conventions, so I've adjusted those
(whitespace-only, no code changes), and the patch did not apply "as is"
because Antonio changed a bit in dco_freebsd.h in the mean time so one
line of diff context was different - trivial fix.

I tested this with the kernel patch in https://reviews.freebsd.org/D51468,
on top of a 14.2-RELEASE-p4 kernel - v4/v4 float on an udp4 socket, v4/v4
and v6/v6 float on an udp6 dual-stack socket.


Running an "old binary" on top of a "very new kernel" has a bit of risk -
if a client floats, userland will see an "Unknown kernel notification 2"
and kill the instance

  SIGTERM[soft,ovpn-dco: unknown reason] received, client-instance exiting

this is somewhat unavoidable as userland depends on having the kernel
constant available.  So, for the sake of the archives - if you upgrade
your FreeBSD and an OpenVPN server kills clients on float, upgrade your
userland (old server + old kernel would not support float at all, and
clients will just time out).


Your patch has been applied to the master branch.

commit b66b80b2ab73bb422826911b675798e6b789ef03
Author: Kristof Provost
Date:   Wed Jul 23 10:36:49 2025 +0200

     dco: support float notifications on FreeBSD

     Signed-off-by: Kristof Provost <kprovost@...2661...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250723083816.71604-2-kprovost@...2661...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32282.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


