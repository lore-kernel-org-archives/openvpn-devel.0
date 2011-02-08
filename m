Date: Tue, 8 Feb 2011 19:34:56 +0100
From: =?iso-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <499331088.20110208193456@...449...>
In-Reply-To: <4D514C06.5010907@...515...>
References: <4D4BE51E.1050905@...515...> <4D4C7466.4030301@...1147...>
	<4D4FAEB0.3040508@...515...> <4D4FDDF2.6000002@...1147...>
	<4D505025.2010007@...515...> <4D514C06.5010907@...515...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Help testing OpenVPN 2.2-rc Windows installer?
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
To: 

Hello,

> The issue was that the installer did not install msvcr90.dll - that's
> now fixed.

I haven't checked how the installer does it, but there is a standard
procedure to do this!
http://support.microsoft.com/kb/326922/en-us

Why it should be done correctly: http://en.wikipedia.org/wiki/DLL_hell

Additionally good windows software is designed to meet criteria of
windows logo program, even if you don't want to certify it.

The Windows 7 Software Logo Program
http://msdn.microsoft.com/en-us/windows/dd203105.aspx

greetings
Carsten


