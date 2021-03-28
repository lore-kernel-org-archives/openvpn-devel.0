Date: Sun, 28 Mar 2021 16:48:13 +0200 (CEST)
Message-Id: <202103281448.12SEmDPC001125@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210328143633.10300-1-arne@...1227...>
References: <20210328143633.10300-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix #elif TARGET_LINUX missing
 defined() call
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

Acked-by: Gert Doering <gert@...1296...>

Not sure why it is not erroring-out there, but "symbol not defined"
seems to be good enough as "0".  OTOH, all the other code uses "#ifdef"
or "defined(TARGET_FOO)", so bringing this in line is good.

Your patch has been applied to the master branch.

commit d11c273b07c422dde358e1b1caafd12bf8682e70
Author: Arne Schwabe
Date:   Sun Mar 28 16:36:33 2021 +0200

     Fix #elif TARGET_LINUX missing defined() call

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210328143633.10300-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21884.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


