From: Bertrand Jacquin <beber@...1472...>
Date: Sun,  7 Aug 2011 12:59:13 +0200
Message-Id: <1312714757-10317-1-git-send-email-beber@...1472...>
Subject: [Openvpn-devel] Allow to fill Details tab for exe files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi there,

Here is a serie of patch to allow get a details properties tab filled on
exe files using windres tool.

[PATCH 1/4] WIN32: Check for windres tool
[PATCH 2/4] Win32: Add OpenVPN RC file to add fill "Details" exe
[PATCH 3/4] Win32: Fill "Details" properties for openvpn.exe
[PATCH 4/4] Win32: Fill "Details" properties for openvpnserv.exe

-- 
Beber

