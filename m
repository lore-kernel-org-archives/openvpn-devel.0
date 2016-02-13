From: Selva Nair <selva.nair@...277...>
Date: Sat, 13 Feb 2016 16:15:07 -0500
Message-Id: <1455398109-28880-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 0/2] Support "block-outside-dns" through
	interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

The patch is split into two commits for ease of review
(i) Refactor the code changing no functionality
    -- most of win_wfp_block_dns is moved to a new  file and
       made independent of the rest of the code

(ii) Implement a handler for blocking dns in the interactive service


With (i) and (ii) --block-outside-dns should work without admin privileges
if the interactive service installed and running and GUI is started as user.

Tested on Win7/Win10

