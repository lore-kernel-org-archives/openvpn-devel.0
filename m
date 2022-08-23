MIME-Version: 1.0
References: <CAKuzo_hyreVwf5DEDGQNOXNtci8pE8Kf=tBCnhw0X+Xh0PEEFQ@...278...>
 <20220822085647.389-1-lstipakov@...277...>
 <CAGyAFMUg+s++qWhayRKp-LGek2zUXVXga37JKMaRmqqRyk6RCA@...278...>
In-Reply-To: <CAGyAFMUg+s++qWhayRKp-LGek2zUXVXga37JKMaRmqqRyk6RCA@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 23 Aug 2022 15:45:37 +0300
Message-ID: <CAGyAFMX-bxsDXUbOWqEPpenpEURFEL8njYsVb+H2z9iB4OUv3w@...278...>
Subject: Re: [Openvpn-devel] [PATCH v103] dco-win: implement ovpn-dco
 support in P2P Windows code path
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>, Lev Stipakov <lev@...515...>

Another feedback - I asked our corp QA engineer to give this build a
try, here are results:

---
Testing OpenVPN GUI on Windows 11:
- install, remove and upgrade from 2.5.7 to
https://github.com/lstipakov/openvpn-build/actions/runs/2902240643
- Connection with `DCO` via autologin, user-locked, cloud, user-locked
with Google and DUO authentication
- Connection with `DCO` through `TCP` and `UDP` protocols
- Basic test for connection with `TAP`  and `Wintun`  drivers
- Reconnecting after network change with `DCO`
---

-Lev

