MIME-Version: 1.0
References: <20210526224919.511-1-selva.nair@...277...>
In-Reply-To: <20210526224919.511-1-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 27 May 2021 10:18:02 +0300
Message-ID: <CAGyAFMW5Q+ojMFaV5m_MTJ7_cpU4kwPBKG11D1V+YwEtZTw0Sw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Replace TEXT(__FUNCTION__) by
 __FUNCTION__ in openvpnmscia.c
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

Looks good, compiled and tested with MSVC.

Note that this needs to be merged after "[PATCH 3/3 v2] Print format
spec changes for tapctl and openvpnmscia".

Acked-by: Lev Stipakov <lstipakov@...277...>

