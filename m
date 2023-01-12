MIME-Version: 1.0
References: <20230111235052.24855-1-a@...2181...>
In-Reply-To: <20230111235052.24855-1-a@...2181...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 12 Jan 2023 10:43:02 +0200
Message-ID: <CAGyAFMUqycz=8qZF3VwWJ8YYVaoJkc0Uru_0+Wgo_uo3-pKPfw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] dco: print proper message in case of
 transport disconnection
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

> -/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */

This specific hunk is beyond my pay grade.

Otherwise looks good, I tested it with the latest dco master and got a
proper error message:

> SIGTERM[soft,ovpn-dco: transport disconnected] received, client-instance exiting

Without this patch, the error message was

> SIGTERM[soft,ovpn-dco: unknown reason] received, client-instance exiting

Acked-by: Lev Stipakov <lstipakov@...277...>

-- 
-Lev

