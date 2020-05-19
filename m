Date: Tue, 19 May 2020 15:07:39 +0200 (CEST)
Message-Id: <202005191307.04JD7dNv022365@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200518155427.17283-1-arne@...1227...>
References: <20200518155427.17283-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Refuse server mode on Android
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

(I would have ACKed this, but David was faster... "#ifdef ANDROID, if
not excessive, is mostly Arne's decision anyway")

commit cc76e177606ba336bbcb63ebc5e4d85b4116057f
Author: Arne Schwabe
Date:   Mon May 18 17:54:27 2020 +0200

     Refuse server mode on Android

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20200518155427.17283-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19904.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


