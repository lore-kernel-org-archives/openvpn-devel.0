Date: Sun, 4 Oct 2020 14:19:23 +0200 (CEST)
Message-Id: <202010041219.094CJNKk043968@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201001225319.25125-1-themiron@...2010...>
References: <20201001225319.25125-1-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH applied] Re: Speedup TCP remote hosts
 connections
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
To: Vladislav Grishenko <themiron@...2010...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I have run a number of TCP client connect tests, to a very close
server (speedup very noticeable!), to distant server (still some
difference), and to a non-reachable IP address (because I was 
worried that this would block out management, but it doesn't -
it just shifts the "delay 1 s" to openvpn_connect(), and makes
it a "max 1s" instead of a hard sleep).

I have not looked into manage.c as closely, but from a quick
glance, this also looks reasonable.

Since we need a RC3 anyway (due to the redirect-gateway bug), and
Arne's motto for 2.5 is "MAKE THINGS FAST!", I think this still
fits into 2.5.

commit b68aa00603332357e6c711e91c5b4ba04d78294b (master)
commit d08b66f39cf80733a51e1607386dc4993faef09f (release/2.5)
Author: Vladislav Grishenko
Date:   Fri Oct 2 03:53:19 2020 +0500

     Speedup TCP remote hosts connections

     Signed-off-by: Vladislav Grishenko <themiron@...2010...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20201001225319.25125-1-themiron@...2010...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21139.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


