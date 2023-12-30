Date: Sat, 30 Dec 2023 17:31:19 +0100 (CET)
Message-Id: <202312301631.3BUGVJiU055679@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231230143733.4426-1-gert@...1296...>
References: <20231230143733.4426-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove support for NTLM v1
 proxy authentication
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

The code change itself is fairly small and (git diff -w) easy to verify.

The patch is much larger because it removes all DES related code now
(which is welcome).

I have added a comment to Changes.rst as requested.

Lightly tested on FreeBSD / t_client - no NTLM proxy here, so that part
isn't tested, only "all the other proxies".

Your patch has been applied to the master branch.

commit 21910ebc2ee8a6138eb2af8d38056d2b94e59f9c
Author: Frank Lichtenheld
Date:   Sat Dec 30 15:37:33 2023 +0100

     Remove support for NTLM v1 proxy authentication

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20231230143733.4426-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27862.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


