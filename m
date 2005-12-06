From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] Disable --redirect-gateway
In-Reply-To: <dn52v4$51h$1@...165...>
Message-ID: <Pine.LNX.4.64.0512070752400.27495@...210...>
References: <dn52v4$51h$1@...165...>
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
Date: Tue Dec  6 23:11:02 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: Tim Niemueller <gmane@...513...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, 6 Dec 2005, Tim Niemueller wrote:

> Hi OpenVPN developers.
>
> I wrote a small plug-in that integrates OpenVPN into NetworkManager (see
> http://www.niemueller.de/software/patches/networkmanager.php or
> NetworkManager CVS at http://www.gnome.org/projects/NetworkManager/).
>
> Someone pointed out that OpenVPN 2.1 will use the --redirect-gateway by
> default. Since this is something that NM does by itself we would like to
> have an option to completely disable this feature.

I can't see anywhere in the change-log that this would now be the 
default, and I can't see why it should be either. Have you verifyed that 
it really is the default in 2.1?

-- 
A. Because people read from top to bottom.
Q. Why should I not top-post?
_________________________________________________________
Mathias Sundman              (^)   ASCII Ribbon Campaign
NILINGS AB                    X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28      / \   NO Word docs in e-mail

