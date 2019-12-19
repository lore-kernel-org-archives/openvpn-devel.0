Date: Thu, 19 Dec 2019 21:10:20 +0100 (CET)
Message-Id: <201912192010.xBJKAKAv033864@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191219111821.313-1-lstipakov@...277...>
References: <20191219111821.313-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun.c: do not add/remove routes
 on tun open/close
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

Your patch has been applied to the master branch.

As discussed on the IRC meeting, I've amended the commit message to make
it more clear what happened.  See below.

(Test built on ubuntu 1604, and also stared-at-code and asked confused
questions :-) )

commit 4f2289893d9d1d448e9654b00d18e13f8fb0936c
Author: Lev Stipakov
Date:   Thu Dec 19 13:18:21 2019 +0200

     tun.c: do not add/remove on-link IPv4 route on tun open/close
    
     Commit 1c4a47f added route manipulation to open/close tun functions
     (for the IPv4 on-link network), but it turns out to be not needed
     at all.

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Simon Rozman <simon@...2293...>
     Message-Id: <20191219111821.313-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19256.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


