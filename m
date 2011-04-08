Date: Fri, 8 Apr 2011 18:00:17 +0200
From: =?iso-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <5110611539.20110408180017@...449...>
In-Reply-To: <1302106222-10256-1-git-send-email-davids@...1347...>
References: <1302106222-10256-1-git-send-email-davids@...1347...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Change the default --tmp-dir path to a
	more suitable path
Reply-To: =?iso-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello David,

> On Windows, it will look up %TEMP% and %TMP% first, and if that doesn't give any clues, it
> will fallback to C:\WINDOWS\Temp in the end.

I think that's not the right location.

Use
http://msdn.microsoft.com/en-us/library/system.environment.getfolderpath.aspx

with this constant
CSIDL_LOCAL_APPDATA to locate system/language independant:
"C:\Documents and Settings\username\Local Settings\Application Data"
http://msdn.microsoft.com/en-us/library/bb762494.aspx
and than create OpenVPN\temp at this location.

Windows has no special temp location that is "allowed" from MS.

greetings
Carsten


