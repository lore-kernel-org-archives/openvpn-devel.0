MIME-Version: 1.0
References: <1582163803-3342-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1582163803-3342-1-git-send-email-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 20 Feb 2020 11:24:18 +0200
Message-ID: <CAGyAFMVXUUStWv6MKt-JWkDrMU2GEM-v2Wn3hv+GFEGZxRRZrQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix possible access of uninitialized
 pipe handles
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Selva <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Strangely, I do not see this warning (unlike another one about error
in common.c)
with GCC 7.3 despite adding -O1 and -Wmaybe-uninitialized.

Change looks reasonable, compiled with MSVC and MinGW.

Acked-by: Lev Stipakov <lstipakov@...277...>

