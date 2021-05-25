MIME-Version: 1.0
References: <20210522033232.20548-1-selva.nair@...277...>
In-Reply-To: <20210522033232.20548-1-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 25 May 2021 09:34:41 +0300
Message-ID: <CAGyAFMV0kU+eRhHkP3CGE4rrqEA82J7L4g_QNXQD-izF-86CEw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/3] Make it explicit that WIndows build
 requires UNICODE support
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

Hi,

Change makes sense, indeed it was possible to at least try to build
iservice in non-UNICODE setup. Which doesn't make much sense since we
always build with UNICODE
for releases.

Built and smoke-tested with MSVC. Haven't noticed any issues.

Acked-by: Lev Stipakov <lstipakov@...277...>

