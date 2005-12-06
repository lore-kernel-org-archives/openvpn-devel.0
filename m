From: Tim Niemueller <gmane@...513...>
Message-ID: <dn52v4$51h$1@...165...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Disable --redirect-gateway
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
Date: Tue Dec  6 14:42:02 2005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi OpenVPN developers.

I wrote a small plug-in that integrates OpenVPN into NetworkManager (see
http://www.niemueller.de/software/patches/networkmanager.php or
NetworkManager CVS at http://www.gnome.org/projects/NetworkManager/).

Someone pointed out that OpenVPN 2.1 will use the --redirect-gateway by
default. Since this is something that NM does by itself we would like to
have an option to completely disable this feature.

Is there a chance to get a "disable" flag to the --redirect-gateway
flags or a --no-redirect-gateway flag that can be used to get the old
behaviour? Working with your changes would either mean changing a lot of
code in NM, which is unlikely, or a manual workaround that we delete the
routes that OpenVPN created, which is pretty useless if there is
something as simple as a "disable" flag that could solve this right away.

What do you think, is there a chance to get that flag? Would you accept
an appropriate patch?

	Tim

-- 
    Tim Niemueller <tim@...513...>      www.niemueller.de
=================================================================
 Imagination is more important than knowledge. (Albert Einstein)


