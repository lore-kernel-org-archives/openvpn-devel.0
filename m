MIME-Version: 1.0
References: <20200309131728.380-1-simon@...2293...>
 <20200309131728.380-10-simon@...2293...>
In-Reply-To: <20200309131728.380-10-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 24 Mar 2020 11:33:17 +0200
Message-ID: <CAGyAFMWuZs3MZ9JpHK_7MEaHZ8rg8nCfBh1japzNsW0_Pq5hcQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 10/12] openvpnmsica,
 tapctl: Revise default hardware ID management
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

Hi,

Since we are getting rid of default hwid, shouldn't we do it also for tapctl and
make "tapctl list" return all adapters?

Since it defaults to root\tap0901,  "tapctl list" doesn't show anything for me,
which is a bit confusing:

> c:\Users\lev\Projects\openvpn\x64-Output\Debug>tapctl.exe list
>

If I want to see tap adapters, I need to explicitly specify tap0901:

> c:\Users\lev\Projects\openvpn\x64-Output\Debug>tapctl.exe list --hwid tap0901
> {82A7A5F5-4D32-4274-84CF-DF36171159BD}  Local Area Connection

