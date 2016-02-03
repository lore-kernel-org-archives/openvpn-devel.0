References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <56B26675.4000902@...1227...>
Date: Wed, 3 Feb 2016 21:43:33 +0100
MIME-Version: 1.0
In-Reply-To: <1453835508-26119-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v3] interactive service v3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net


>  AC_USE_SYSTEM_EXTENSIONS
> +AM_PROG_CC_C_O

I have no idea what this does. The docu tells me that it is obsolescent.


Other than I looked at other code that is modfied in OpenVPN itself. I
have no idea about all the windows specific stuff. But from the look it
looks good and the other parts it touches are good. So a cautinary ACK
from me.

Arne


