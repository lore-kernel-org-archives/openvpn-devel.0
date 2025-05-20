Date: Tue, 20 May 2025 10:25:48 +0200 (CEST)
Message-Id: <202505200825.54K8PmcX027639@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250520073354.17091-1-gert@...1296...>
References: <20250520073354.17091-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dns: fix potential NULL pointer
 dereference
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

Thanks for this.

Found by Coverity - in the case of a problem in platform_create_temp_file(),
the old code would have accessed strlen(NULL) and *boom*.  Unlikely, but
arguably still possible if something changes with --tmpdir while openvpn
is running, or so.

Stared at code v2+v3, like v3 better :-) - tested non-error branch
on Linux and FreeBSD (its own can of worms), works.

Your patch has been applied to the master branch.

commit d1045d19bf4ea1f717edac7c67f20e9d8eb3a261
Author: Heiko Hund
Date:   Tue May 20 09:33:48 2025 +0200

     dns: fix potential NULL pointer dereference

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250520073354.17091-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31720.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


