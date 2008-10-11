Message-ID: <48F11865.5080903@...1135...>
Date: Sat, 11 Oct 2008 23:19:33 +0200
From: Jochen Wierum <jochen@...1135...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Alternative GUI for OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

My name is Jochen Wierum and I'm a student at a university of applied
science in Germany. We work with OpenVPN there. Since a few weeks, we
also have the option to use SmartCards instead of pkcs12 files.

One problem was, that we have laptops which are used by many people with
different SmartCards. But the OpenVPN GUI doesn't give the you
opportunity to select which SmartCard to use. So I wrote an own small
GUI for Windows in C#. It uses the Management Interface to control
OpenVPN. It is very simple and not perfect. One Problem is that it
requires administrator rights in Vista.

It is written in C# 2008 and requires the .NET Framework 2.0. I released
it under the GNU GPL v2.

Perhaps someone thinks it is useful too.

The source can be downloaded at:
http://www.jowisoftware.de/openvpnmanager_src.zip

The binarys are located at:
http://www.jowisoftware.de/openvpnmanager.zip

Jochen

