From: Arne Schwabe <arne@...1227...>
References: <1456993146-63968-1-git-send-email-james@...515...>
	<1456993146-63968-9-git-send-email-james@...515...>
Message-ID: <56D959C9.8050802@...1227...>
Date: Fri, 4 Mar 2016 10:47:53 +0100
MIME-Version: 1.0
In-Reply-To: <1456993146-63968-9-git-send-email-james@...515...>
Subject: Re: [Openvpn-devel] [PATCH 09/10] Added directive to specify HTTP
 proxy credentials in config.
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
To: James Yonan <james@...515...>, openvpn-devel@lists.sourceforge.net



Am 03.03.16 um 09:19 schrieb James Yonan:
> The inline directive http-proxy-user-pass can be used to
> specify proxy credentials in config, e.g.:
>
> http-proxy proxy.tld 3128 auto-nct
> <http-proxy-user-pass>
> foo
> bar
> </http-proxy-user-pass>
>
> This usage is already supported by OpenVPN 3.
>
ACK. But it really should come with manpage (and a short note in
Changes.rst)

Arne


