MIME-Version: 1.0
References: <20210511075739.158-1-lstipakov@...277...>
In-Reply-To: <20210511075739.158-1-lstipakov@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 11 May 2021 11:04:39 +0300
Message-ID: <CAGyAFMX-1qyehQ1jJGcvAYBN7BHB8489ejtkdDN+OWPTK1MLoA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] openvpnmsica: properly schedule reboot
 in the end of installation
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
Cc: Lev Stipakov <lev@...515...>

This is a bugfix (as well as ground work for ovpn-dco driver
installation), so could be applied to 2.5 and master branches.

A corresponding PR to openvpn-build, which invokes this new custom
action, is here: https://github.com/OpenVPN/openvpn-build/pull/215

-- 
-Lev

