Message-ID: <53550214.9080607@...1227...>
Date: Mon, 21 Apr 2014 13:33:40 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1398064204-26476-1-git-send-email-james@...515...>
In-Reply-To: <1398064204-26476-1-git-send-email-james@...515...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] Added "remote-override" config
	directive.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: James Yonan <james@...515...>, openvpn-devel@lists.sourceforge.net

On 21.04.2014 09:10, James Yonan wrote:
> remote-override <alt-remote> -- replace the hostname in all remote
> directives with alt-remote.
>
Just a question. How does remote-override differ from ip-remote-hint? 
Both options seem to have the same effect aside from very subtle 
differences. Perhaps we should add this as an alias for the already 
existing option.

Arne

