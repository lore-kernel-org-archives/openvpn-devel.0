MIME-Version: 1.0
References: <20221229182739.1477336-1-selva.nair@...277...>
 <20221229182739.1477336-2-selva.nair@...277...>
In-Reply-To: <20221229182739.1477336-2-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Sat, 31 Dec 2022 09:40:27 +0200
Message-ID: <CAGyAFMUeXrvaYM3Yaq4vUCgYX-GT0EaFuB9ZYoAjJwS=D1PnDg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Cleanup: Close duplicated handles
 in interactive service
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
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

Hi,

Indeed, no need to keep those handles for the duration of openvpn
process lifetime,
they're needed only for registration.

Compiled and tested.

Acked-by: Lev Stipakov <lstipakov@...277...>

