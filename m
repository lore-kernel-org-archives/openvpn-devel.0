MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Mon, 15 Jan 2018 12:28:23 -0500
Message-ID: <CAKuzo_gBhwmAkc8EpaE62NpEhQcGPHkASesiurnF9pcghuv2tA@...278...>
Subject: [Openvpn-devel] travis builds
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
To: openvpn-devel@lists.sourceforge.net

Hi,

Out of the 12 or so jobs we have in the travis build matrix a few
sometime fail with "write error" (happened a number of times for some
local feature branches). On restarting only the failed jobs, one by
one, they succeed indicating possible resource starvation?

Is there anything one can do to avoid this?

Thanks,

Selva

