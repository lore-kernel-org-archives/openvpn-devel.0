Date: Tue, 2 Mar 2010 13:05:51 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100302120551.GQ9556@...1296...>
References: <1267486301-8399-1-git-send-email-openvpn.list@...1114...>
Mime-Version: 1.0
In-Reply-To: <1267486301-8399-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] [PATCHv2] enhance tls-verify possibility
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
Content-Disposition: inline
To: David Sommerseth <openvpn.list@...1114...>
Cc: Mathieu GIANNECCHINI <mat.giann@...260...>, David Sommerseth <dazo@...384...>, openvpn-devel@lists.sourceforge.net

Hi,

On Tue, Mar 02, 2010 at 12:31:41AM +0100, David Sommerseth wrote:
> From: Mathieu GIANNECCHINI <mat.giann@...260...>
> 
> It should be nice to enhance tls-verify check possibilities against peer
> cert during a pending TLS connection like :
> - OCSP verification
> - check any X509 extensions of the peer certificate
> - delta CRL verification
> - ...

ACK.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

