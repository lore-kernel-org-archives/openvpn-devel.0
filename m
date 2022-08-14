MIME-Version: 1.0
References: <20220813211104.411554-1-arne@...1227...>
In-Reply-To: <20220813211104.411554-1-arne@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Sun, 14 Aug 2022 12:02:29 +0300
Message-ID: <CAGyAFMWCpYvJ_YcxOnYbdAjPPFtb1PeUCntHeHQwxV4pYx6ftg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Allow querying DCO status via
 management status
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Code looks good and does what it says - tested on Linux with
--status-version 2 and sending SIGUSR2.

Is the first line of the commit message ("Allow querying DCO status
via management status") descriptive enough?

Since the change allows users to see DCO status without a management
interface, just by sending SIGUSR2, maybe
"multi.c: include DCO status in status version 2" would be better?

Acked-by: Lev Stipakov <lstipakov@...277...>

