From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Re: OpenVPN 2.1-beta3 released
In-Reply-To: <OF00A19FB9.279F22BF-ONC125709D.002B6A40-C125709D.002F264D@...473...>
Message-ID: <Pine.LNX.4.58.0510170720200.31752@...41...>
References: <OF00A19FB9.279F22BF-ONC125709D.002B6A40-C125709D.002F264D@...473...>
MIME-Version: 1.0
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
Date: Mon Oct 17 06:29:06 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Nico Prenzel <nico.prenzel@...473...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, 17 Oct 2005, Nico Prenzel wrote:

> 
> Hello James Yonan,
> 
> you stated following in the changelog to 2.1 beta3 release:
> 
> >>* openvpn --version will show [LZO1] or [LZO2], depending on
> >>  version that was linked.
> 
> Could it be that the released beta3 has been linked with lzo1 libraries as
> I always receive the following lines on openvpn startup (before tunnel
> build up!) ?
> 
> Mon Oct 17 09:52:17 2005 OpenVPN 2.1_beta3 Win32-MinGW [SSL] [LZO1] built
> on Oct 16 2005
> Mon Oct 17 09:52:17 2005 LZO compression initialized
> 
> I've used the win32 version (openvpn-2.1_beta3-install.exe) for
> installation.
> 
> Do you have plans to incorporate the lzo2 version into win32 build? Or, did
> I miss something?

Yes, I do plan to incorporate LZO2 into the Windows build of OpenVPN 2.1
-- I just haven't gotten around to it yet.

James


