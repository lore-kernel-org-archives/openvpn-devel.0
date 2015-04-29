Message-ID: <4d1cdaaa3258006757ba75e40a8de9f4.squirrel@...2027...>
In-Reply-To: <55413AFE.4080906@...68...>
References: <1427784294-22175-1-git-send-email-samuli@...515...>
	<551A4A9B.6010508@...68...> <1430309264.1291.59.camel@...1866...>
	<55413AFE.4080906@...68...>
Date: Wed, 29 Apr 2015 20:33:02 -0000
From: "David Woodhouse" <dwmw2@...1866...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Remove useless dash escapes from the
 man-page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net


> That would mean we either go into autoconf territory to test for groff
> run-time behaviour, or we use a particular unique sequence and do our
> own post-processing.

The latter is baaically the approach I took in
http://git.infradead.org/users/dwmw2/openconnect.git/commitdiff/5f15c83f2

-- 
dwmw2


