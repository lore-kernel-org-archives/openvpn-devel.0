Date: Wed, 10 Dec 2025 10:44:11 +0100 (CET)
Message-Id: <202512100944.5BA9iBoc008474@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251210072951.25753-1-gert@...1296...>
References: <20251210072951.25753-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: iservice: set adapter DNS only
 with search domains
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

So this is a workaround for windows DNS "search domain" and NRPT interfering
in interesting ways - to make "search domain" work (aka "append these domains
to unqualified hostnames") the search domain + DNS server need to be
configured on the VPN interface.  To make "resolve domain" work in non-
surprising ways (aka "query that nameserver for these domains *and only*
for these domains") the DNS server must not be added to the VPN interface...

In mobile environments with DNS64 and other surprises, querying "all DNS
over the normal WAN, and only corp-internal resolve-domains via VPN" is
the expected behaviour - so what we did so far (resolve-domains go to 
the VPN only, everything else *goes to all DNS servers*) was surprising,
and breaks certain scenarios...

So this does
  - if there is a search-domain
  - or if there is *no* resolve-domain
  - set the DNS on the adapter ("to be used by normal windows DNS processing")

what is not affected by the patch is what we already have
  - if there is a resolve-domain, set up a NRTP rule ("for this domain,
    query these nameservers [only]")

More details in https://github.com/OpenVPN/openvpn/issues/473 ...

Thanks, Selva, for testing this so quickly :-) - I have only stared at the
code, thought about the logic, and tried to make this explanatory e-mail
as clear as possible.

Your patch has been applied to the master branch.

commit f7afbc511b9d30b27d0b6bbb3ee02dfb1abea646
Author: Heiko Hund
Date:   Wed Dec 10 08:29:44 2025 +0100

     iservice: set adapter DNS only with search domains

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1429
     Message-Id: <20251210072951.25753-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34968.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


