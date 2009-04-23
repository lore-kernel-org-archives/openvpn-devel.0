From: Aleksandar Ivanisevic <aleksandar@...1212...>
Date: Thu, 23 Apr 2009 16:37:16 +0200
Message-ID: <m3prf3sag3.fsf@...1213...>
Mime-Version: 1.0
Sender: news <news@...1062...>
Subject: [Openvpn-devel] rc15 rpm spec glitches
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I've been compiling a rpm of rc15 on rhel5 and noticed a couple of
glitches:

%doc lists management/ dir, but its no longer there, so

%doc contrib/ easy-rsa/ management/ sample-*/ plugin/README.*

should be
 
%doc contrib/ easy-rsa/ sample-*/ plugin/README.*
 
with_pkcs11 tries to pull in pkcs11-helper, but no such package exists
in RHEL, so it must be distro specific, but don't know which distro

%{!?with_pkcs11:BuildRequires: pkcs11-helper-devel}
%{!?with_pkcs11:Requires:      pkcs11-helper}

it builds fine with --nodeps though.

regards,


