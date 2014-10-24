Date: Fri, 24 Oct 2014 20:47:05 +0200 (CEST)
Message-Id: <201410241847.s9OIl5Al015794@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1413961660-19251-2-git-send-email-samuli@...515...>
References: <1413961660-19251-2-git-send-email-samuli@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: Modification to address bug
	where OpenVPN enters state where it is unresponsive and
	cannot be terminated. Log output is continuous spew of
	code=995 errors.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: TDivine <tdivine@...1939...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.3 branches.

Since the second patch basically undoes everything the first one does
and uses a different approach, I've merged them into one patch to make
the net change more explicit - and fixed a bit of spurious whitespace.

Also, I've taken the liberty of adding a non-Win32 version of 
tuntap_abort() to tun.h, to avoid breaking compilation elsewhere.

But anyway, thanks for telling us where the problem with our talking to 
the driver was :-)


commit 7aa178381241ae015273914065471e0d271ee1c3 (master)
commit 4fe957aabb9289b13ce9c28854d1e912efee9b77 (release/2.3)

Author: TDivine
Date:   Wed Oct 22 10:07:39 2014 +0300

    Fix "code=995" bug with windows NDIS6 tap driver.
    
    Modification to address bug where OpenVPN enters state where it is
    unresponsive and cannot be terminated. Log output is continuous spew of "code=995" errors.
    
    Revised fix for code=995 sped bug.
    
    Adding new tap adapters while connected:
      https://community.openvpn.net/openvpn/ticket/430
    
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: <1413961660-19251-2-git-send-email-samuli@...515...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/9165
    Signed-off-by: Gert Doering <gert@...1296...>
    
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: <1413961660-19251-3-git-send-email-samuli@...515...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/9167
    Signed-off-by: Gert Doering <gert@...1296...>



--
kind regards,

Gert Doering


