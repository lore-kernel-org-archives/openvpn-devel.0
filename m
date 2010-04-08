From: Marcel =?iso-8859-1?q?Pennewi=DF?= <mailinglists@...1145...>
Date: Thu, 8 Apr 2010 10:10:16 +0200
References: <OF16C98C16.EEA12E96-ONC12576FD.006F673E-C12576FD.00713519@...1343...>
	<4BBCF086.2060005@...1147...>
	<OF879B156A.CA01CFA3-ONC12576FF.001EF181-C12576FF.00215109@...1343...>
In-Reply-To: <OF879B156A.CA01CFA3-ONC12576FF.001EF181-C12576FF.00215109@...1343...>
MIME-Version: 1.0
Message-Id: <201004081010.16252.mailinglists@...1145...>
Subject: Re: [Openvpn-devel] DNS problems with openvpn 2.1 on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Thursday 08 April 2010 08:03:54 Johan Ymerson wrote:
> I have tried different values for route-delay and tap-sleep, but it doesn't
>  help.

AFAIR our clients use:
route-method exe
route-delay 2
ip-win32 dynamic

No one of our win7-users complained about this problem until now.

Marcel

