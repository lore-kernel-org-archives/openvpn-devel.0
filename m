Date: Fri, 24 Nov 2017 13:42:43 +0100 (CET)
Message-Id: <201711241242.vAOCgg3G037312@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20171101220342.14648-5-steffan@...1856...>
References: <20171101220342.14648-5-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: create_temp_file/gen_path:
 prevent memory leak if gc == NULL
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

commit bd89ebd6a82856c7939b4ade35d14d0178a96986
Author: Steffan Karger
Date:   Wed Nov 1 23:03:42 2017 +0100

     create_temp_file/gen_path: prevent memory leak if gc == NULL

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20171101220342.14648-5-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15703.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


