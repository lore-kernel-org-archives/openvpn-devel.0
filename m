References: <CAP=zTkOduThZFBXdewpYv1RQyi9z0Hzaz6MPuRXSt5HkbMTewQ@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <56C71B50.4040502@...1227...>
Date: Fri, 19 Feb 2016 14:40:32 +0100
MIME-Version: 1.0
In-Reply-To: <CAP=zTkOduThZFBXdewpYv1RQyi9z0Hzaz6MPuRXSt5HkbMTewQ@...278...>
Subject: Re: [Openvpn-devel] Enabling TLS Session Resumption in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Shubham Chauhan <shubham13099@...2124...>, openvpn-devel@lists.sourceforge.net



Am 19.02.16 um 14:32 schrieb Shubham Chauhan:
> Hello,
>
> I am currently working on a project that requires SSL VPN to use
> session resumptions.
>
> I need to add the TLS Session Resumption functionality to OpenVPN. Any
> starters as in how I could achieve this?
> I know about the SSL_OP_NO_TICKET flag added to disable the resumption
> process. Will deleting it from the code enable SSL resumption
> automatically?
>
VPN session and SSL session are not necessarily the same. You can
restablish a VPN session with a new TLS session.

I think OpenVPN will still insist on a full authentication in a new
session, even with SSL_OP_NO_TICKET removed.  I would have to the check
the code myself to be sure.

Arne

