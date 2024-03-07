Date: Thu, 7 Mar 2024 17:29:10 +0100 (CET)
Message-Id: <202403071629.427GTAg1079846@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240307140355.32644-1-gert@...1296...>
References: <20240307140355.32644-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Persist-key: enable persist-key
 option by default
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for this.  We discussed this and nobody seemed to remember why
persist-key was configurable really ("you could swap out the key + cert
while openvpn is running and then SIGUSR1 it", but yeah, who does this?)
- so thanks for throwing out these extra code paths.

Tested with the full server/client rig.

Your patch has been applied to the master branch.

commit 802fcce5448741bb1e34dd06ac3674b6b6c55a94
Author: Gianmarco De Gregori
Date:   Thu Mar 7 15:03:55 2024 +0100

     Persist-key: enable persist-key option by default

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Message-Id: <20240307140355.32644-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28347.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


