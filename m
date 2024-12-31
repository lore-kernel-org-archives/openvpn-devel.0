From: Ben Boeckel <ben.boeckel@...2851...>
Date: Tue, 31 Dec 2024 21:46:28 +0100
Message-ID: <20241231204629.1210040-1-ben.boeckel@...2851...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/1] Remove system password timeout
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

PR: https://github.com/OpenVPN/openvpn/pull/649

Thanks,

--Ben

Ben Boeckel (1):
  console_systemd: remove the timeout when using `systemd-ask-password`

 src/openvpn/console_systemd.c | 1 +
 1 file changed, 1 insertion(+)


base-commit: cb878882388bfe9dc49b116190c5c6ae8918322d
-- 
2.47.1


