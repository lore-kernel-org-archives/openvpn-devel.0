MIME-Version: 1.0
Date: Sat, 18 Aug 2012 23:21:32 +0200
Message-ID: <CAHFjfK73YDrEUYL0fi7_8pu=v3W3F-sp=Hty3Un1hyJm=T_79g@...278...>
From: Markus Ferlitsch <m.ferlitsch@...277...>
Subject: [Openvpn-devel] OpenVPN 2.3 alpha - configfile with static keyfile
	does not work!
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

Hi,

I tried to install OpenVPN 2.3 alpha
(openvpn-install-2.3_alpha3-I001-x86_64) - OpenvPN 2.2.2 doesn't work
on Windows 7 64-bit. It generates HMAC-erros on client side.

Now with OpenvPN 2.3 alpha the TLS configfile works fine (none error in logfile)
Bu the config-file with only static secret-file doesn't connect - it's
a bug in alpha I think.

Options error: Parameter tls_exit can only be specified in TLS-mode,
i.e. where --tls-server or --tls-client is also specified.
Use --help for more information.

Or is there a trick how configfiles with static secretfile connects?

Regards, Markus.

