MIME-Version: 1.0
Sender: flagel@...277...
Date: Sun, 14 Aug 2011 00:24:33 +0200
Message-ID: <CANdUpHPLMwTJRD69vo+ZUQi=wFQEX=s-5Lt72Xhvn+dW+1WtwA@...278...>
From: Tanel Rebane <tanel@...1495...>
Subject: [Openvpn-devel] [PATCH] Make easy-rsa/2.0/vars handle paths with
	whitespaces
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello,

Line 29 of vars, export KEY_CONFIG=`$EASY_RSA/whichopensslcnf
$EASY_RSA`, cannot handle whitespaces contained in $EASY_RSA. This
line could be changed - depending on preference - to either of:
a) export KEY_CONFIG="`"${EASY_RSA}"/whichopensslcnf "${EASY_RSA}"`"
b) export KEY_CONFIG=$("${EASY_RSA}"/whichopensslcnf "${EASY_RSA}")

Regards,
Tanel Rebane

