Date: Sat, 17 May 2025 11:50:58 +0200 (CEST)
Message-Id: <202505170950.54H9ow0x079826@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250517092637.2103-1-gert@...1296...>
References: <20250517092637.2103-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dns: don't publish env vars to
 non-dns scripts
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

As discussed, this is part of the DNS journey - this does not add 
functionality, it just decouples old and new "backend API".

That is, "--up" scripts will no longer see "dns_server_*" environment
variables.  The assumption here is that "--up" scripts that deal with
DNS servers are typically older, and will use "foreign_options_N" anyway,
so do not benefit from the new-style environment variables - and, after
quite a bit of discussion, we agreed that we need to decouple the "frontend"
options (--dns/--dhcp_option DNS) from the backend environment variables
anyway.

So in one of the next patches in the series, "--dns" config coming in
will be exported as "foreign_options_N" *if* --dns-updown is not in use
(and that one will only ever see "dns_*" variables).


I have not tested this beyond "does it compile and pass the existing
--dns-updown script tests" - which is not much of an achievement as
the code is just being moved around, and two calls (in the context of
--up scripts) have been taken away, which is a code path not excercised
in my test sets currently ("--up with DNS config").

Your patch has been applied to the master branch.

commit 412c29c1cbf0565c94ffdbaa435ef3dc6a71e568
Author: Heiko Hund
Date:   Sat May 17 11:26:26 2025 +0200

     dns: don't publish env vars to non-dns scripts

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250517092637.2103-1-gert@...1296...>
     URL: https://www.mail-archive.com/search?l=mid&q=20250517092637.2103-1-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


