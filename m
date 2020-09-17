MIME-Version: 1.0
References: <20200916141755.1923-1-themiron@...2010...>
 <202009170845.08H8juQs054283@...2054...>
 <000001d68cd0$2dd4df20$897e9d60$@yandex-team.ru>
 <20200917085739.GQ976@...1296...>
In-Reply-To: <20200917085739.GQ976@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 17 Sep 2020 12:22:40 +0300
Message-ID: <CAGyAFMV4=9DnaTomRPDCR31=tEro9Eom1Q5LWKX66xUtpGK1DA@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix fatal error at
 switching remotes (#629)
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
To: Gert Doering <gert@...1296...>
Cc: Vladislav Grishenko <themiron@...2010...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> openvpn3, as I understand, sets up "all host routes!" right at the start

It depends on how openvpn3 library is used.

OpenVPN3 Linux client adds bypass route for the specific remote
just before connection attempt. Same for our Connect Windows / Mac clients,
which are partially closed-source, but this specific logic is part of
opensource library and "agent" (windows agent is opensourced,
mac agent is still closed-source) - a component similar to "iservice".

IIRC, "test" client (cli) indeed adds all routes from the beginning.

-- 
-Lev

