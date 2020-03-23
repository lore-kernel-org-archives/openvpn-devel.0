MIME-Version: 1.0
References: <20200309131728.380-1-simon@...2293...>
 <20200309131728.380-4-simon@...2293...>
In-Reply-To: <20200309131728.380-4-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 23 Mar 2020 11:40:40 +0200
Message-ID: <CAGyAFMUOb=h7rDkNnUgAoARYZntF2ZNM0oHKjRpNG3HJUHbm3g@...278...>
Subject: Re: [Openvpn-devel] [PATCH 04/12] tapctl: Add functions for
 enabling/disabling adapters
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Stared at the patch, compiled with msvc and smoke-tested (tapctl delete {guid}).

New layering (like
tap_enable_interface/enable_device/change_device_state/) makes code
easy to follow.

Acked-by: Lev Stipakov <lstipakov@...277...>

