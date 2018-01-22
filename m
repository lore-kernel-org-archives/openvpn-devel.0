MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Mon, 22 Jan 2018 11:46:50 -0500
Message-ID: <CAKuzo_gEJ3EPR6ghsTB_y=THQnn_eQtjhS0JL5W1bH-SN73Gyw@...278...>
Subject: [Openvpn-devel] reg. TLS 1.2 with cryptoapicert
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

Hi,

If there is any chance of the cryptoapi patch getting into  2.4.5,
please note that it needs this patch first:
https://patchwork.openvpn.net/patch/205/ (the same as #201 merged into
master, but with ifdefs for openssl-0.9.8 and 1.0.0)

Thanks,

Selva

