From: Simon Perreault <nomis80@...401...>
MIME-Version: 1.0
Message-Id: <200506141234.50171.nomis80@...401...>
Subject: [Openvpn-devel] Why must PAM library be dlopened?
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Jun 14 09:36:43 2005
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

I am wondering why the PAM library is dlopened by the auth-pam plugin. Why 
can't it simply be linked with it?

Thanks for not making fun of me for asking this stupid question. ;)

