Message-ID: <52E10721.8060105@...1227...>
Date: Thu, 23 Jan 2014 13:12:17 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <20130620192348.GW20843@...1296...>
	<1371811708-8528-1-git-send-email-arne@...1227...>
In-Reply-To: <1371811708-8528-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [Patch v7] Add support of utun devices under
 Mac OS X
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am 21.06.13 12:48, schrieb Arne Schwabe:
> +to select a specific utun instance. To force using the tun.kext (/dev/tunX) use
> +.B \-\-dev\-node tun
> +. When not specifying a
> +.B \-\-dev\-node
> +option openvpn will first try to open utun, and fall back to tun.kext.
I just noticed that this does not work because man does ignore the line
starting with a ".".

Does anyone know how to fix this? My attempts of escaping the . were not
fruitful.

Arne

